import React, { useEffect, useState } from 'react';

const UserTable = () => {
  const [users, setUsers] = useState([]);
  const [searchId, setSearchId] = useState('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [newUser, setNewUser] = useState({ Username: '', Password: '', Roles: 'Guest' });

  const fetchAll = () => {
    setLoading(true);
    fetch('http://localhost:3000/user/all')
      .then(res => res.ok ? res.json() : Promise.reject())
      .then(data => {
        setUsers(data.users || []);
        setLoading(false);
      })
      .catch(() => {
        setError("Connection failed");
        setLoading(false);
      });
  };

  // Helper to determine badge styling based on role
  const getRoleStyles = (role) => {
    const isPrivileged = role === 'Administrator' || role === 'Superadmin';
    if (isPrivileged) {
      return "border-green-100 bg-green-50/30 text-green-600";
    }
    return "border-red-100 bg-red-50/30 text-red-500";
  };

  const handleSearch = (e) => {
    e.preventDefault();
    if (!searchId) { fetchAll(); return; }
    setLoading(true);
    fetch(`http://localhost:3000/user/${searchId}`)
      .then(res => res.ok ? res.json() : Promise.reject("User not found"))
      .then(data => {
        setUsers(data.user ? [data.user] : []);
        setLoading(false);
        setError(null);
      })
      .catch(err => { setError(err); setLoading(false); });
  };

  const handleCreate = (e) => {
    e.preventDefault();
    fetch('http://localhost:3000/user', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(newUser)
    })
      .then(res => {
        if (res.ok) {
          setNewUser({ Username: '', Password: '', Roles: 'Guest' });
          fetchAll();
        } else {
          alert("Creation failed.");
        }
      })
      .catch(err => console.error(err));
  };

  const handleDelete = (uid) => {
    if (!window.confirm(`Permanently remove node #${uid}?`)) return;
    fetch(`http://localhost:3000/user/${uid}`, { method: 'DELETE' })
      .then(res => res.ok ? fetchAll() : alert("Delete failed"))
      .catch(err => console.error(err));
  };

  const handleResetPassword = (uid) => {
    const newPassword = window.prompt(`Enter new password for node #${uid}:`);
    if (!newPassword) return;
    fetch(`http://localhost:3000/user?uid=${uid}&password=${encodeURIComponent(newPassword)}`, {
      method: 'PATCH'
    })
      .then(res => res.ok ? fetchAll() : alert("Update failed"))
      .catch(err => console.error(err));
  };

  useEffect(() => fetchAll(), []);

  return (
    <div className="w-full min-h-screen bg-white font-sans antialiased text-slate-900">
      
      {/* Top Action Bar */}
      <div className="w-full px-12 py-8 border-b border-slate-100 bg-white flex flex-col md:flex-row justify-between items-center gap-6">
        
        {/* CREATE USER FORM */}
        <form onSubmit={handleCreate} className="flex items-center gap-3">
          <input 
            type="text"
            placeholder="Username"
            className="px-3 py-2 bg-slate-50 border border-slate-200 rounded text-xs font-light focus:outline-none focus:border-blue-400 w-36"
            value={newUser.Username}
            onChange={(e) => setNewUser({...newUser, Username: e.target.value})}
            required
          />
          <input 
            type="password"
            placeholder="Password"
            className="px-3 py-2 bg-slate-50 border border-slate-200 rounded text-xs font-light focus:outline-none focus:border-blue-400 w-36"
            value={newUser.Password}
            onChange={(e) => setNewUser({...newUser, Password: e.target.value})}
            required
          />
          
          <select 
            className="px-3 py-2 bg-slate-50 border border-slate-200 rounded text-xs font-light focus:outline-none focus:border-blue-400 w-36 appearance-none cursor-pointer"
            value={newUser.Roles}
            onChange={(e) => setNewUser({...newUser, Roles: e.target.value})}
          >
            <option value="Guest">Guest</option>
            <option value="Administrator">Administrator</option>
            <option value="Superadmin">Superadmin</option>
          </select>

          <button type="submit" className="px-4 py-2 bg-blue-600 text-white text-[10px] uppercase tracking-widest font-bold rounded hover:bg-blue-700 transition-all">
            Add Node
          </button>
        </form>

        {/* SEARCH FORM */}
        <form onSubmit={handleSearch} className="flex items-center gap-3">
          <input 
            type="number"
            placeholder="Query UID..."
            className="px-4 py-2 bg-slate-50 border border-slate-200 rounded focus:outline-none focus:border-red-400 transition-all text-sm font-light w-40 appearance-none [&::-webkit-inner-spin-button]:appearance-none"
            value={searchId}
            onChange={(e) => setSearchId(e.target.value)}
          />
          <button type="submit" className="px-5 py-2 bg-slate-900 text-white text-[10px] uppercase tracking-widest font-bold rounded hover:bg-red-600 transition-all">
            Search
          </button>
          {searchId && <button type="button" onClick={() => {setSearchId(''); fetchAll();}} className="text-[10px] uppercase tracking-widest text-slate-400 hover:text-red-500 ml-2">Reset</button>}
        </form>
      </div>

      {/* TABLE SECTION */}
      <div className="w-full">
        {loading ? (
          <div className="p-20 text-center font-light text-slate-300 text-xs tracking-widest uppercase">Syncing...</div>
        ) : error ? (
          <div className="p-20 text-center text-red-400 font-light text-sm">{error}</div>
        ) : (
          <table className="w-full text-left border-collapse table-fixed">
            <thead>
              <tr className="border-b border-slate-50 bg-slate-50/30">
                <th className="w-[8%] px-12 py-4 text-[10px] uppercase tracking-[0.3em] font-semibold text-slate-400">ID</th>
                <th className="w-[20%] px-12 py-4 text-[10px] uppercase tracking-[0.3em] font-semibold text-slate-400">Username</th>
                <th className="w-[25%] px-12 py-4 text-[10px] uppercase tracking-[0.3em] font-semibold text-slate-400">Password</th>
                <th className="w-[22%] px-12 py-4 text-[10px] uppercase tracking-[0.3em] font-semibold text-slate-400">Role</th>
                <th className="w-[25%] px-12 py-4 text-[10px] uppercase tracking-[0.3em] font-semibold text-slate-400 text-right">Commands</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50">
              {users.map((user, idx) => (
                <tr key={user.Uid || idx} className="hover:bg-slate-50/50 transition-all duration-200">
                  <td className="px-12 py-6 text-sm font-light text-slate-400">#{user.Uid}</td>
                  <td className="px-12 py-6 text-base font-normal text-slate-700 tracking-tight">{user.Username}</td>
                  <td className="px-12 py-6 text-sm font-mono text-slate-400 truncate">{user.Password}</td>
                  <td className="px-12 py-6">
                    {/* DYNAMIC STYLING BASED ON ROLE */}
                    <span className={`text-[10px] font-medium tracking-widest py-1 px-3 rounded border uppercase ${getRoleStyles(user.Roles)}`}>
                      {user.Roles || 'Guest'}
                    </span>
                  </td>
                  <td className="px-12 py-6">
                    <div className="flex flex-col items-end gap-2">
                      <button onClick={() => handleResetPassword(user.Uid)} className="text-[9px] uppercase tracking-widest text-slate-400 hover:text-blue-500 font-bold transition-colors">Reset Password</button>
                      <button onClick={() => handleDelete(user.Uid)} className="text-[9px] uppercase tracking-widest text-slate-300 hover:text-red-600 font-bold transition-colors">Remove User</button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  );
};

export default UserTable;
