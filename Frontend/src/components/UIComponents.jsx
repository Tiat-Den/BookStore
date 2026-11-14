import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { ShoppingCart, Star, Check, Heart } from 'lucide-react';
import { useCart } from '../context/CartContext';
import { useAuth } from '../context/AuthContext';
import { useWishlist } from '../context/WishlistContext';

export const ProductCard = ({ book }) => {
  const { addToCart } = useCart();
  const { isAuthenticated } = useAuth();
  const { isInWishlist, toggleWishlist } = useWishlist();
  const isWishlisted = isInWishlist(book.id);
  const [wishlistLoading, setWishlistLoading] = useState(false);
  const navigate = useNavigate();
  const [added, setAdded] = useState(false);
  const [loading, setLoading] = useState(false);

  const formatPrice = (val) => new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val);

  const handleAddToCart = async (e) => {
    if (e) {
      e.preventDefault();
      e.stopPropagation();
    }
    if (loading) return;
    if (!isAuthenticated) {
      navigate('/login');
      return;
    }

    setLoading(true);
    const res = await addToCart(book.id, 1);
    setLoading(false);

    if (res.success) {
      setAdded(true);
      setTimeout(() => setAdded(false), 1800);
    } else {
      alert(res.message);
    }
  };

  const handleToggleWishlist = async (e) => {
    if (e) {
      e.preventDefault();
      e.stopPropagation();
    }
    if (wishlistLoading) return;
    if (!isAuthenticated) {
      navigate('/login');
      return;
    }

    setWishlistLoading(true);
    const res = await toggleWishlist(book.id);
    setWishlistLoading(false);
    if (!res.success && res.message) {
      alert(res.message);
    }
  };

  const discountPercent = book.discountPrice && book.salePrice > 0
    ? Math.round(((book.salePrice - book.discountPrice) / book.salePrice) * 100)
    : 0;

  const ratingVal = (4.8 + (((book.id ? book.id.charCodeAt(book.id.length - 1) : 5) % 3) * 0.1)).toFixed(1);

  return (
    <div className="book-card" style={{ display: 'flex', flexDirection: 'column', height: '100%', position: 'relative' }}>
      {/* Book Cover Container with Floating Badges */}
      <div style={{ position: 'relative', marginBottom: '12px' }}>
        {/* Top badges: Discount & Freeship */}
        <div style={{ position: 'absolute', top: '8px', left: '8px', display: 'flex', flexDirection: 'column', gap: '4px', zIndex: 3, pointerEvents: 'none' }}>
          {discountPercent > 0 && (
            <span style={{
              backgroundColor: '#ef4444',
              color: '#ffffff',
              fontSize: '11px',
              fontWeight: '800',
              padding: '2px 7px',
              borderRadius: '4px',
              boxShadow: '0 2px 4px rgba(239, 68, 68, 0.3)'
            }}>
              -{discountPercent}%
            </span>
          )}
          <span style={{
            backgroundColor: '#059669',
            color: '#ffffff',
            fontSize: '9.5px',
            fontWeight: '700',
            padding: '1px 6px',
            borderRadius: '3px',
            letterSpacing: '0.3px',
            textTransform: 'uppercase'
          }}>
            Freeship
          </span>
        </div>

        {/* Wishlist Button */}
        <button
          onClick={handleToggleWishlist}
          disabled={wishlistLoading}
          style={{
            position: 'absolute',
            top: '8px',
            right: '8px',
            width: '32px',
            height: '32px',
            borderRadius: '50%',
            backgroundColor: '#ffffff',
            boxShadow: '0 2px 8px rgba(0, 0, 0, 0.12)',
            border: '1px solid #f1f5f9',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            cursor: 'pointer',
            zIndex: 3,
            transition: 'transform 0.2s, background-color 0.2s'
          }}
          onMouseEnter={(e) => e.currentTarget.style.transform = 'scale(1.15)'}
          onMouseLeave={(e) => e.currentTarget.style.transform = 'scale(1)'}
          title={isWishlisted ? "Bỏ khỏi danh sách yêu thích" : "Thêm vào danh sách yêu thích"}
        >
          <Heart
            size={16}
            color="#ef4444"
            fill={isWishlisted ? "#ef4444" : "none"}
          />
        </button>

        {/* Book Cover Frame - Full Fit */}
        <Link
          to={`/books/${book.slug || book.id}`}
          className="book-cover-frame"
          style={{ textDecoration: 'none' }}
        >
          <img
            src={book.coverImageUrl || 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=400&q=80'}
            alt={book.title}
            loading="lazy"
            onError={(e) => {
              e.currentTarget.onerror = null;
              e.currentTarget.src = 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=400&q=80';
            }}
          />
        </Link>
      </div>

      {/* Author Name */}
      <div style={{
        fontSize: '11.5px',
        color: '#64748b',
        marginBottom: '4px',
        fontWeight: '500',
        whiteSpace: 'nowrap',
        overflow: 'hidden',
        textOverflow: 'ellipsis'
      }}>
        {book.authors?.map(a => a.name).join(', ') || 'Nhiều tác giả'}
      </div>

      {/* Book Title */}
      <Link to={`/books/${book.slug || book.id}`} style={{ textDecoration: 'none' }}>
        <h3 style={{
          fontSize: '14px',
          fontWeight: '700',
          color: '#1e293b',
          marginBottom: '6px',
          lineHeight: '1.35',
          display: '-webkit-box',
          WebkitLineClamp: 2,
          WebkitBoxOrient: 'vertical',
          overflow: 'hidden',
          minHeight: '38px',
          transition: 'color 0.15s ease'
        }}>
          {book.title}
        </h3>
      </Link>

      {/* Rating */}
      <div style={{ display: 'flex', alignItems: 'center', gap: '3px', color: '#f59e0b', fontWeight: '700', fontSize: '11.5px', marginBottom: '10px' }}>
        <Star size={13} fill="#f59e0b" color="#f59e0b" />
        <span>{ratingVal}</span>
      </div>

      {/* Price section & Action */}
      <div style={{ marginTop: 'auto', paddingTop: '8px', borderTop: '1px solid #f1f5f9' }}>
        <div style={{ display: 'flex', alignItems: 'baseline', gap: '8px', marginBottom: '10px' }}>
          <span style={{ fontSize: '16px', fontWeight: '800', color: '#ef4444' }}>
            {formatPrice(book.discountPrice || book.salePrice)}
          </span>
          {book.discountPrice && (
            <span style={{ fontSize: '12px', color: '#94a3b8', textDecoration: 'line-through' }}>
              {formatPrice(book.salePrice)}
            </span>
          )}
        </div>

        {/* Add to Cart button */}
        <button
          onClick={handleAddToCart}
          disabled={loading || book.stockQuantity <= 0}
          className={`btn ${added ? 'btn-secondary' : 'btn-primary'}`}
          style={{
            width: '100%',
            padding: '8px 12px',
            fontSize: '12.5px',
            fontWeight: '600',
            borderRadius: '6px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            gap: '6px'
          }}
        >
          {book.stockQuantity <= 0 ? (
            'Tạm hết hàng'
          ) : added ? (
            <>
              <Check size={15} /> Đã thêm vào giỏ
            </>
          ) : (
            <>
              <ShoppingCart size={15} /> Thêm vào giỏ
            </>
          )}
        </button>
      </div>
    </div>
  );
};

