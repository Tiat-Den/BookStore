import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Trash2, ShoppingBag, ArrowRight, ArrowLeft, Tag, Check, X, Ticket, Gift, BookOpen } from 'lucide-react';
import { useCart } from '../context/CartContext';
import { useAuth } from '../context/AuthContext';
import { couponService } from '../services/marketingServices';
import { LoadingSpinner } from '../components/UIComponents';

export const Cart = () => {
  const { cart, loading, updateQuantity, removeItem, clearCart } = useCart();
  const { isAuthenticated } = useAuth();
  const navigate = useNavigate();

  const [couponInput, setCouponInput] = useState('');
  const [appliedCoupon, setAppliedCoupon] = useState(null);
  const [couponError, setCouponError] = useState('');
  const [validatingCoupon, setValidatingCoupon] = useState(false);
  const [availableCoupons, setAvailableCoupons] = useState([]);
  const [showVoucherModal, setShowVoucherModal] = useState(false);

  const formatPrice = (val) => new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val);

  useEffect(() => {
    couponService.getAvailableCoupons().then((list) => {
      if (list && list.length > 0) setAvailableCoupons(list);
    });
  }, []);

  if (!isAuthenticated) {
    return (
      <div className="container" style={{ padding: '80px 20px', textAlign: 'center' }}>
        <div className="card" style={{ maxWidth: '440px', margin: '0 auto', padding: '40px' }}>
          <ShoppingBag size={48} color="var(--primary)" style={{ margin: '0 auto 16px' }} />
          <h2 style={{ fontSize: '20px', fontWeight: '700', marginBottom: '8px' }}>Giỏ Hàng Của Bạn</h2>
          <p style={{ fontSize: '14px', color: 'var(--text-muted)', marginBottom: '24px' }}>
            Vui lòng đăng nhập để xem các sản phẩm đã lưu trong giỏ hàng.
          </p>
          <Link to="/login" className="btn btn-primary" style={{ width: '100%' }}>
            Đăng nhập ngay
          </Link>
        </div>
      </div>
    );
  }

  if (loading) return <LoadingSpinner text="Đang tải giỏ hàng..." />;

  const items = cart.items || [];
  const subTotal = cart.subTotal || 0;
  const discountAmount = appliedCoupon ? appliedCoupon.discountAmount : 0;
  const shippingFee = subTotal >= 300000 || items.length === 0 ? 0 : 30000;
  const totalAmount = Math.max(0, subTotal - discountAmount + shippingFee);

  const handleApplyCoupon = async (e) => {
    if (e) e.preventDefault();
    handleApplyCode(couponInput);
  };

  const handleApplyCode = async (codeToApply) => {
    const code = (codeToApply || couponInput).trim().toUpperCase();
    if (!code) return;

    setValidatingCoupon(true);
    setCouponError('');
    try {
      const res = await couponService.validateCoupon(code, subTotal);
      if (res.success && res.data?.isValid) {
        setAppliedCoupon({
          code: res.data.code,
          discountAmount: res.data.discountAmount,
          message: res.data.message || 'Áp dụng mã giảm giá thành công!'
        });
        setCouponInput(res.data.code);
        setCouponError('');
        setShowVoucherModal(false);
      } else {
        setAppliedCoupon(null);
        setCouponError(res.data?.message || res.message || 'Mã giảm giá không hợp lệ hoặc chưa đủ điều kiện.');
      }
    } catch (err) {
      setAppliedCoupon(null);
      setCouponError(err.response?.data?.message || err.message || 'Lỗi khi kiểm tra mã giảm giá.');
    } finally {
      setValidatingCoupon(false);
    }
  };

  const handleRemoveCoupon = () => {
    setAppliedCoupon(null);
    setCouponInput('');
    setCouponError('');
  };

  return (
    <div className="container" style={{ padding: '36px 20px' }}>
      <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '24px' }}>
        Giỏ Hàng ({items.length} sản phẩm)
      </h1>

      {items.length === 0 ? (
        <div className="card" style={{ textAlign: 'center', padding: '60px 20px' }}>
          <ShoppingBag size={56} color="var(--text-light)" style={{ margin: '0 auto 16px' }} />
          <h3 style={{ fontSize: '18px', fontWeight: '700', marginBottom: '8px' }}>Giỏ hàng đang trống</h3>
          <p style={{ fontSize: '14px', color: 'var(--text-muted)', marginBottom: '24px' }}>
            Bạn chưa chọn mua cuốn sách nào. Hãy khám phá kho tàng sách phong phú của chúng tôi nhé!
          </p>
          <Link to="/books" className="btn btn-primary">
            Khám phá sách ngay <ArrowRight size={16} />
          </Link>
        </div>
      ) : (
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 340px', gap: '32px', alignItems: 'start' }}>
          {/* Cart items table */}
          <div className="card" style={{ padding: '0', overflow: 'hidden' }}>
            <div className="table-responsive">
              <table className="table">
                <thead>
                  <tr>
                    <th>Sản phẩm</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                  {items.map((item) => (
                    <tr key={item.id}>
                      <td>
                        <div style={{ display: 'flex', gap: '14px', alignItems: 'center' }}>
                          <img
                            src={item.coverImageUrl || 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=150&q=80'}
                            alt={item.bookTitle}
                            style={{ width: '56px', height: '76px', objectFit: 'cover', borderRadius: '6px' }}
                          />
                          <div>
                            <Link to={`/books/${item.bookSlug || item.bookId}`} style={{ fontWeight: '700', color: 'var(--text-main)', fontSize: '14px' }}>
                              {item.bookTitle}
                            </Link>                        
                          </div>
                        </div>
                      </td>

                      <td style={{ fontWeight: '600' }}>
                        {formatPrice(item.unitPrice)}
                      </td>

                      <td>
                        <div style={{ display: 'flex', alignItems: 'center', border: '1px solid var(--border)', borderRadius: 'var(--radius-sm)', width: 'fit-content' }}>
                          <button
                            onClick={() => updateQuantity(item.id, item.quantity - 1)}
                            style={{ width: '28px', height: '30px', border: 'none', background: '#f8fafc', cursor: 'pointer' }}
                          >
                            -
                          </button>
                          <span style={{ width: '36px', textAlign: 'center', fontSize: '13px', fontWeight: '600' }}>
                            {item.quantity}
                          </span>
                          <button
                            onClick={() => updateQuantity(item.id, item.quantity + 1)}
                            style={{ width: '28px', height: '30px', border: 'none', background: '#f8fafc', cursor: 'pointer' }}
                          >
                            +
                          </button>
                        </div>
                      </td>

                      <td style={{ fontWeight: '700', color: 'var(--primary)' }}>
                        {formatPrice(item.totalPrice)}
                      </td>

                      <td>
                        <button
                          onClick={() => removeItem(item.id)}
                          style={{ border: 'none', background: 'none', color: 'var(--danger)', cursor: 'pointer', padding: '6px' }}
                          title="Xóa khỏi giỏ"
                        >
                          <Trash2 size={16} />
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>

            <div style={{ padding: '16px 20px', display: 'flex', justifyContent: 'space-between', borderTop: '1px solid var(--border)', backgroundColor: '#f8fafc' }}>
              <Link to="/books" className="btn btn-outline btn-sm">
                <ArrowLeft size={16} /> Tiếp tục chọn sách
              </Link>
              <button onClick={clearCart} className="btn btn-danger btn-sm">
                Xóa toàn bộ giỏ
              </button>
            </div>
          </div>

          {/* Order Summary */}
          <div className="card" style={{ padding: '24px' }}>
            <h3 style={{ fontSize: '18px', fontWeight: '700', marginBottom: '20px', borderBottom: '1px solid var(--border)', paddingBottom: '12px' }}>
              Tóm Tắt Đơn Hàng
            </h3>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '12px', fontSize: '14px', marginBottom: '20px' }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', color: 'var(--text-muted)' }}>
                <span>Tiền hàng:</span>
                <span style={{ fontWeight: '600', color: 'var(--text-main)' }}>{formatPrice(subTotal)}</span>
              </div>

              {discountAmount > 0 && (
                <div style={{ display: 'flex', justifyContent: 'space-between', color: '#059669' }}>
                  <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
                    <Tag size={14} /> Giảm giá voucher ({appliedCoupon.code}):
                  </span>
                  <span style={{ fontWeight: '700' }}>-{formatPrice(discountAmount)}</span>
                </div>
              )}

              <div style={{ display: 'flex', justifyContent: 'space-between', color: 'var(--text-muted)' }}>
                <span>Phí vận chuyển:</span>
                <span style={{ fontWeight: '600', color: shippingFee === 0 ? 'var(--success)' : 'var(--text-main)' }}>
                  {shippingFee === 0 ? 'Miễn phí' : formatPrice(shippingFee)}
                </span>
              </div>

              {subTotal < 300000 && (
                <div style={{ fontSize: '12px', color: 'var(--accent)', backgroundColor: '#fffbeb', padding: '8px 10px', borderRadius: 'var(--radius-sm)' }}>
                  Mua thêm {formatPrice(300000 - subTotal)} để được miễn phí vận chuyển!
                </div>
              )}

              {/* Voucher Input Box */}
              <div style={{ margin: '8px 0', borderTop: '1px dashed #e2e8f0', borderBottom: '1px dashed #e2e8f0', padding: '14px 0' }}>
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '8px' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '6px', fontSize: '13px', fontWeight: '700', color: '#1e293b' }}>
                    <Tag size={15} color="#2563eb" /> Mã Giảm Giá / Voucher
                  </div>
                  <button
                    type="button"
                    onClick={() => setShowVoucherModal(true)}
                    style={{
                      background: 'none',
                      border: 'none',
                      color: '#2563eb',
                      fontSize: '12px',
                      fontWeight: '700',
                      cursor: 'pointer',
                      padding: 0,
                      display: 'flex',
                      alignItems: 'center',
                      gap: '4px'
                    }}
                  >
                    <Ticket size={14} /> Chọn mã ({availableCoupons.length})
                  </button>
                </div>

                {appliedCoupon ? (
                  <div style={{
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    padding: '8px 12px',
                    backgroundColor: '#ecfdf5',
                    border: '1px solid #a7f3d0',
                    borderRadius: '8px',
                    color: '#065f46'
                  }}>
                    <div>
                      <div style={{ fontWeight: '700', fontSize: '13px', display: 'flex', alignItems: 'center', gap: '4px' }}>
                        <Check size={14} color="#059669" /> {appliedCoupon.code}
                      </div>
                      <div style={{ fontSize: '11px', color: '#047857' }}>
                        Giảm {formatPrice(appliedCoupon.discountAmount)} cho đơn hàng
                      </div>
                    </div>
                    <button
                      type="button"
                      onClick={handleRemoveCoupon}
                      style={{
                        background: 'none',
                        border: 'none',
                        color: '#991b1b',
                        fontSize: '12px',
                        cursor: 'pointer',
                        fontWeight: '600',
                        padding: '4px'
                      }}
                      title="Bỏ mã giảm giá"
                    >
                      <X size={16} />
                    </button>
                  </div>
                ) : (
                  <div>
                    <div style={{ display: 'flex', gap: '6px' }}>
                      <input
                        type="text"
                        placeholder="Nhập mã (VD: BANMOI15)"
                        value={couponInput}
                        onChange={(e) => setCouponInput(e.target.value.toUpperCase())}
                        onKeyDown={(e) => {
                          if (e.key === 'Enter') {
                            e.preventDefault();
                            handleApplyCode(couponInput);
                          }
                        }}
                        style={{
                          flex: 1,
                          padding: '8px 10px',
                          border: '1.5px solid #cbd5e1',
                          borderRadius: '6px',
                          fontSize: '13px',
                          textTransform: 'uppercase',
                          fontWeight: '600'
                        }}
                      />
                      <button
                        type="button"
                        onClick={() => handleApplyCode(couponInput)}
                        disabled={validatingCoupon || !couponInput.trim()}
                        className="btn btn-primary btn-sm"
                        style={{ minWidth: '76px', fontWeight: '700' }}
                      >
                        {validatingCoupon ? '...' : 'Áp dụng'}
                      </button>
                    </div>

                    {couponError && (
                      <div style={{ fontSize: '12px', color: '#dc2626', marginTop: '6px', fontWeight: '500' }}>
                        {couponError}
                      </div>
                    )}

                    {/* Quick suggestion voucher chips */}
                    <div style={{ marginTop: '10px' }}>
                      <div style={{ fontSize: '11px', color: '#64748b', marginBottom: '6px' }}>Mã gợi ý cho bạn (bấm để áp dụng):</div>
                      <div style={{ display: 'flex', flexWrap: 'wrap', gap: '5px' }}>
                        {availableCoupons.slice(0, 4).map((c) => {
                          const eligible = subTotal >= c.minimumOrderAmount;
                          return (
                            <button
                              key={c.code}
                              type="button"
                              onClick={() => handleApplyCode(c.code)}
                              style={{
                                border: eligible ? '1px dashed #2563eb' : '1px dashed #cbd5e1',
                                background: eligible ? '#eff6ff' : '#f8fafc',
                                color: eligible ? '#1d4ed8' : '#64748b',
                                padding: '3px 8px',
                                borderRadius: '4px',
                                fontSize: '11px',
                                fontWeight: '700',
                                cursor: 'pointer',
                                display: 'inline-flex',
                                alignItems: 'center',
                                gap: '3px',
                                transition: 'all 0.15s ease'
                              }}
                              title={c.name}
                            >
                              <span>{c.code}</span>
                              <span style={{ fontSize: '10px', fontWeight: '500', color: eligible ? '#059669' : '#94a3b8' }}>
                                ({c.type === 'PERCENT' ? `-${c.value}%` : `-${Math.round(c.value / 1000)}k`})
                              </span>
                            </button>
                          );
                        })}
                      </div>
                    </div>
                  </div>
                )}
              </div>

              <div style={{ borderTop: '1px solid var(--border)', paddingTop: '14px', display: 'flex', justifyContent: 'space-between', fontSize: '16px', fontWeight: '800' }}>
                <span>Tổng cộng:</span>
                <span style={{ color: 'var(--primary)', fontSize: '20px' }}>{formatPrice(totalAmount)}</span>
              </div>
            </div>

            <button
              onClick={() => navigate('/checkout', { state: { couponCode: appliedCoupon?.code } })}
              className="btn btn-primary btn-lg"
              style={{ width: '100%' }}
            >
              Tiến hành Đặt Hàng <ArrowRight size={18} />
            </button>
          </div>
        </div>
      )}

      {/* Voucher Selector Modal */}
      {showVoucherModal && (
        <div className="modal-overlay" onClick={() => setShowVoucherModal(false)}>
          <div
            className="modal-content"
            style={{ maxWidth: '560px', width: '95%', maxHeight: '85vh', display: 'flex', flexDirection: 'column', borderRadius: '16px', overflow: 'hidden' }}
            onClick={(e) => e.stopPropagation()}
          >
            <div className="modal-header" style={{ padding: '18px 24px', borderBottom: '1px solid #e2e8f0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <div>
                <h3 style={{ fontSize: '18px', fontWeight: '800', margin: 0, color: '#0f172a', display: 'flex', alignItems: 'center', gap: '8px' }}>
                  <Ticket size={20} color="#2563eb" /> Kho Voucher BookStore
                </h3>
                <p style={{ fontSize: '12.5px', color: '#64748b', margin: '4px 0 0' }}>
                  Đơn hàng hiện tại: <strong>{formatPrice(subTotal)}</strong>
                </p>
              </div>
              <button
                type="button"
                onClick={() => setShowVoucherModal(false)}
                style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#64748b' }}
              >
                <X size={20} />
              </button>
            </div>

            <div style={{ padding: '20px 24px', overflowY: 'auto', display: 'flex', flexDirection: 'column', gap: '12px' }}>
              {availableCoupons.map((c) => {
                const isEligible = subTotal >= c.minimumOrderAmount;
                const isSelected = appliedCoupon?.code === c.code;

                return (
                  <div
                    key={c.code}
                    style={{
                      border: isSelected ? '2px solid #2563eb' : isEligible ? '1.5px solid #cbd5e1' : '1px solid #e2e8f0',
                      borderRadius: '12px',
                      padding: '14px',
                      backgroundColor: isSelected ? '#eff6ff' : isEligible ? '#ffffff' : '#f8fafc',
                      display: 'flex',
                      justifyContent: 'space-between',
                      alignItems: 'center',
                      gap: '14px',
                      transition: 'all 0.2s ease',
                      opacity: isEligible || isSelected ? 1 : 0.75
                    }}
                  >
                    <div style={{ flex: 1 }}>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '4px' }}>
                        <span style={{
                          backgroundColor: '#2563eb',
                          color: '#ffffff',
                          fontWeight: '800',
                          fontSize: '12px',
                          padding: '2px 8px',
                          borderRadius: '4px',
                          letterSpacing: '0.5px'
                        }}>
                          {c.code}
                        </span>
                        <span style={{ fontSize: '11px', fontWeight: '700', color: '#059669', backgroundColor: '#ecfdf5', padding: '1px 6px', borderRadius: '3px' }}>
                          {c.type === 'PERCENT' ? `Giảm ${c.value}%` : `Giảm ${formatPrice(c.value)}`}
                        </span>
                      </div>

                      <div style={{ fontSize: '13.5px', fontWeight: '700', color: '#1e293b', marginBottom: '2px' }}>
                        {c.name}
                      </div>

                      <div style={{ fontSize: '12px', color: '#64748b' }}>
                        Đơn tối thiểu: <strong>{formatPrice(c.minimumOrderAmount)}</strong>
                        {c.type === 'PERCENT' && c.maximumDiscountAmount > 0 && (
                          <span> (Tối đa {formatPrice(c.maximumDiscountAmount)})</span>
                        )}
                      </div>

                      {!isEligible && (
                        <div style={{ fontSize: '11px', color: '#ea580c', fontWeight: '600', marginTop: '4px' }}>
                          Cần mua thêm {formatPrice(c.minimumOrderAmount - subTotal)} để áp dụng mã này
                        </div>
                      )}
                    </div>

                    <div>
                      {isSelected ? (
                        <button
                          type="button"
                          onClick={() => {
                            handleRemoveCoupon();
                            setShowVoucherModal(false);
                          }}
                          className="btn btn-outline btn-sm"
                          style={{ borderColor: '#ef4444', color: '#ef4444', fontSize: '12px', padding: '6px 12px' }}
                        >
                          Bỏ chọn
                        </button>
                      ) : (
                        <button
                          type="button"
                          onClick={() => handleApplyCode(c.code)}
                          disabled={!isEligible || validatingCoupon}
                          className={`btn ${isEligible ? 'btn-primary' : 'btn-secondary'} btn-sm`}
                          style={{
                            fontSize: '12px',
                            fontWeight: '700',
                            padding: '6px 14px',
                            cursor: isEligible ? 'pointer' : 'not-allowed',
                            opacity: isEligible ? 1 : 0.6
                          }}
                        >
                          {isEligible ? 'Áp dụng' : 'Chưa đủ'}
                        </button>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
