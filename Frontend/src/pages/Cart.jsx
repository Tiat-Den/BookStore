import React from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Trash2, ShoppingBag, ArrowRight, ArrowLeft } from 'lucide-react';
import { useCart } from '../context/CartContext';
import { useAuth } from '../context/AuthContext';
import { LoadingSpinner } from '../components/UIComponents';

export const Cart = () => {
  const { cart, loading, updateQuantity, removeItem, clearCart } = useCart();
  const { isAuthenticated } = useAuth();
  const navigate = useNavigate();

  const formatPrice = (val) => new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val);

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
  const shippingFee = subTotal >= 300000 || items.length === 0 ? 0 : 30000;
  const totalAmount = subTotal + shippingFee;

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

              <div style={{ borderTop: '1px solid var(--border)', paddingTop: '14px', display: 'flex', justifyContent: 'space-between', fontSize: '16px', fontWeight: '800' }}>
                <span>Tổng cộng:</span>
                <span style={{ color: 'var(--primary)' }}>{formatPrice(totalAmount)}</span>
              </div>
            </div>

            <button
              onClick={() => navigate('/checkout')}
              className="btn btn-primary btn-lg"
              style={{ width: '100%' }}
            >
              Tiến hành Đặt Hàng <ArrowRight size={18} />
            </button>
          </div>
        </div>
      )}
    </div>
  );
};