export const ProtectedRoute = ({ children, requireManager = false, requireAdmin = false }) => {
  const { isAuthenticated, isManager, isAdmin, loading } = useAuth();
  const navigate = useNavigate();

  if (loading) {
    return <LoadingSpinner text="Đang xác thực người dùng..." />;
  }

  if (!isAuthenticated) {
    return (
      <div className="container" style={{ padding: '80px 20px', textAlign: 'center' }}>
        <div className="card" style={{ maxWidth: '420px', margin: '0 auto', padding: '36px' }}>
          <h2 style={{ fontSize: '20px', fontWeight: '700', marginBottom: '12px' }}>Yêu Cầu Đăng Nhập</h2>
          <p style={{ fontSize: '14px', color: 'var(--text-muted)', marginBottom: '24px' }}>
            Vui lòng đăng nhập vào tài khoản của bạn để tiếp tục thực hiện chức năng này.
          </p>
          <button onClick={() => navigate('/login')} className="btn btn-primary" style={{ width: '100%' }}>
            Đăng nhập ngay
          </button>
        </div>
      </div>
    );
  }

  if (requireAdmin && !isAdmin) {
    return (
      <div className="container" style={{ padding: '80px 20px', textAlign: 'center' }}>
        <div className="card" style={{ maxWidth: '440px', margin: '0 auto', padding: '36px' }}>
          <h2 style={{ fontSize: '20px', fontWeight: '700', color: 'var(--danger)', marginBottom: '12px' }}>Quyền Hạn Bị Từ Chối</h2>
          <p style={{ fontSize: '14px', color: 'var(--text-muted)', marginBottom: '24px' }}>
            Khu vực này chỉ dành riêng cho Quản Trị Viên (Admin). Tài khoản Nhân viên không có quyền truy cập chức năng này.
          </p>
          <button onClick={() => navigate('/employee')} className="btn btn-primary" style={{ width: '100%' }}>
            Về kênh Nhân viên
          </button>
        </div>
      </div>
    );
  }

  if (requireManager && !isManager) {
    return (
      <div className="container" style={{ padding: '80px 20px', textAlign: 'center' }}>
        <div className="card" style={{ maxWidth: '420px', margin: '0 auto', padding: '36px' }}>
          <h2 style={{ fontSize: '20px', fontWeight: '700', color: 'var(--danger)', marginBottom: '12px' }}>Không Đủ Quyền Hạn</h2>
          <p style={{ fontSize: '14px', color: 'var(--text-muted)', marginBottom: '24px' }}>
            Trang này chỉ dành riêng cho Quản trị viên và Nhân viên hệ thống BookStore.
          </p>
          <button onClick={() => navigate('/')} className="btn btn-outline" style={{ width: '100%' }}>
            Về trang chủ
          </button>
        </div>
      </div>
    );
  }

  return children;
};

