import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { User, Mail, Phone, Lock, Shield, CheckCircle, AlertCircle, ShoppingBag, Heart, ArrowLeft, KeyRound, Save, MapPin } from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import { authService } from '../services/authService';

export const Profile = () => {
  const { user, updateProfile, isAdmin, isManager } = useAuth();

  // Profile Form state
  const [profileData, setProfileData] = useState({
    fullName: user?.fullName || '',
    phone: user?.phone || '',
    address: user?.address || ''
  });
  const [profileSaving, setProfileSaving] = useState(false);
  const [profileMsg, setProfileMsg] = useState({ type: '', text: '' });

  useEffect(() => {
    if (user) {
      setProfileData({
        fullName: user.fullName || '',
        phone: user.phone || '',
        address: user.address || ''
      });
    }
  }, [user]);

  // Password Form state
  const [passwordData, setPasswordData] = useState({
    currentPassword: '',
    newPassword: '',
    confirmPassword: ''
  });
  const [passwordSaving, setPasswordSaving] = useState(false);
  const [passwordMsg, setPasswordMsg] = useState({ type: '', text: '' });

  const handleUpdateProfile = async (e) => {
    e.preventDefault();
    if (!profileData.fullName.trim()) {
      setProfileMsg({ type: 'error', text: 'Họ và tên không được để trống.' });
      return;
    }

    setProfileSaving(true);
    setProfileMsg({ type: '', text: '' });

    try {
      const res = await updateProfile({
        fullName: profileData.fullName.trim(),
        phone: profileData.phone ? profileData.phone.trim() : null,
        address: profileData.address ? profileData.address.trim() : null
      });

      if (res.success) {
        setProfileMsg({ type: 'success', text: 'Cập nhật thông tin tài khoản thành công!' });
      } else {
        setProfileMsg({ type: 'error', text: res.message || 'Cập nhật thất bại.' });
      }
    } catch (err) {
      setProfileMsg({ type: 'error', text: err.message || 'Lỗi khi cập nhật thông tin.' });
    } finally {
      setProfileSaving(false);
    }
  };

  const handleChangePassword = async (e) => {
    e.preventDefault();
    setPasswordMsg({ type: '', text: '' });

    if (!passwordData.currentPassword) {
      setPasswordMsg({ type: 'error', text: 'Vui lòng nhập mật khẩu hiện tại.' });
      return;
    }

    if (passwordData.newPassword.length < 6) {
      setPasswordMsg({ type: 'error', text: 'Mật khẩu mới phải có tối thiểu 6 ký tự.' });
      return;
    }

    if (passwordData.newPassword !== passwordData.confirmPassword) {
      setPasswordMsg({ type: 'error', text: 'Xác nhận mật khẩu mới không trùng khớp.' });
      return;
    }

    setPasswordSaving(true);
    try {
      const res = await authService.changePassword(passwordData.currentPassword, passwordData.newPassword);
      if (res.success) {
        setPasswordMsg({ type: 'success', text: 'Đổi mật khẩu thành công!' });
        setPasswordData({ currentPassword: '', newPassword: '', confirmPassword: '' });
      } else {
        setPasswordMsg({ type: 'error', text: res.message || 'Đổi mật khẩu thất bại.' });
      }
    } catch (err) {
      setPasswordMsg({ type: 'error', text: err.message || 'Lỗi khi đổi mật khẩu.' });
    } finally {
      setPasswordSaving(false);
    }
  };

  return (
    <div className="container" style={{ padding: '36px 20px', maxWidth: '960px' }}>
      {/* Header Bar */}
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '28px', flexWrap: 'wrap', gap: '16px' }}>
        <div>
          <h1 style={{ fontSize: '26px', fontWeight: '800' }}>Thông Tin Tài Khoản</h1>
          <p style={{ fontSize: '14px', color: 'var(--text-muted)' }}>Quản lý thông tin cá nhân và bảo mật tài khoản của bạn</p>
        </div>

        <div style={{ display: 'flex', gap: '10px' }}>
          <Link to="/orders" className="btn btn-outline btn-sm" style={{ display: 'inline-flex', alignItems: 'center', gap: '6px' }}>
            <ShoppingBag size={15} /> Đơn hàng của tôi
          </Link>
          <Link to="/wishlist" className="btn btn-outline btn-sm" style={{ display: 'inline-flex', alignItems: 'center', gap: '6px' }}>
            <Heart size={15} color="var(--danger)" /> Yêu thích
          </Link>
        </div>
      </div>

      {/* User Overview Card */}
      <div className="card" style={{ padding: '24px', marginBottom: '28px', display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '20px' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '18px' }}>
          <div style={{
            width: '64px',
            height: '64px',
            borderRadius: '50%',
            backgroundColor: 'var(--primary-light)',
            color: 'var(--primary)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            fontSize: '24px',
            fontWeight: '800',
            border: '2px solid #bfdbfe'
          }}>
            {user?.fullName?.charAt(0)?.toUpperCase() || 'U'}
          </div>

          <div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '10px', flexWrap: 'wrap' }}>
              <h2 style={{ fontSize: '18px', fontWeight: '700' }}>{user?.fullName}</h2>
              {user?.roles?.map((r) => (
                <span
                  key={r}
                  style={{
                    fontSize: '11px',
                    fontWeight: '700',
                    padding: '2px 8px',
                    borderRadius: '4px',
                    backgroundColor: r === 'ADMIN' ? '#eff6ff' : r === 'EMPLOYEE' ? '#f0fdf4' : '#f8fafc',
                    color: r === 'ADMIN' ? 'var(--primary)' : r === 'EMPLOYEE' ? '#16a34a' : 'var(--text-muted)',
                    border: '1px solid var(--border)'
                  }}
                >
                  {r}
                </span>
              ))}
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px', flexWrap: 'wrap', marginTop: '6px', fontSize: '13px', color: 'var(--text-muted)' }}>
              <span>{user?.email}</span>
              {user?.phone && (
                <>
                  <span>•</span>
                  <span>{user.phone}</span>
                </>
              )}
              {user?.address && (
                <>
                  <span>•</span>
                  <span style={{ display: 'inline-flex', alignItems: 'center', gap: '4px', color: '#475569' }}>
                    <MapPin size={13} color="var(--primary)" /> {user.address}
                  </span>
                </>
              )}
            </div>
          </div>
        </div>

        {/* Quick Portal Switch */}
        {isAdmin && (
          <Link to="/admin" className="btn btn-primary btn-sm">
            <Shield size={15} /> Tới Trang Quản Trị
          </Link>
        )}
        {!isAdmin && isManager && (
          <Link to="/employee" className="btn btn-secondary btn-sm" style={{ backgroundColor: '#16a34a' }}>
            <Shield size={15} /> Tới Kênh Nhân Viên
          </Link>
        )}
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(340px, 1fr))', gap: '24px' }}>
        {/* Profile Information Form */}
        <div className="card" style={{ padding: '28px' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '20px', borderBottom: '1px solid var(--border)', paddingBottom: '12px' }}>
            <User size={20} color="var(--primary)" />
            <h3 style={{ fontSize: '16px', fontWeight: '700' }}>Cập Nhật Thông Tin Cá Nhân</h3>
          </div>

          {profileMsg.text && (
            <div style={{
              display: 'flex',
              alignItems: 'center',
              gap: '8px',
              padding: '10px 14px',
              borderRadius: 'var(--radius)',
              marginBottom: '16px',
              fontSize: '13px',
              fontWeight: '600',
              backgroundColor: profileMsg.type === 'success' ? '#f0fdf4' : '#fef2f2',
              color: profileMsg.type === 'success' ? '#16a34a' : '#dc2626',
              border: `1px solid ${profileMsg.type === 'success' ? '#bbf7d0' : '#fecaca'}`
            }}>
              {profileMsg.type === 'success' ? <CheckCircle size={16} /> : <AlertCircle size={16} />}
              {profileMsg.text}
            </div>
          )}

          <form onSubmit={handleUpdateProfile}>
            <div className="form-group">
              <label className="form-label">Họ và tên *</label>
              <div style={{ position: 'relative' }}>
                <input
                  type="text"
                  className="input"
                  required
                  placeholder="Nhập họ và tên đầy đủ..."
                  value={profileData.fullName}
                  onChange={(e) => setProfileData({ ...profileData, fullName: e.target.value })}
                  style={{ paddingLeft: '38px' }}
                />
                <User size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
              </div>
            </div>

            <div className="form-group">
              <label className="form-label">Email tài khoản</label>
              <div style={{ position: 'relative' }}>
                <input
                  type="email"
                  className="input"
                  disabled
                  value={user?.email || ''}
                  style={{ paddingLeft: '38px', backgroundColor: '#f8fafc', color: 'var(--text-muted)', cursor: 'not-allowed' }}
                />
                <Mail size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
              </div>
              <small style={{ fontSize: '11px', color: 'var(--text-muted)', marginTop: '4px', display: 'block' }}>
                Email được dùng làm định danh đăng nhập và không thể thay đổi
              </small>
            </div>

            <div className="form-group">
              <label className="form-label">Số điện thoại</label>
              <div style={{ position: 'relative' }}>
                <input
                  type="tel"
                  className="input"
                  placeholder="Nhập số điện thoại liên lạc..."
                  value={profileData.phone}
                  onChange={(e) => setProfileData({ ...profileData, phone: e.target.value })}
                  style={{ paddingLeft: '38px' }}
                />
                <Phone size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
              </div>
            </div>

            <div className="form-group">
              <label className="form-label">Địa chỉ nhận hàng mặc định</label>
              <div style={{ position: 'relative' }}>
                <textarea
                  className="textarea"
                  rows="2"
                  placeholder="Nhập địa chỉ giao hàng (Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố)..."
                  value={profileData.address}
                  onChange={(e) => setProfileData({ ...profileData, address: e.target.value })}
                  style={{ paddingLeft: '38px', minHeight: '76px', resize: 'vertical' }}
                />
                <MapPin size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '12px' }} />
              </div>
              <small style={{ fontSize: '11px', color: 'var(--text-muted)', marginTop: '4px', display: 'block' }}>
                Địa chỉ này sẽ tự động được sử dụng khi bạn đặt mua sách tại trang Thanh toán
              </small>
            </div>

            <button
              type="submit"
              disabled={profileSaving}
              className="btn btn-primary"
              style={{ width: '100%', marginTop: '8px', display: 'inline-flex', alignItems: 'center', justifyContent: 'center', gap: '8px' }}
            >
              <Save size={16} />
              {profileSaving ? 'Đang lưu...' : 'Lưu Thay Đổi'}
            </button>
          </form>
        </div>

        {/* Change Password Form */}
        <div className="card" style={{ padding: '28px' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '20px', borderBottom: '1px solid var(--border)', paddingBottom: '12px' }}>
            <KeyRound size={20} color="var(--primary)" />
            <h3 style={{ fontSize: '16px', fontWeight: '700' }}>Đổi Mật Khẩu</h3>
          </div>

          {passwordMsg.text && (
            <div style={{
              display: 'flex',
              alignItems: 'center',
              gap: '8px',
              padding: '10px 14px',
              borderRadius: 'var(--radius)',
              marginBottom: '16px',
              fontSize: '13px',
              fontWeight: '600',
              backgroundColor: passwordMsg.type === 'success' ? '#f0fdf4' : '#fef2f2',
              color: passwordMsg.type === 'success' ? '#16a34a' : '#dc2626',
              border: `1px solid ${passwordMsg.type === 'success' ? '#bbf7d0' : '#fecaca'}`
            }}>
              {passwordMsg.type === 'success' ? <CheckCircle size={16} /> : <AlertCircle size={16} />}
              {passwordMsg.text}
            </div>
          )}

          <form onSubmit={handleChangePassword}>
            <div className="form-group">
              <label className="form-label">Mật khẩu hiện tại *</label>
              <div style={{ position: 'relative' }}>
                <input
                  type="password"
                  className="input"
                  required
                  placeholder="Nhập mật khẩu hiện tại..."
                  value={passwordData.currentPassword}
                  onChange={(e) => setPasswordData({ ...passwordData, currentPassword: e.target.value })}
                  style={{ paddingLeft: '38px' }}
                />
                <Lock size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
              </div>
            </div>

            <div className="form-group">
              <label className="form-label">Mật khẩu mới *</label>
              <div style={{ position: 'relative' }}>
                <input
                  type="password"
                  className="input"
                  required
                  placeholder="Mật khẩu mới (tối thiểu 6 ký tự)..."
                  value={passwordData.newPassword}
                  onChange={(e) => setPasswordData({ ...passwordData, newPassword: e.target.value })}
                  style={{ paddingLeft: '38px' }}
                />
                <Lock size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
              </div>
            </div>

            <div className="form-group">
              <label className="form-label">Xác nhận mật khẩu mới *</label>
              <div style={{ position: 'relative' }}>
                <input
                  type="password"
                  className="input"
                  required
                  placeholder="Nhập lại mật khẩu mới..."
                  value={passwordData.confirmPassword}
                  onChange={(e) => setPasswordData({ ...passwordData, confirmPassword: e.target.value })}
                  style={{ paddingLeft: '38px' }}
                />
                <Lock size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
              </div>
            </div>

            <button
              type="submit"
              disabled={passwordSaving}
              className="btn btn-outline"
              style={{ width: '100%', marginTop: '8px', display: 'inline-flex', alignItems: 'center', justifyContent: 'center', gap: '8px' }}
            >
              <KeyRound size={16} />
              {passwordSaving ? 'Đang đổi mật khẩu...' : 'Cập Nhật Mật Khẩu'}
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};
