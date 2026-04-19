package main

import (
	"log"
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"

	_ "github.com/go-sql-driver/mysql"

	_ "github.com/joho/godotenv/autoload"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
	httpRequestsTotal = prometheus.NewCounterVec(
		prometheus.CounterOpts{
			Name: "http_requests_total",
			Help: "Total number of HTTP requests",
		},
		[]string{"method", "path", "status"},
	)

	httpRequestDuration = prometheus.NewHistogramVec(
		prometheus.HistogramOpts{
			Name:    "http_request_duration_seconds",
			Help:    "HTTP request duration in seconds",
			Buckets: prometheus.DefBuckets,
		},
		[]string{"method", "path"},
	)
)

func init() {
	prometheus.MustRegister(httpRequestsTotal)
	prometheus.MustRegister(httpRequestDuration)
}

func MetricsMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		start := time.Now()

		c.Next()

		duration := time.Since(start).Seconds()
		status := strconv.Itoa(c.Writer.Status())

		httpRequestsTotal.WithLabelValues(c.Request.Method, c.FullPath(), status).Inc()
		httpRequestDuration.WithLabelValues(c.Request.Method, c.FullPath()).Observe(duration)
	}
}

func main() {
	// Start prometheus metrics server on port 9091
	go func() {
		http.Handle("/metrics", promhttp.Handler())
		log.Println("Starting prometheus metrics server on :9091")
		if err := http.ListenAndServe(":9091", nil); err != nil {
			log.Fatalf("prometheus metrics server failed: %s", err)
		}
	}()

	router := gin.Default()

	// for prometheus metrics
	router.Use(MetricsMiddleware())

	// for CORS shit, to allow PATCH
	router.Use(func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		// Ensure PATCH and DELETE are explicitly allowed
		c.Writer.Header().Set("Access-Control-Allow-Methods", "GET, POST, PATCH, DELETE, OPTIONS")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization")

		// Handle the OPTIONS preflight request
		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(204) // Return 204 No Content to tell browser it's okay
			return
		}

		c.Next()
	})

	client, err := RPCClient()
	if err != nil {
		log.Fatalf("failed creating RPC client, err: %s\n", err)
	}
	defer client.Close()

	userService := RPCUserClient{Client: client}

	router.Static("/cwd", "./")
	router.GET("/user/:uid", Get(&userService)) // will be fixed after implementing the rest of the controller methods
	router.GET("/user/all", GetAll(&userService))
	router.PATCH("/user", Patch(&userService))
	router.DELETE("/user/:uid", Delete(&userService))
	router.POST("/user", Post(&userService))

	router.Run(":3001")
}