export const LoadingSpinner = ({ text = 'Đang tải dữ liệu...' }) => {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: '60px 20px' }}>
      <div style={{
        width: '36px',
        height: '36px',
        border: '3px solid #e2e8f0',
        borderTopColor: 'var(--primary)',
        borderRadius: '50%',
        animation: 'spin 0.8s linear infinite'
      }} />
      <style>{`@keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }`}</style>
      <p style={{ marginTop: '16px', fontSize: '14px', color: 'var(--text-muted)' }}>{text}</p>
    </div>
  );
};

export class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false, error: null };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true, error };
  }

  componentDidCatch(error, errorInfo) {
    console.error('ErrorBoundary caught:', error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return (
        <div className="container" style={{ padding: '80px 20px', textAlign: 'center' }}>
          <div className="card" style={{ maxWidth: '500px', margin: '0 auto', padding: '36px' }}>
            <h2 style={{ fontSize: '20px', fontWeight: '700', color: 'var(--danger)', marginBottom: '12px' }}>
              Đã xảy ra lỗi hiển thị
            </h2>
            <p style={{ fontSize: '14px', color: 'var(--text-muted)', marginBottom: '24px' }}>
              {this.state.error?.message || 'Không thể hiển thị nội dung trang này.'}
            </p>
            <button onClick={() => window.location.href = '/'} className="btn btn-primary" style={{ width: '100%' }}>
              Quay về Trang chủ
            </button>
          </div>
        </div>
      );
    }
    return this.props.children;
  }
}
