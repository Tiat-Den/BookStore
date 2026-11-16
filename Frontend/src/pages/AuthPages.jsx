import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { BookOpen, Lock, Mail, User, Phone, AlertCircle } from 'lucide-react';
import { GoogleLogin } from '@react-oauth/google';
import { useAuth } from '../context/AuthContext';

export const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [googleLoading, setGoogleLoading] = useState(false);
  const { login, loginWithGoogle } = useAuth();
  const navigate = useNavigate();

  const handleGoogleSuccess = async (credentialResponse) => {
    if (!credentialResponse?.credential) {
      setError('Không nhận được thông tin xác thực từ Google.');
      return;
    }
    setGoogleLoading(true);
    setError('');
    try {
      const res = await loginWithGoogle(credentialResponse.credential);
      if (res.success) {
        navigate('/');
      } else {
        setError(res.message || 'Đăng nhập Google thất bại.');
      }
    } catch (err) {
      setError(err?.message || 'Có lỗi xảy ra khi xác thực Google.');
    } finally {
      setGoogleLoading(false);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    try {
      const res = await login(email, password);
      if (res.success) {
        navigate('/');
      } else {
        setError(res.message || 'Email hoặc mật khẩu không chính xác.');
      }
    } catch (err) {
      setError(err?.message || 'Email hoặc mật khẩu không chính xác.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container" style={{ padding: '60px 20px', display: 'flex', justifyContent: 'center' }}>
      <div className="card" style={{ width: '100%', maxWidth: '440px', padding: '36px' }}>
        <div style={{ textAlign: 'center', marginBottom: '28px' }}>
          <div style={{ background: 'var(--primary)', width: '48px', height: '48px', borderRadius: '12px', display: 'inline-flex', alignItems: 'center', justifyContent: 'center', color: '#fff', marginBottom: '12px' }}>
            <BookOpen size={24} />
          </div>
          <h2 style={{ fontSize: '24px', fontWeight: '800' }}>Đăng Nhập</h2>
          <p style={{ fontSize: '13px', color: 'var(--text-muted)', marginTop: '4px' }}>
            Chào mừng bạn quay lại hệ thống BookStore
          </p>
        </div>

        {error && (
          <div style={{ backgroundColor: '#fee2e2', color: 'var(--danger)', padding: '12px 14px', borderRadius: 'var(--radius)', marginBottom: '20px', fontSize: '13px', display: 'flex', alignItems: 'center', gap: '8px' }}>
            <AlertCircle size={16} />
            <span>{error}</span>
          </div>
        )}

        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label className="form-label">Email tài khoản</label>
            <div style={{ position: 'relative' }}>
              <input
                type="email"
                className="input"
                required
                placeholder="example@bookstore.com"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                style={{ paddingLeft: '38px' }}
              />
              <Mail size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
            </div>
          </div>

          <div className="form-group" style={{ marginBottom: '24px' }}>
            <label className="form-label">Mật khẩu</label>
            <div style={{ position: 'relative' }}>
              <input
                type="password"
                className="input"
                required
                placeholder="••••••••"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                style={{ paddingLeft: '38px' }}
              />
              <Lock size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
            </div>
          </div>

          <button
            type="submit"
            disabled={loading || googleLoading}
            className="btn btn-primary"
            style={{ width: '100%', padding: '12px' }}
          >
            {loading ? 'Đang xác thực...' : 'Đăng Nhập'}
          </button>

          <div style={{ textAlign: 'center', marginTop: '16px' }}>
            <Link to="/forgot-password" style={{ fontSize: '13px', color: 'var(--primary)', fontWeight: '600', textDecoration: 'none' }}>
              Quên mật khẩu?
            </Link>
          </div>
        </form>

        <div style={{ display: 'flex', alignItems: 'center', margin: '20px 0', gap: '10px' }}>
          <div style={{ flex: 1, height: '1px', background: 'var(--border)' }}></div>
          <span style={{ fontSize: '12px', color: 'var(--text-muted)', fontWeight: '600' }}>HOẶC</span>
          <div style={{ flex: 1, height: '1px', background: 'var(--border)' }}></div>
        </div>

        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', minHeight: '44px', justifyContent: 'center' }}>
          {googleLoading ? (
            <div style={{ fontSize: '13px', color: 'var(--primary)', fontWeight: '600', display: 'flex', alignItems: 'center', gap: '8px' }}>
              <span className="spinner" style={{ display: 'inline-block', width: '16px', height: '16px', border: '2px solid var(--primary)', borderTopColor: 'transparent', borderRadius: '50%', animation: 'spin 1s linear infinite' }}></span>
              Đang xác thực với Google...
            </div>
          ) : (
            <GoogleLogin
              onSuccess={handleGoogleSuccess}
              onError={() => setError('Đăng nhập Google thất bại. Vui lòng thử lại!')}
              shape="rectangular"
              theme="outline"
              size="large"
              text="signin_with"
            />
          )}
        </div>

        <div style={{ textAlign: 'center', marginTop: '20px', fontSize: '13px', color: 'var(--text-muted)' }}>
          Chưa có tài khoản?{' '}
          <Link to="/register" style={{ color: 'var(--primary)', fontWeight: '700' }}>
            Đăng ký ngay
          </Link>
        </div>
      </div>
    </div>
  );
};

export const Register = () => {
  const [formData, setFormData] = useState({
    fullName: '',
    email: '',
    phone: '',
    password: '',
    confirmPassword: ''
  });
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [googleLoading, setGoogleLoading] = useState(false);
  const { register, loginWithGoogle } = useAuth();
  const navigate = useNavigate();

  const handleGoogleSuccess = async (credentialResponse) => {
    if (!credentialResponse?.credential) {
      setError('Không nhận được thông tin xác thực từ Google.');
      return;
    }
    setGoogleLoading(true);
    setError('');
    try {
      const res = await loginWithGoogle(credentialResponse.credential);
      if (res.success) {
        navigate('/');
      } else {
        setError(res.message || 'Đăng nhập Google thất bại.');
      }
    } catch (err) {
      setError(err?.message || 'Có lỗi xảy ra khi xác thực Google.');
    } finally {
      setGoogleLoading(false);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');

    if (formData.password !== formData.confirmPassword) {
      setError('Mật khẩu xác nhận không khớp.');
      return;
    }

    setLoading(true);
    try {
      const res = await register(formData.fullName, formData.email, formData.phone, formData.password);
      if (res.success) {
        navigate('/');
      } else {
        setError(res.message || 'Đăng ký tài khoản không thành công.');
      }
    } catch (err) {
      setError(err?.message || 'Đăng ký tài khoản không thành công.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container" style={{ padding: '60px 20px', display: 'flex', justifyContent: 'center' }}>
      <div className="card" style={{ width: '100%', maxWidth: '480px', padding: '36px' }}>
        <div style={{ textAlign: 'center', marginBottom: '28px' }}>
          <div style={{ background: 'var(--primary)', width: '48px', height: '48px', borderRadius: '12px', display: 'inline-flex', alignItems: 'center', justifyContent: 'center', color: '#fff', marginBottom: '12px' }}>
            <BookOpen size={24} />
          </div>
          <h2 style={{ fontSize: '24px', fontWeight: '800' }}>Tạo Tài Khoản</h2>
          <p style={{ fontSize: '13px', color: 'var(--text-muted)', marginTop: '4px' }}>
            Đăng ký để mua sách và tích lũy ưu đãi hấp dẫn
          </p>
        </div>

        {error && (
          <div style={{ backgroundColor: '#fee2e2', color: 'var(--danger)', padding: '12px 14px', borderRadius: 'var(--radius)', marginBottom: '20px', fontSize: '13px', display: 'flex', alignItems: 'center', gap: '8px' }}>
            <AlertCircle size={16} />
            <span>{error}</span>
          </div>
        )}

        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label className="form-label">Họ và tên *</label>
            <div style={{ position: 'relative' }}>
              <input
                type="text"
                className="input"
                required
                placeholder="Nguyễn Văn A"
                value={formData.fullName}
                onChange={(e) => setFormData({ ...formData, fullName: e.target.value })}
                style={{ paddingLeft: '38px' }}
              />
              <User size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
            </div>
          </div>

          <div className="form-group">
            <label className="form-label">Email *</label>
            <div style={{ position: 'relative' }}>
              <input
                type="email"
                className="input"
                required
                placeholder="email@example.com"
                value={formData.email}
                onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                style={{ paddingLeft: '38px' }}
              />
              <Mail size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
            </div>
          </div>

          <div className="form-group">
            <label className="form-label">Số điện thoại</label>
            <div style={{ position: 'relative' }}>
              <input
                type="tel"
                className="input"
                placeholder="0912345678"
                value={formData.phone}
                onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
                style={{ paddingLeft: '38px' }}
              />
              <Phone size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
            </div>
          </div>

          <div className="form-group">
            <label className="form-label">Mật khẩu *</label>
            <div style={{ position: 'relative' }}>
              <input
                type="password"
                className="input"
                required
                minLength={6}
                placeholder="Tối thiểu 6 ký tự"
                value={formData.password}
                onChange={(e) => setFormData({ ...formData, password: e.target.value })}
                style={{ paddingLeft: '38px' }}
              />
              <Lock size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
            </div>
          </div>

          <div className="form-group" style={{ marginBottom: '24px' }}>
            <label className="form-label">Xác nhận mật khẩu *</label>
            <div style={{ position: 'relative' }}>
              <input
                type="password"
                className="input"
                required
                minLength={6}
                placeholder="Nhập lại mật khẩu"
                value={formData.confirmPassword}
                onChange={(e) => setFormData({ ...formData, confirmPassword: e.target.value })}
                style={{ paddingLeft: '38px' }}
              />
              <Lock size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
            </div>
          </div>

          <button
            type="submit"
            disabled={loading || googleLoading}
            className="btn btn-primary"
            style={{ width: '100%', padding: '12px' }}
          >
            {loading ? 'Đang đăng ký...' : 'Đăng Ký Tài Khoản'}
          </button>
        </form>

        <div style={{ display: 'flex', alignItems: 'center', margin: '20px 0', gap: '10px' }}>
          <div style={{ flex: 1, height: '1px', background: 'var(--border)' }}></div>
          <span style={{ fontSize: '12px', color: 'var(--text-muted)', fontWeight: '600' }}>HOẶC</span>
          <div style={{ flex: 1, height: '1px', background: 'var(--border)' }}></div>
        </div>

        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', minHeight: '44px', justifyContent: 'center' }}>
          {googleLoading ? (
            <div style={{ fontSize: '13px', color: 'var(--primary)', fontWeight: '600', display: 'flex', alignItems: 'center', gap: '8px' }}>
              <span className="spinner" style={{ display: 'inline-block', width: '16px', height: '16px', border: '2px solid var(--primary)', borderTopColor: 'transparent', borderRadius: '50%', animation: 'spin 1s linear infinite' }}></span>
              Đang xác thực với Google...
            </div>
          ) : (
            <GoogleLogin
              onSuccess={handleGoogleSuccess}
              onError={() => setError('Đăng ký / Đăng nhập Google thất bại. Vui lòng thử lại!')}
              shape="rectangular"
              theme="outline"
              size="large"
              text="signup_with"
            />
          )}
        </div>

        <div style={{ textAlign: 'center', marginTop: '24px', fontSize: '13px', color: 'var(--text-muted)' }}>
          Đã có tài khoản?{' '}
          <Link to="/login" style={{ color: 'var(--primary)', fontWeight: '700' }}>
            Đăng nhập
          </Link>
        </div>
      </div>
    </div>
  );
};
