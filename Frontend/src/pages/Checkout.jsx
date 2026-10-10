import React, { useState, useEffect } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { 
  ShieldCheck, Truck, CreditCard, ArrowLeft, QrCode, Clock, 
  RefreshCw, CheckCircle, AlertCircle, Copy, Check 
} from 'lucide-react';
import { useCart } from '../context/CartContext';
import { useAuth } from '../context/AuthContext';
import { orderService, paymentService } from '../services/catalogAndOrderServices';

export const Checkout = () => {
  const { cart, refreshCart } = useCart();
  const { user } = useAuth();
  const navigate = useNavigate();

  const [formData, setFormData] = useState({
    receiverName: user?.fullName || '',
    phone: user?.phone || '',
    province: 'TP. Hồ Chí Minh',
    district: 'Quận 1',
    ward: 'Phường Bến Nghé',
    addressLine: user?.address || '123 Đường Nguyễn Huệ',
    paymentMethod: 'COD',
    couponCode: '',
    note: ''
  });

  useEffect(() => {
    if (user) {
      setFormData(prev => ({
        ...prev,
        receiverName: prev.receiverName || user.fullName || '',
        phone: prev.phone || user.phone || '',
        addressLine: (prev.addressLine === '123 Đường Nguyễn Huệ' || !prev.addressLine) && user.address 
          ? user.address 
          : (prev.addressLine || user.address || '123 Đường Nguyễn Huệ')
      }));
    }
  }, [user]);

  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState('');
  const [couponInput, setCouponInput] = useState('');
  const [discountAmount, setDiscountAmount] = useState(0);
  const [couponMsg, setCouponMsg] = useState('');
  const [validatingCoupon, setValidatingCoupon] = useState(false);
  const [paymentModal, setPaymentModal] = useState(null); // { orderId, orderCode, totalAmount, paymentMethod }

  const formatPrice = (val) => new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val);

  const subTotal = cart.subTotal || 0;
  const shippingFee = subTotal >= 300000 ? 0 : 30000;
  const totalAmount = Math.max(0, subTotal - discountAmount + shippingFee);

  // QR Code state & 2-minute countdown (120 seconds)
  const [qrCountdown, setQrCountdown] = useState(120);
  const [qrSalt, setQrSalt] = useState(Date.now());
  const [copiedInfo, setCopiedInfo] = useState(false);

  useEffect(() => {
    if (formData.paymentMethod !== 'VNPAY' && formData.paymentMethod !== 'MOMO') {
      setQrCountdown(120);
      return;
    }

    setQrCountdown(120);
    const interval = setInterval(() => {
      setQrCountdown((prev) => {
        if (prev <= 1) {
          clearInterval(interval);
          return 0;
        }
        return prev - 1;
      });
    }, 1000);

    return () => clearInterval(interval);
  }, [formData.paymentMethod, qrSalt]);

  const handleRefreshQr = () => {
    setQrCountdown(120);
    setQrSalt(Date.now());
  };

  const formatTimer = (seconds) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
  };

  const handleCopyText = (text) => {
    if (navigator.clipboard) {
      navigator.clipboard.writeText(text);
      setCopiedInfo(true);
      setTimeout(() => setCopiedInfo(false), 2000);
    }
  };

  // Chuẩn VietQR tự động điền chính xác số tiền khớp với Tổng thanh toán (totalAmount)
  const vietQrUrl = `https://img.vietqr.io/image/MB-393905052005-compact2.png?amount=${Math.round(totalAmount)}&addInfo=${encodeURIComponent('Thanh toan BookStore')}&accountName=${encodeURIComponent('PHAM TIEN DAT')}&t=${qrSalt}`;

  // Chuẩn QR MoMo tự động điền chính xác số tiền khớp với Tổng thanh toán (totalAmount)
  const momoQrUrl = `https://img.vietqr.io/image/MB-0793813407-compact2.png?amount=${Math.round(totalAmount)}&addInfo=${encodeURIComponent('MoMo Thanh toan BookStore')}&accountName=${encodeURIComponent('PHAM TIEN DAT')}&t=${qrSalt}`;

  const handleApplyCoupon = async () => {
    if (!couponInput.trim()) return;
    setValidatingCoupon(true);
    setCouponMsg('');
    try {
      const res = await (await import('../services/marketingServices')).couponService.validateCoupon(couponInput.trim(), subTotal);
      if (res.success && res.data?.isValid) {
        setDiscountAmount(res.data.discountAmount);
        setFormData(prev => ({ ...prev, couponCode: res.data.code }));
        setCouponMsg(res.data.message);
      } else {
        setDiscountAmount(0);
        setFormData(prev => ({ ...prev, couponCode: '' }));
        setCouponMsg(res.data?.message || 'Mã giảm giá không hợp lệ.');
      }
    } catch (err) {
      setCouponMsg(err.message || 'Lỗi khi kiểm tra mã giảm giá.');
    } finally {
      setValidatingCoupon(false);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');

    if (!formData.receiverName || !formData.phone || !formData.addressLine) {
      setError('Vui lòng điền đầy đủ họ tên, số điện thoại và địa chỉ giao hàng.');
      return;
    }

    setSubmitting(true);
    try {
      const res = await orderService.createOrder(formData);
      if (res.success && res.data) {
        await refreshCart();
        if (formData.paymentMethod === 'VNPAY' || formData.paymentMethod === 'MOMO') {
          // Mở modal thanh toán mô phỏng cổng thanh toán VNPay / MoMo
          setPaymentModal({
            orderId: res.data.id,
            orderCode: res.data.orderCode,
            totalAmount: res.data.totalAmount,
            paymentMethod: formData.paymentMethod
          });
        } else {
          navigate(`/orders?success=${res.data.orderCode}`);
        }
      } else {
        setError(res.message || 'Đặt hàng thất bại.');
      }
    } catch (err) {
      setError(err.message || 'Lỗi khi gửi đơn hàng lên máy chủ.');
    } finally {
      setSubmitting(false);
    }
  };

  const handleConfirmOnlinePayment = async (isSuccess) => {
    if (!paymentModal) return;
    try {
      await paymentService.processMockPayment({
        orderId: paymentModal.orderId,
        paymentMethod: paymentModal.paymentMethod,
        isSuccess: isSuccess
      });
    } catch (err) {
      console.error('Payment error:', err);
    } finally {
      navigate(`/orders?success=${paymentModal.orderCode}`);
    }
  };

  if (!cart.items || cart.items.length === 0) {
    return (
      <div className="container" style={{ padding: '80px 20px', textAlign: 'center' }}>
        <h2>Không có sản phẩm nào để thanh toán.</h2>
        <Link to="/cart" className="btn btn-primary" style={{ marginTop: '20px' }}>Quay lại giỏ hàng</Link>
      </div>
    );
  }

  return (
    <div className="container" style={{ padding: '36px 20px' }}>
      <button onClick={() => navigate('/cart')} className="btn btn-outline btn-sm" style={{ marginBottom: '24px' }}>
        <ArrowLeft size={16} /> Quay lại giỏ hàng
      </button>

      <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '32px' }}>
        Xác Nhận & Đặt Hàng
      </h1>

      {error && (
        <div style={{ backgroundColor: '#fee2e2', color: 'var(--danger)', padding: '14px 18px', borderRadius: 'var(--radius)', marginBottom: '24px', fontSize: '14px', fontWeight: '600' }}>
          {error}
        </div>
      )}

      <form onSubmit={handleSubmit} style={{ display: 'grid', gridTemplateColumns: '1fr 380px', gap: '40px', alignItems: 'start' }}>
        {/* Left column: Shipping Address & Payment */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: '32px' }}>
          {/* Shipping Address */}
          <div className="card">
            <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '20px' }}>
              <Truck size={20} color="var(--primary)" />
              <h3 style={{ fontSize: '18px', fontWeight: '700' }}>Thông Tin Giao Hàng</h3>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px' }}>
              <div className="form-group">
                <label className="form-label">Họ và tên người nhận *</label>
                <input
                  type="text"
                  className="input"
                  required
                  value={formData.receiverName}
                  onChange={(e) => setFormData({ ...formData, receiverName: e.target.value })}
                />
              </div>

              <div className="form-group">
                <label className="form-label">Số điện thoại*</label>
                <input
                  type="tel"
                  className="input"
                  required
                  value={formData.phone}
                  onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
                />
              </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: '16px' }}>
              <div className="form-group">
                <label className="form-label">Tỉnh / Thành phố *</label>
                <input
                  type="text"
                  className="input"
                  required
                  value={formData.province}
                  onChange={(e) => setFormData({ ...formData, province: e.target.value })}
                />
              </div>

              <div className="form-group">
                <label className="form-label">Quận / Huyện *</label>
                <input
                  type="text"
                  className="input"
                  required
                  value={formData.district}
                  onChange={(e) => setFormData({ ...formData, district: e.target.value })}
                />
              </div>

              <div className="form-group">
                <label className="form-label">Phường / Xã *</label>
                <input
                  type="text"
                  className="input"
                  required
                  value={formData.ward}
                  onChange={(e) => setFormData({ ...formData, ward: e.target.value })}
                />
              </div>
            </div>

            <div className="form-group">
              <label className="form-label">Địa chỉ (Số nhà, tên đường) *</label>
              <input
                type="text"
                className="input"
                required
                placeholder="Ví dụ: Số 24 ngõ 180"
                value={formData.addressLine}
                onChange={(e) => setFormData({ ...formData, addressLine: e.target.value })}
              />
            </div>

            <div className="form-group" style={{ marginBottom: 0 }}>
              <label className="form-label">Ghi chú cho đơn hàng (Tùy chọn)</label>
              <textarea
                className="textarea"
                rows="2"
                placeholder="Ví dụ: Giao giờ hành chính hoặc gọi trước khi tới..."
                value={formData.note}
                onChange={(e) => setFormData({ ...formData, note: e.target.value })}
              />
            </div>
          </div>

          {/* Payment Method */}
          <div className="card">
            <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '20px' }}>
              <CreditCard size={20} color="var(--primary)" />
              <h3 style={{ fontSize: '18px', fontWeight: '700' }}>Phương Thức Thanh Toán</h3>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
              <label style={{ display: 'flex', alignItems: 'center', gap: '14px', padding: '14px', border: '1px solid var(--border)', borderRadius: 'var(--radius)', cursor: 'pointer', backgroundColor: formData.paymentMethod === 'COD' ? 'var(--primary-light)' : '#ffffff' }}>
                <input
                  type="radio"
                  name="paymentMethod"
                  value="COD"
                  checked={formData.paymentMethod === 'COD'}
                  onChange={(e) => setFormData({ ...formData, paymentMethod: e.target.value })}
                />
                <div>
                  <strong style={{ display: 'block', fontSize: '14px' }}>Thanh toán khi nhận hàng (COD)</strong>
                  <span style={{ fontSize: '12px', color: 'var(--text-muted)' }}>Bạn chỉ phải thanh toán tiền khi nhân viên giao sách tận nơi.</span>
                </div>
              </label>

              {/* Ví điện tử VNPay / QR Code Option */}
              <div style={{
                border: formData.paymentMethod === 'VNPAY' ? '2px solid var(--primary)' : '1px solid var(--border)',
                borderRadius: 'var(--radius)',
                backgroundColor: formData.paymentMethod === 'VNPAY' ? '#f8faff' : '#ffffff',
                transition: 'all 0.2s ease',
                overflow: 'hidden'
              }}>
                <label style={{ display: 'flex', alignItems: 'center', gap: '14px', padding: '14px', cursor: 'pointer', margin: 0 }}>
                  <input
                    type="radio"
                    name="paymentMethod"
                    value="VNPAY"
                    checked={formData.paymentMethod === 'VNPAY'}
                    onChange={(e) => setFormData({ ...formData, paymentMethod: e.target.value })}
                  />
                  <div style={{ flex: 1 }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                      <strong style={{ fontSize: '14px' }}>Ví điện tử VNPay / QR Code</strong>
                    </div>
                    <span style={{ fontSize: '12px', color: 'var(--text-muted)' }}>Quét mã QR thanh toán nhanh qua ứng dụng ngân hàng hoặc ví VNPay.</span>
                  </div>
                </label>

                {/* Khung hiển thị Mã QR tồn tại 2 phút với số tiền khớp Tổng thanh toán */}
                {formData.paymentMethod === 'VNPAY' && (
                  <div style={{
                    padding: '16px',
                    borderTop: '1px solid #e2e8f0',
                    backgroundColor: '#ffffff'
                  }}>
                    {/* Header đếm ngược thời gian 2 phút */}
                    <div style={{
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'space-between',
                      flexWrap: 'wrap',
                      gap: '10px',
                      marginBottom: '16px',
                      padding: '10px 14px',
                      borderRadius: '8px',
                      backgroundColor: qrCountdown > 0 ? '#eff6ff' : '#fee2e2',
                      border: `1px solid ${qrCountdown > 0 ? '#bfdbfe' : '#fca5a5'}`
                    }}>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <Clock size={16} color={qrCountdown > 0 ? '#2563eb' : '#dc2626'} />
                        <span style={{ fontSize: '13px', fontWeight: '600', color: qrCountdown > 0 ? '#1e40af' : '#b91c1c' }}>
                          {qrCountdown > 0 ? (
                            <>Mã QR có hiệu lực trong: <strong style={{ fontSize: '15px', color: '#1d4ed8' }}>{formatTimer(qrCountdown)}</strong> (2 phút)</>
                          ) : (
                            <>Mã QR đã hết hạn (quá 2 phút)</>
                          )}
                        </span>
                      </div>

                      <button
                        type="button"
                        onClick={handleRefreshQr}
                        style={{
                          background: '#ffffff',
                          border: '1px solid #cbd5e1',
                          padding: '5px 12px',
                          borderRadius: '6px',
                          fontSize: '12px',
                          fontWeight: '600',
                          color: '#334155',
                          cursor: 'pointer',
                          display: 'inline-flex',
                          alignItems: 'center',
                          gap: '6px'
                        }}
                      >
                        <RefreshCw size={13} />
                        Làm mới mã QR
                      </button>
                    </div>

                    {/* Vùng hiển thị QR Code & Chi tiết khớp thanh toán */}
                    <div style={{ display: 'grid', gridTemplateColumns: 'auto 1fr', gap: '20px', alignItems: 'center' }}>
                      {/* Cột QR Image */}
                      <div style={{
                        position: 'relative',
                        width: '210px',
                        height: '210px',
                        padding: '8px',
                        backgroundColor: '#ffffff',
                        border: '2px solid #e2e8f0',
                        borderRadius: '12px',
                        boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.06)',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        margin: '0 auto'
                      }}>
                        <img
                          src={vietQrUrl}
                          alt="VietQR VNPay"
                          style={{
                            width: '100%',
                            height: '100%',
                            objectFit: 'contain',
                            filter: qrCountdown === 0 ? 'blur(4px) grayscale(80%)' : 'none',
                            transition: 'filter 0.3s'
                          }}
                        />

                        {/* Overlay khi hết hạn 2 phút */}
                        {qrCountdown === 0 && (
                          <div style={{
                            position: 'absolute',
                            inset: 0,
                            backgroundColor: 'rgba(255, 255, 255, 0.94)',
                            borderRadius: '10px',
                            display: 'flex',
                            flexDirection: 'column',
                            alignItems: 'center',
                            justifyContent: 'center',
                            gap: '8px',
                            padding: '12px',
                            textAlign: 'center'
                          }}>
                            <AlertCircle size={32} color="#dc2626" />
                            <span style={{ fontSize: '13px', fontWeight: '700', color: '#b91c1c' }}>Mã QR đã hết hạn</span>
                            <button
                              type="button"
                              onClick={handleRefreshQr}
                              className="btn btn-primary btn-sm"
                              style={{ fontSize: '11px', padding: '6px 12px' }}
                            >
                              <RefreshCw size={12} /> Bấm để tạo lại mã
                            </button>
                          </div>
                        )}
                      </div>

                      {/* Cột thông tin chi tiết */}
                      <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
                        {/* Hộp số tiền khớp với Tổng thanh toán */}

                        <div style={{ display: 'grid', gridTemplateColumns: '100px 1fr', gap: '6px', color: '#475569', fontSize: '12px' }}>
                          <span style={{ color: '#94a3b8' }}>Ngân hàng:</span>
                          <strong>MB Bank (Ngân hàng Quân Đội)</strong>
                          <span style={{ color: '#94a3b8' }}>Chủ tài khoản:</span>
                          <strong>PHAM TIEN DAT</strong>
                          <span style={{ color: '#94a3b8' }}>Số tài khoản:</span>
                          <strong>393905052005</strong>
                          <span style={{ color: '#94a3b8' }}>Nội dung CK:</span>
                          <span style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                            <code style={{ backgroundColor: '#f1f5f9', padding: '2px 6px', borderRadius: '4px', fontWeight: '700', color: '#0f172a' }}>
                              Thanh toan BookStore
                            </code>
                            <button
                              type="button"
                              onClick={() => handleCopyText('Thanh toan BookStore')}
                              style={{ background: 'none', border: 'none', cursor: 'pointer', padding: '2px', color: copiedInfo ? '#16a34a' : '#64748b' }}
                              title="Sao chép nội dung"
                            >
                              {copiedInfo ? <Check size={14} /> : <Copy size={14} />}
                            </button>
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>
                )}
              </div>

              {/* Ví MoMo Option */}
              <div style={{
                border: formData.paymentMethod === 'MOMO' ? '2px solid #d82d8b' : '1px solid var(--border)',
                borderRadius: 'var(--radius)',
                backgroundColor: formData.paymentMethod === 'MOMO' ? '#fdf2f8' : '#ffffff',
                transition: 'all 0.2s ease',
                overflow: 'hidden'
              }}>
                <label style={{ display: 'flex', alignItems: 'center', gap: '14px', padding: '14px', cursor: 'pointer', margin: 0 }}>
                  <input
                    type="radio"
                    name="paymentMethod"
                    value="MOMO"
                    checked={formData.paymentMethod === 'MOMO'}
                    onChange={(e) => setFormData({ ...formData, paymentMethod: e.target.value })}
                  />
                  <div style={{ flex: 1 }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                      <strong style={{ fontSize: '14px' }}>Ví MoMo</strong>
                    </div>
                    <span style={{ fontSize: '12px', color: 'var(--text-muted)' }}>Thanh toán an toàn, tức thì qua ứng dụng ví MoMo.</span>
                  </div>
                </label>

                {/* Khung hiển thị Mã QR MoMo tồn tại 2 phút với số tiền khớp Tổng thanh toán */}
                {formData.paymentMethod === 'MOMO' && (
                  <div style={{
                    padding: '16px',
                    borderTop: '1px solid #fbcfe8',
                    backgroundColor: '#ffffff'
                  }}>
                    {/* Header đếm ngược thời gian 2 phút */}
                    <div style={{
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'space-between',
                      flexWrap: 'wrap',
                      gap: '10px',
                      marginBottom: '16px',
                      padding: '10px 14px',
                      borderRadius: '8px',
                      backgroundColor: qrCountdown > 0 ? '#fdf2f8' : '#fee2e2',
                      border: `1px solid ${qrCountdown > 0 ? '#fbcfe8' : '#fca5a5'}`
                    }}>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <Clock size={16} color={qrCountdown > 0 ? '#d82d8b' : '#dc2626'} />
                        <span style={{ fontSize: '13px', fontWeight: '600', color: qrCountdown > 0 ? '#be185d' : '#b91c1c' }}>
                          {qrCountdown > 0 ? (
                            <>Mã QR MoMo có hiệu lực trong: <strong style={{ fontSize: '15px', color: '#be185d' }}>{formatTimer(qrCountdown)}</strong> (2 phút)</>
                          ) : (
                            <>Mã QR MoMo đã hết hạn (quá 2 phút)</>
                          )}
                        </span>
                      </div>

                      <button
                        type="button"
                        onClick={handleRefreshQr}
                        style={{
                          background: '#ffffff',
                          border: '1px solid #cbd5e1',
                          padding: '5px 12px',
                          borderRadius: '6px',
                          fontSize: '12px',
                          fontWeight: '600',
                          color: '#334155',
                          cursor: 'pointer',
                          display: 'inline-flex',
                          alignItems: 'center',
                          gap: '6px'
                        }}
                      >
                        <RefreshCw size={13} />
                        Làm mới mã MoMo
                      </button>
                    </div>

                    {/* Vùng hiển thị QR Code & Chi tiết khớp thanh toán MoMo */}
                    <div style={{ display: 'grid', gridTemplateColumns: 'auto 1fr', gap: '20px', alignItems: 'center' }}>
                      {/* Cột QR Image */}
                      <div style={{
                        position: 'relative',
                        width: '210px',
                        height: '210px',
                        padding: '8px',
                        backgroundColor: '#ffffff',
                        border: '2px solid #fbcfe8',
                        borderRadius: '12px',
                        boxShadow: '0 4px 6px -1px rgba(216, 45, 139, 0.08)',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        margin: '0 auto'
                      }}>
                        <img
                          src={momoQrUrl}
                          alt="Ví MoMo QR"
                          style={{
                            width: '100%',
                            height: '100%',
                            objectFit: 'contain',
                            filter: qrCountdown === 0 ? 'blur(4px) grayscale(80%)' : 'none',
                            transition: 'filter 0.3s'
                          }}
                        />

                        {/* Overlay khi hết hạn 2 phút */}
                        {qrCountdown === 0 && (
                          <div style={{
                            position: 'absolute',
                            inset: 0,
                            backgroundColor: 'rgba(255, 255, 255, 0.94)',
                            borderRadius: '10px',
                            display: 'flex',
                            flexDirection: 'column',
                            alignItems: 'center',
                            justifyContent: 'center',
                            gap: '8px',
                            padding: '12px',
                            textAlign: 'center'
                          }}>
                            <AlertCircle size={32} color="#dc2626" />
                            <span style={{ fontSize: '13px', fontWeight: '700', color: '#b91c1c' }}>Mã MoMo đã hết hạn</span>
                            <button
                              type="button"
                              onClick={handleRefreshQr}
                              className="btn btn-primary btn-sm"
                              style={{ fontSize: '11px', padding: '6px 12px', backgroundColor: '#d82d8b', borderColor: '#d82d8b' }}
                            >
                              <RefreshCw size={12} /> Bấm để tạo lại mã
                            </button>
                          </div>
                        )}
                      </div>

                      {/* Cột thông tin chi tiết */}
                      <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
                        

                        <div style={{ display: 'grid', gridTemplateColumns: '100px 1fr', gap: '6px', color: '#475569', fontSize: '12px' }}>
                          <span style={{ color: '#94a3b8' }}>Kênh nhận:</span>
                          <strong style={{ color: '#be185d' }}>Ví MoMo / MB Bank</strong>
                          <span style={{ color: '#94a3b8' }}>Chủ tài khoản:</span>
                          <strong>PHAM TIEN DAT</strong>
                          <span style={{ color: '#94a3b8' }}>Số ĐT:</span>
                          <span style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                            <strong style={{ color: '#0f172a', letterSpacing: '0.5px' }}>0793813407</strong>
                            <button
                              type="button"
                              onClick={() => handleCopyText('0793813407')}
                              style={{ background: 'none', border: 'none', cursor: 'pointer', padding: '2px', color: copiedInfo ? '#16a34a' : '#64748b' }}
                              title="Sao chép số điện thoại MoMo"
                            >
                              <Copy size={13} />
                            </button>
                          </span>
                          <span style={{ color: '#94a3b8' }}>Nội dung CK:</span>
                          <span style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                            <code style={{ backgroundColor: '#fdf2f8', color: '#be185d', padding: '2px 6px', borderRadius: '4px', fontWeight: '700', border: '1px solid #fbcfe8' }}>
                              MoMo Thanh toan BookStore
                            </code>
                            <button
                              type="button"
                              onClick={() => handleCopyText('MoMo Thanh toan BookStore')}
                              style={{ background: 'none', border: 'none', cursor: 'pointer', padding: '2px', color: copiedInfo ? '#16a34a' : '#64748b' }}
                              title="Sao chép nội dung"
                            >
                              {copiedInfo ? <Check size={14} /> : <Copy size={14} />}
                            </button>
                          </span>
                        </div>                       
                      </div>
                    </div>
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>

        {/* Right column: Order Preview */}
        <div className="card" style={{ padding: '24px', position: 'sticky', top: '100px' }}>
          <h3 style={{ fontSize: '18px', fontWeight: '700', marginBottom: '16px', borderBottom: '1px solid var(--border)', paddingBottom: '12px' }}>
            Chi Tiết Đơn Hàng
          </h3>

          <div style={{ maxHeight: '280px', overflowY: 'auto', marginBottom: '20px', display: 'flex', flexDirection: 'column', gap: '12px' }}>
            {cart.items.map((i) => (
              <div key={i.id} style={{ display: 'flex', gap: '10px', alignItems: 'center', fontSize: '13px' }}>
                <img
                  src={i.coverImageUrl || 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=100&q=80'}
                  alt={i.bookTitle}
                  style={{ width: '42px', height: '56px', objectFit: 'cover', borderRadius: '4px' }}
                />
                <div style={{ flex: 1 }}>
                  <div style={{ fontWeight: '600', display: '-webkit-box', WebkitLineClamp: 1, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>
                    {i.bookTitle}
                  </div>
                  <div style={{ color: 'var(--text-muted)' }}>x {i.quantity}</div>
                </div>
                <div style={{ fontWeight: '700' }}>
                  {formatPrice(i.totalPrice)}
                </div>
              </div>
            ))}
          </div>

          {/* Coupon Code Section */}
          <div style={{ borderTop: '1px solid var(--border)', paddingTop: '16px', marginBottom: '16px' }}>
            <label style={{ fontSize: '12px', fontWeight: '700', marginBottom: '6px', display: 'block' }}>Mã Giảm Giá</label>
            <div style={{ display: 'flex', gap: '8px' }}>
              <input
                type="text"
                className="input"
                placeholder="Nhập mã (ví dụ: BOOK20)"
                value={couponInput}
                onChange={(e) => setCouponInput(e.target.value)}
                style={{ textTransform: 'uppercase', fontSize: '13px', padding: '8px 12px' }}
              />
              <button
                type="button"
                onClick={handleApplyCoupon}
                disabled={validatingCoupon}
                className="btn btn-secondary btn-sm"
              >
                {validatingCoupon ? 'Kiểm tra...' : 'Áp dụng'}
              </button>
            </div>
            {couponMsg && (
              <div style={{ fontSize: '12px', marginTop: '6px', color: discountAmount > 0 ? 'var(--success)' : 'var(--danger)', fontWeight: '600' }}>
                {couponMsg}
              </div>
            )}
          </div>

          <div style={{ borderTop: '1px solid var(--border)', paddingTop: '16px', display: 'flex', flexDirection: 'column', gap: '10px', fontSize: '14px', marginBottom: '24px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', color: 'var(--text-muted)' }}>
              <span>Tiền hàng:</span>
              <span style={{ fontWeight: '600', color: 'var(--text-main)' }}>{formatPrice(subTotal)}</span>
            </div>

            {discountAmount > 0 && (
              <div style={{ display: 'flex', justifyContent: 'space-between', color: 'var(--success)' }}>
                <span>Giảm giá voucher:</span>
                <span style={{ fontWeight: '700' }}>-{formatPrice(discountAmount)}</span>
              </div>
            )}

            <div style={{ display: 'flex', justifyContent: 'space-between', color: 'var(--text-muted)' }}>
              <span>Phí vận chuyển:</span>
              <span style={{ fontWeight: '600', color: shippingFee === 0 ? 'var(--success)' : 'var(--text-main)' }}>
                {shippingFee === 0 ? 'Miễn phí' : formatPrice(shippingFee)}
              </span>
            </div>

            <div style={{ borderTop: '1px solid var(--border)', paddingTop: '14px', display: 'flex', justifyContent: 'space-between', fontSize: '17px', fontWeight: '800' }}>
              <span>Tổng thanh toán:</span>
              <span style={{ color: 'var(--primary)' }}>{formatPrice(totalAmount)}</span>
            </div>
          </div>

          <button
            type="submit"
            disabled={submitting}
            className="btn btn-primary btn-lg"
            style={{ width: '100%' }}
          >
            {submitting ? 'Đang xử lý đơn hàng...' : 'Hoàn Tất Đặt Hàng'}
          </button>
        </div>
      </form>

      {/* Online Payment Mock Gateway Modal */}
      {paymentModal && (
        <div style={{
          position: 'fixed',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          backgroundColor: 'rgba(0,0,0,0.6)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          zIndex: 9999,
          padding: '20px'
        }}>
          <div className="card" style={{ maxWidth: '480px', width: '100%', padding: '28px', textAlign: 'center', boxShadow: '0 20px 25px -5px rgba(0,0,0,0.2)' }}>
            <div style={{ display: 'inline-flex', padding: '12px', borderRadius: '50%', backgroundColor: '#eff6ff', color: 'var(--primary)', marginBottom: '16px' }}>
              <CreditCard size={36} />
            </div>
            <h2 style={{ fontSize: '20px', fontWeight: '800', marginBottom: '8px' }}>
              Cổng Thanh Toán {paymentModal.paymentMethod === 'VNPAY' ? 'VNPay Sandbox' : 'Ví MoMo'}
            </h2>
            <p style={{ fontSize: '13px', color: 'var(--text-muted)', marginBottom: '20px' }}>
              Mô phỏng quy trình xử lý thanh toán trực tuyến an toàn theo chuẩn thương mại điện tử
            </p>

            {paymentModal.paymentMethod === 'VNPAY' && (
              <div style={{
                marginBottom: '20px',
                padding: '14px',
                backgroundColor: '#f8fafc',
                borderRadius: '12px',
                border: '1px solid #e2e8f0',
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                gap: '8px'
              }}>
                <div style={{
                  position: 'relative',
                  width: '170px',
                  height: '170px',
                  backgroundColor: '#ffffff',
                  padding: '6px',
                  borderRadius: '10px',
                  border: '1px solid #e2e8f0'
                }}>
                  <img
                    src={`https://img.vietqr.io/image/MB-393905052005-compact2.png?amount=${Math.round(paymentModal.totalAmount)}&addInfo=${encodeURIComponent('Thanh toan ' + paymentModal.orderCode)}&accountName=${encodeURIComponent('PHAM TIEN DAT')}`}
                    alt="VietQR VNPay"
                    style={{ width: '100%', height: '100%', objectFit: 'contain' }}
                  />
                </div>
              </div>
            )}

            {paymentModal.paymentMethod === 'MOMO' && (
              <div style={{
                marginBottom: '20px',
                padding: '14px',
                backgroundColor: '#fdf2f8',
                borderRadius: '12px',
                border: '1px solid #fbcfe8',
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                gap: '8px'
              }}>
                <div style={{
                  position: 'relative',
                  width: '170px',
                  height: '170px',
                  backgroundColor: '#ffffff',
                  padding: '6px',
                  borderRadius: '10px',
                  border: '1px solid #fbcfe8'
                }}>
                  <img
                    src={`https://img.vietqr.io/image/MB-0793813407-compact2.png?amount=${Math.round(paymentModal.totalAmount)}&addInfo=${encodeURIComponent('MoMo ' + paymentModal.orderCode)}&accountName=${encodeURIComponent('PHAM TIEN DAT')}`}
                    alt="Ví MoMo QR"
                    style={{ width: '100%', height: '100%', objectFit: 'contain' }}
                  />
                </div>
                
                <div style={{ fontSize: '11px', color: '#64748b' }}>
                  Chủ ví: <strong>PHAM TIEN DAT</strong> • Số: <strong>0793813407</strong>
                </div>
              </div>
            )}

            <div style={{ background: '#f8fafc', padding: '16px', borderRadius: '8px', marginBottom: '24px', textAlign: 'left', fontSize: '14px' }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '8px' }}>
                <span style={{ color: 'var(--text-muted)' }}>Mã đơn hàng:</span>
                <strong>{paymentModal.orderCode}</strong>
              </div>
              <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '8px' }}>
                <span style={{ color: 'var(--text-muted)' }}>Số tiền:</span>
                <strong style={{ color: 'var(--primary)', fontSize: '16px' }}>{formatPrice(paymentModal.totalAmount)}</strong>
              </div>
              <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                <span style={{ color: 'var(--text-muted)' }}>Ngân hàng mô phỏng:</span>
                <strong>NCB (Ngân hàng Quốc Dân)</strong>
              </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
              <button
                type="button"
                onClick={() => handleConfirmOnlinePayment(true)}
                className="btn btn-primary"
                style={{ width: '100%', padding: '12px' }}
              >
                Xác nhận thanh toán thành công (Mã 00)
              </button>
              <button
                type="button"
                onClick={() => handleConfirmOnlinePayment(false)}
                className="btn btn-outline"
                style={{ width: '100%', padding: '12px' }}
              >
                Hủy thanh toán / Thanh toán sau
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
