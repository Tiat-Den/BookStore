import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { Users, UserPlus, Lock, Unlock, Shield, Search, CheckCircle, AlertTriangle, X } from 'lucide-react';
import { userService } from '../../services/catalogAndOrderServices';
import { useAuth } from '../../context/AuthContext';
import { LoadingSpinner } from '../../components/UIComponents';
import { ManagementHeader } from './AdminPages';

export const AdminUsers = () => {
  const { user: currentUser } = useAuth();
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [totalCount, setTotalCount] = useState(0);
  const [filterRole, setFilterRole] = useState('');
  const [keyword, setKeyword] = useState('');
  const [showModal, setShowModal] = useState(false);
  const [msg, setMsg] = useState({ text: '', type: '' });

  const [formData, setFormData] = useState({
    fullName: '',
    email: '',
    phone: '',
    password: ''
  });

  const fetchUsers = async () => {
    try {
      setLoading(true);
      const res = await userService.getUsers({
        role: filterRole,
        keyword: keyword.trim(),
        page: 1,
        pageSize: 50
      });
      if (res.success && res.data) {
        setUsers(res.data.items);
        setTotalCount(res.data.totalCount);
      }
    } catch (err) {
      console.error('Lỗi khi tải danh sách người dùng:', err);
      setMsg({ text: 'Không thể tải danh sách người dùng.', type: 'error' });
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, [filterRole]);

  const handleSearch = (e) => {
    e.preventDefault();
    fetchUsers();
  };

  const handleCreateEmployee = async (e) => {
    e.preventDefault();
    try {
      const res = await userService.createEmployee(formData);
      if (res.success) {
        setMsg({ text: 'Đã tạo tài khoản nhân viên mới thành công!', type: 'success' });
        setShowModal(false);
        setFormData({ fullName: '', email: '', phone: '', password: '' });
        fetchUsers();
      } else {
        setMsg({ text: res.message || 'Tạo nhân viên thất bại.', type: 'error' });
      }
    } catch (err) {
      setMsg({ text: err.message || 'Lỗi khi tạo nhân viên.', type: 'error' });
    }
  };

  const handleToggleStatus = async (user) => {
    if (user.id === currentUser?.id) {
      alert('Bạn không thể tự khóa tài khoản của chính mình!');
      return;
    }

    const newStatus = user.status === 'Active' ? 'Locked' : 'Active';
    const actionText = newStatus === 'Locked' ? 'KHÓA' : 'MỞ KHÓA';
    
    if (!window.confirm(`Bạn có chắc chắn muốn ${actionText} tài khoản "${user.fullName}" (${user.email})?`)) {
      return;
    }

    try {
      const res = await userService.updateStatus(user.id, newStatus);
      if (res.success) {
        setMsg({ text: `Đã ${actionText.toLowerCase()} tài khoản thành công!`, type: 'success' });
        fetchUsers();
      } else {
        setMsg({ text: res.message || 'Không thể cập nhật trạng thái.', type: 'error' });
      }
    } catch (err) {
      setMsg({ text: err.message || 'Lỗi khi cập nhật trạng thái tài khoản.', type: 'error' });
    }
  };

  return (
    <div className="container" style={{ padding: '36px 20px' }}>
      <ManagementHeader
        title="Quản Lý Tài Khoản"
        subtitle="Quản lý người dùng, phân quyền nhân viên và bảo mật hệ thống"
        activeTab="users"
      />

      {msg.text && (
        <div style={{
          backgroundColor: msg.type === 'success' ? '#dcfce7' : '#fee2e2',
          color: msg.type === 'success' ? '#166534' : 'var(--danger)',
          padding: '12px 18px',
          borderRadius: 'var(--radius)',
          marginBottom: '20px',
          fontSize: '14px',
          fontWeight: '600'
        }}>
          {msg.text}
        </div>
      )}

      {/* Filter and Action Bar */}
      <div className="card" style={{ padding: '20px', marginBottom: '24px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '16px' }}>
          <form onSubmit={handleSearch} style={{ display: 'flex', gap: '12px', flex: 1, maxWidth: '500px' }}>
            <div style={{ position: 'relative', flex: 1 }}>
              <input
                type="text"
                className="input"
                placeholder="Tìm theo họ tên, email, số điện thoại..."
                value={keyword}
                onChange={(e) => setKeyword(e.target.value)}
                style={{ paddingLeft: '38px', height: '40px' }}
              />
              <Search size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '12px' }} />
            </div>
            <button type="submit" className="btn btn-outline btn-sm">Tìm kiếm</button>
          </form>

          <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
            {/* Filter by Role */}
            <select
              className="select"
              value={filterRole}
              onChange={(e) => setFilterRole(e.target.value)}
              style={{ height: '40px' }}
            >
              <option value="">Tất cả vai trò</option>
              <option value="CUSTOMER">Khách hàng (CUSTOMER)</option>
              <option value="EMPLOYEE">Nhân viên (EMPLOYEE)</option>
              <option value="ADMIN">Quản trị viên (ADMIN)</option>
            </select>

            <button
              onClick={() => setShowModal(true)}
              className="btn btn-primary btn-sm"
              style={{ display: 'flex', alignItems: 'center', gap: '6px' }}
            >
              <UserPlus size={16} /> Thêm Nhân Viên
            </button>
          </div>
        </div>
      </div>

      {/* Users Table */}
      <div className="card" style={{ padding: 0, overflow: 'hidden' }}>
        <div style={{ padding: '16px 24px', borderBottom: '1px solid var(--border)', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <strong style={{ fontSize: '15px' }}>Danh sách tài khoản ({totalCount})</strong>
        </div>

        {loading ? (
          <LoadingSpinner text="Đang tải dữ liệu tài khoản..." />
        ) : users.length === 0 ? (
          <div style={{ padding: '48px 20px', textAlign: 'center', color: 'var(--text-muted)' }}>
            Không tìm thấy tài khoản nào phù hợp với điều kiện tìm kiếm.
          </div>
        ) : (
          <div className="table-responsive">
            <table className="table">
              <thead>
                <tr>
                  <th>Họ và tên</th>
                  <th>Email</th>
                  <th>Số điện thoại</th>
                  <th>Vai trò</th>
                  <th>Trạng thái</th>
                  <th>Ngày tạo</th>
                  <th style={{ textAlign: 'right' }}>Hành động</th>
                </tr>
              </thead>
              <tbody>
                {users.map((u) => {
                  const isCurrent = u.id === currentUser?.id;
                  const isLocked = u.status === 'Locked';
                  const primaryRole = u.roles?.[0] || 'CUSTOMER';

                  return (
                    <tr key={u.id}>
                      <td>
                        <strong>{u.fullName}</strong>
                        {isCurrent && <span style={{ fontSize: '11px', color: 'var(--primary)', marginLeft: '6px' }}>(Bạn)</span>}
                      </td>
                      <td>{u.email}</td>
                      <td>{u.phone || '—'}</td>
                      <td>
                        <span style={{
                          fontSize: '11px',
                          fontWeight: '700',
                          padding: '3px 8px',
                          borderRadius: '4px',
                          background: primaryRole === 'ADMIN' ? '#f3e8ff' : primaryRole === 'EMPLOYEE' ? '#dcfce7' : '#e0f2fe',
                          color: primaryRole === 'ADMIN' ? '#7e22ce' : primaryRole === 'EMPLOYEE' ? '#15803d' : '#0369a1'
                        }}>
                          {primaryRole}
                        </span>
                      </td>
                      <td>
                        <span className={`badge ${isLocked ? 'badge-danger' : 'badge-success'}`}>
                          {isLocked ? 'Đã khóa' : 'Hoạt động'}
                        </span>
                      </td>
                      <td>{new Date(u.createdAt).toLocaleDateString('vi-VN')}</td>
                      <td style={{ textAlign: 'right' }}>
                        {!isCurrent && primaryRole !== 'ADMIN' && (
                          <button
                            onClick={() => handleToggleStatus(u)}
                            className={`btn btn-sm ${isLocked ? 'btn-outline' : 'btn-danger'}`}
                            style={{ padding: '4px 10px', fontSize: '12px' }}
                            title={isLocked ? 'Mở khóa tài khoản' : 'Khóa tài khoản'}
                          >
                            {isLocked ? <><Unlock size={14} /> Mở khóa</> : <><Lock size={14} /> Khóa</>}
                          </button>
                        )}
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* Modal Create Employee */}
      {showModal && (
        <div style={{
          position: 'fixed',
          top: 0, left: 0, right: 0, bottom: 0,
          backgroundColor: 'rgba(0,0,0,0.5)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          zIndex: 1000,
          padding: '20px'
        }}>
          <div className="card" style={{ maxWidth: '480px', width: '100%', padding: '28px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                <Shield size={22} color="var(--primary)" />
                <h3 style={{ fontSize: '18px', fontWeight: '800' }}>Tạo Tài Khoản Nhân Viên Mới</h3>
              </div>
              <button onClick={() => setShowModal(false)} style={{ background: 'none', border: 'none', cursor: 'pointer' }}>
                <X size={20} />
              </button>
            </div>

            <form onSubmit={handleCreateEmployee}>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                <div className="form-group">
                  <label className="form-label">Họ và tên nhân viên *</label>
                  <input
                    type="text"
                    className="input"
                    required
                    placeholder="Ví dụ: Lê Thị B"
                    value={formData.fullName}
                    onChange={(e) => setFormData({ ...formData, fullName: e.target.value })}
                  />
                </div>

                <div className="form-group">
                  <label className="form-label">Email đăng nhập *</label>
                  <input
                    type="email"
                    className="input"
                    required
                    placeholder="nhanvien@bookstore.com"
                    value={formData.email}
                    onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                  />
                </div>

                <div className="form-group">
                  <label className="form-label">Số điện thoại</label>
                  <input
                    type="tel"
                    className="input"
                    placeholder="0912345678"
                    value={formData.phone}
                    onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
                  />
                </div>

                <div className="form-group">
                  <label className="form-label">Mật khẩu ban đầu *</label>
                  <input
                    type="password"
                    className="input"
                    required
                    placeholder="Tối thiểu 6 ký tự"
                    value={formData.password}
                    onChange={(e) => setFormData({ ...formData, password: e.target.value })}
                  />
                </div>
              </div>

              <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '12px', marginTop: '24px' }}>
                <button type="button" onClick={() => setShowModal(false)} className="btn btn-outline">Hủy</button>
                <button type="submit" className="btn btn-primary">Tạo Tài Khoản</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};
