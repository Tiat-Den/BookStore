import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { ShieldCheck, Truck, CreditCard, ArrowLeft } from 'lucide-react';
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
    addressLine: '123 Đường Nguyễn Huệ',
    paymentMethod: 'COD',
    couponCode: '',
    note: ''
  });

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
                <label className="form-label">Số điện thoại nhận hàng *</label>
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
              <label className="form-label">Địa chỉ cụ thể (Số nhà, tên đường) *</label>
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

              <label style={{ display: 'flex', alignItems: 'center', gap: '14px', padding: '14px', border: '1px solid var(--border)', borderRadius: 'var(--radius)', cursor: 'pointer', backgroundColor: formData.paymentMethod === 'VNPAY' ? 'var(--primary-light)' : '#ffffff' }}>
                <input
                  type="radio"
                  name="paymentMethod"
                  value="VNPAY"
                  checked={formData.paymentMethod === 'VNPAY'}
                  onChange={(e) => setFormData({ ...formData, paymentMethod: e.target.value })}
                />
                <div>
                  <strong style={{ display: 'block', fontSize: '14px' }}>Ví điện tử VNPay / QR Code</strong>
                  <span style={{ fontSize: '12px', color: 'var(--text-muted)' }}>Quét mã QR thanh toán nhanh qua ứng dụng ngân hàng.</span>
                </div>
              </label>

              <label style={{ display: 'flex', alignItems: 'center', gap: '14px', padding: '14px', border: '1px solid var(--border)', borderRadius: 'var(--radius)', cursor: 'pointer', backgroundColor: formData.paymentMethod === 'MOMO' ? 'var(--primary-light)' : '#ffffff' }}>
                <input
                  type="radio"
                  name="paymentMethod"
                  value="MOMO"
                  checked={formData.paymentMethod === 'MOMO'}
                  onChange={(e) => setFormData({ ...formData, paymentMethod: e.target.value })}
                />
                <div>
                  <strong style={{ display: 'block', fontSize: '14px' }}>Ví MoMo</strong>
                  <span style={{ fontSize: '12px', color: 'var(--text-muted)' }}>Thanh toán an toàn và tiện lợi qua MoMo.</span>
                </div>
              </label>
            </div>
          </div>
        </div>

        {/* Right column: Order Preview */}
        <div className="card" style={{ padding: '24px', position: 'sticky', top: '100px' }}>
          <h3 style={{ fontSize: '18px', fontWeight: '700', marginBottom: '16px', borderBottom: '1px solid var(--border)', paddingBottom: '12px' }}>
            Chi Tiết Đơn Hàng ({cart.items.length})
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
            <label style={{ fontSize: '12px', fontWeight: '700', marginBottom: '6px', display: 'block' }}>Mã Giảm Giá / Voucher</label>
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
