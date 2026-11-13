import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { KeyRound, Mail, Lock, CheckCircle, AlertCircle, ArrowLeft, RefreshCw, Eye, EyeOff, ShieldCheck } from 'lucide-react';
import { authService } from '../services/authService';

export const ForgotPassword = () => {
  const [step, setStep] = useState(1); // 1: Input Email, 2: Input OTP, 3: Input New Password, 4: Success
  const [email, setEmail] = useState('');

  const [otp, setOtp] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);

  const [loading, setLoading] = useState(false);
  const [resending, setResending] = useState(false);
  const [error, setError] = useState('');
  const [infoMsg, setInfoMsg] = useState('');

  const navigate = useNavigate();

  // BƯỚC 1: Yêu cầu gửi mã OTP về Email
  const handleRequestOtp = async (e) => {
    e.preventDefault();
    setError('');
    setInfoMsg('');

    const val = email.trim();
    if (!val) {
      setError('Vui lòng nhập địa chỉ email của bạn.');
      return;
    }

    setLoading(true);
    try {
      const res = await authService.forgotPassword(val);
      if (res.success) {
        setInfoMsg(`Mã xác nhận đã được gửi thành công đến email ${val}. Vui lòng kiểm tra hộp thư.`);
        setStep(2);
      } else {
        setError(res.message || 'Không tìm thấy tài khoản với email này.');
      }
    } catch (err) {
      setError(err.response?.data?.message || err.message || 'Lỗi kết nối máy chủ khi gửi mã xác thực.');
    } finally {
      setLoading(false);
    }
  };

  // Gửi lại mã OTP qua Email
  const handleResendOtp = async () => {
    setError('');
    setInfoMsg('');
    setResending(true);
    try {
      const res = await authService.forgotPassword(email.trim());
      if (res.success) {
        setInfoMsg(`Đã gửi lại mã xác nhận mới tới email ${email.trim()}.`);
      } else {
        setError(res.message || 'Không thể gửi lại mã xác nhận.');
      }
    } catch (err) {
      setError(err.response?.data?.message || err.message || 'Lỗi khi gửi lại mã xác nhận.');
    } finally {
      setResending(false);
    }
  };

  // BƯỚC 2: Kiểm tra xác thực mã OTP
  const handleVerifyOtp = async (e) => {
    e.preventDefault();
    setError('');

    const cleanOtp = otp.trim();
    if (!cleanOtp || cleanOtp.length !== 6) {
      setError('Vui lòng nhập đầy đủ mã xác nhận (OTP) 6 chữ số.');
      return;
    }

    setLoading(true);
    try {
      const res = await authService.verifyOtp(email.trim(), cleanOtp);
      if (res.success) {
        setError('');
        setInfoMsg('');
        setStep(3); // Chuyển sang bước đặt mật khẩu mới
      } else {
        setError(res.message || 'Mã xác nhận không chính xác hoặc đã hết hạn.');
      }
    } catch (err) {
      setError(err.response?.data?.message || err.message || 'Mã xác nhận không hợp lệ hoặc đã hết hạn.');
    } finally {
      setLoading(false);
    }
  };

  // BƯỚC 3: Đặt lại mật khẩu mới
  const handleResetPassword = async (e) => {
    e.preventDefault();
    setError('');

    if (newPassword.length < 6) {
      setError('Mật khẩu mới phải có ít nhất 6 ký tự.');
      return;
    }

    if (newPassword !== confirmPassword) {
      setError('Mật khẩu nhập lại không khớp với mật khẩu mới.');
      return;
    }

    setLoading(true);
    try {
      const res = await authService.resetPassword(email.trim(), otp.trim(), newPassword);
      if (res.success) {
        setError('');
        setInfoMsg('');
        setStep(4); // Hoàn tất thành công
      } else {
        setError(res.message || 'Đặt lại mật khẩu không thành công.');
      }
    } catch (err) {
      setError(err.response?.data?.message || err.message || 'Lỗi kết nối khi đặt lại mật khẩu.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container" style={{ padding: '60px 20px', display: 'flex', justifyContent: 'center' }}>
      <div className="card" style={{ width: '100%', maxWidth: '440px', padding: '36px' }}>
        
        {/* Header Icon */}
        <div style={{ textAlign: 'center', marginBottom: '28px' }}>
          <div style={{ 
            background: step === 4 ? '#10b981' : 'var(--primary)', 
            width: '52px', 
            height: '52px', 
            borderRadius: '14px', 
            display: 'inline-flex', 
            alignItems: 'center', 
            justifyContent: 'center', 
            color: '#fff', 
            marginBottom: '14px',
            boxShadow: '0 4px 14px rgba(37,99,235,0.2)'
          }}>
            {step === 1 && <KeyRound size={26} />}
            {step === 2 && <ShieldCheck size={28} />}
            {step === 3 && <Lock size={26} />}
            {step === 4 && <CheckCircle size={30} />}
          </div>

          <h2 style={{ fontSize: '24px', fontWeight: '800', marginBottom: '6px' }}>
            {step === 1 && 'Quên Mật Khẩu?'}
            {step === 2 && 'Xác Thực Mã OTP'}
            {step === 3 && 'Đặt Lại Mật Khẩu'}
            {step === 4 && 'Hoàn Tất Thành Công!'}
          </h2>

          <p style={{ fontSize: '13px', color: 'var(--text-muted)', lineHeight: '1.5' }}>
            {step === 1 && 'Nhập địa chỉ email của bạn để nhận mã xác thực'}
            {step === 2 && `Mã xác nhận đã được gửi tới email ${email}`}
            {step === 3 && `Thiết lập mật khẩu mới cho tài khoản ${email}`}
            {step === 4 && 'Mật khẩu của bạn đã được cập nhật thành công!'}
          </p>
        </div>

        {/* Thông báo lỗi */}
        {error && (
          <div style={{ 
            backgroundColor: '#fee2e2', 
            color: 'var(--danger)', 
            padding: '12px 14px', 
            borderRadius: 'var(--radius)', 
            marginBottom: '20px', 
            fontSize: '13px', 
            display: 'flex', 
            alignItems: 'center', 
            gap: '8px' 
          }}>
            <AlertCircle size={16} style={{ flexShrink: 0 }} />
            <span>{error}</span>
          </div>
        )}

        {/* Thông báo thông tin (chỉ hiển thị khi gửi lại hoặc hướng dẫn, không hiện dev otp) */}
        {infoMsg && (
          <div style={{ 
            backgroundColor: '#f0fdf4', 
            color: '#15803d', 
            padding: '12px 14px', 
            borderRadius: 'var(--radius)', 
            marginBottom: '20px', 
            fontSize: '13px', 
            display: 'flex', 
            alignItems: 'center', 
            gap: '8px' 
          }}>
            <CheckCircle size={16} style={{ flexShrink: 0 }} />
            <span>{infoMsg}</span>
          </div>
        )}

        {/* =========================================
            BƯỚC 1: NHẬP EMAIL
        ========================================= */}
        {step === 1 && (
          <form onSubmit={handleRequestOtp}>
            <div className="form-group" style={{ marginBottom: '24px' }}>
              <label className="form-label">Email của bạn *</label>
              <div style={{ position: 'relative' }}>
                <input
                  type="email"
                  className="input"
                  required
                  placeholder="example@gmail.com"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  style={{ paddingLeft: '38px' }}
                />
                <Mail size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
              </div>
            </div>

            <button
              type="submit"
              disabled={loading}
              className="btn btn-primary"
              style={{ width: '100%', padding: '12px', fontWeight: '700' }}
            >
              {loading ? 'Đang gửi mã...' : 'Tiếp Tục & Gửi Mã OTP'}
            </button>

            <div style={{ textAlign: 'center', marginTop: '24px' }}>
              <Link to="/login" style={{ display: 'inline-flex', alignItems: 'center', gap: '6px', fontSize: '13px', color: 'var(--text-muted)', textDecoration: 'none', fontWeight: '600' }}>
                <ArrowLeft size={15} /> Quay lại trang Đăng nhập
              </Link>
            </div>
          </form>
        )}

        {/* =========================================
            BƯỚC 2: NHẬP MÃ XÁC NHẬN (OTP)
        ========================================= */}
        {step === 2 && (
          <form onSubmit={handleVerifyOtp}>
            <div className="form-group" style={{ marginBottom: '24px' }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '8px' }}>
                <label className="form-label" style={{ marginBottom: 0 }}>Mã xác nhận (OTP) 6 số *</label>
                <button
                  type="button"
                  onClick={handleResendOtp}
                  disabled={resending}
                  style={{ border: 'none', background: 'none', color: 'var(--primary)', fontSize: '12px', fontWeight: '600', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '4px' }}
                >
                  <RefreshCw size={12} className={resending ? 'spin' : ''} />
                  {resending ? 'Đang gửi lại...' : 'Gửi lại mã'}
                </button>
              </div>
              <input
                type="text"
                className="input"
                required
                maxLength={6}
                placeholder="••••••"
                value={otp}
                onChange={(e) => setOtp(e.target.value.replace(/\D/g, ''))}
                autoFocus
                style={{ textAlign: 'center', letterSpacing: '8px', fontSize: '24px', fontWeight: '800' }}
              />
              <p style={{ fontSize: '12px', color: 'var(--text-light)', marginTop: '8px', textAlign: 'center' }}>
                Kiểm tra email <strong>{email}</strong> (cả thư mục Inbox và Spam)
              </p>
            </div>

            <button
              type="submit"
              disabled={loading || otp.length !== 6}
              className="btn btn-primary"
              style={{ width: '100%', padding: '12px', fontWeight: '700' }}
            >
              {loading ? 'Đang xác thực...' : 'Xác Nhận & Tiếp Tục'}
            </button>

            <div style={{ textAlign: 'center', marginTop: '20px' }}>
              <button
                type="button"
                onClick={() => { setStep(1); setError(''); setInfoMsg(''); }}
                style={{ border: 'none', background: 'none', color: 'var(--text-muted)', fontSize: '13px', cursor: 'pointer', fontWeight: '500' }}
              >
                ← Nhập lại địa chỉ email khác
              </button>
            </div>
          </form>
        )}

        {/* =========================================
            BƯỚC 3: ĐẶT LẠI MẬT KHẨU MỚI
        ========================================= */}
        {step === 3 && (
          <form onSubmit={handleResetPassword}>
            <div className="form-group" style={{ marginBottom: '16px' }}>
              <label className="form-label">Mật khẩu mới * (tối thiểu 6 ký tự)</label>
              <div style={{ position: 'relative' }}>
                <input
                  type={showPassword ? 'text' : 'password'}
                  className="input"
                  required
                  placeholder="••••••••"
                  value={newPassword}
                  onChange={(e) => setNewPassword(e.target.value)}
                  style={{ paddingLeft: '38px', paddingRight: '38px' }}
                  autoFocus
                />
                <Lock size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  style={{ position: 'absolute', right: '12px', top: '12px', border: 'none', background: 'none', cursor: 'pointer', color: 'var(--text-light)' }}
                >
                  {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
                </button>
              </div>
            </div>

            <div className="form-group" style={{ marginBottom: '24px' }}>
              <label className="form-label">Nhập lại mật khẩu mới *</label>
              <div style={{ position: 'relative' }}>
                <input
                  type={showConfirmPassword ? 'text' : 'password'}
                  className="input"
                  required
                  placeholder="••••••••"
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  style={{ paddingLeft: '38px', paddingRight: '38px' }}
                />
                <Lock size={16} color="var(--text-light)" style={{ position: 'absolute', left: '12px', top: '13px' }} />
                <button
                  type="button"
                  onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                  style={{ position: 'absolute', right: '12px', top: '12px', border: 'none', background: 'none', cursor: 'pointer', color: 'var(--text-light)' }}
                >
                  {showConfirmPassword ? <EyeOff size={16} /> : <Eye size={16} />}
                </button>
              </div>
            </div>

            <button
              type="submit"
              disabled={loading}
              className="btn btn-primary"
              style={{ width: '100%', padding: '12px', fontWeight: '700' }}
            >
              {loading ? 'Đang cập nhật mật khẩu...' : 'Lưu Mật Khẩu Mới'}
            </button>

            <div style={{ textAlign: 'center', marginTop: '20px' }}>
              <button
                type="button"
                onClick={() => { setStep(2); setError(''); setInfoMsg(''); }}
                style={{ border: 'none', background: 'none', color: 'var(--text-muted)', fontSize: '13px', cursor: 'pointer', fontWeight: '500' }}
              >
                ← Quay lại bước nhập mã OTP
              </button>
            </div>
          </form>
        )}

        {/* =========================================
            BƯỚC 4: HOÀN TẤT THÀNH CÔNG
        ========================================= */}
        {step === 4 && (
          <div style={{ textAlign: 'center' }}>
            <p style={{ fontSize: '14px', color: 'var(--text-main)', marginBottom: '24px', lineHeight: '1.6' }}>
              Mật khẩu mới của bạn đã được cập nhật thành công. Bạn có thể sử dụng mật khẩu này để đăng nhập ngay bây giờ.
            </p>

            <button
              onClick={() => navigate('/login')}
              className="btn btn-primary"
              style={{ width: '100%', padding: '12px', fontWeight: '700' }}
            >
              Đăng Nhập Ngay
            </button>
          </div>
        )}

      </div>
    </div>
  );
};
