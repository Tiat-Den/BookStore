import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { ShoppingCart, Star, Check } from 'lucide-react';
import { useCart } from '../context/CartContext';
import { useAuth } from '../context/AuthContext';

export const ProductCard = ({ book }) => {
  const { addToCart } = useCart();
  const { isAuthenticated } = useAuth();
  const navigate = useNavigate();
  const [added, setAdded] = useState(false);
  const [loading, setLoading] = useState(false);

  const formatPrice = (val) => new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val);

  const handleAddToCart = async (e) => {
    e.preventDefault();
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

  const discountPercent = book.discountPrice && book.salePrice > 0
    ? Math.round(((book.salePrice - book.discountPrice) / book.salePrice) * 100)
    : 0;

  return (
    <div className="card" style={{ padding: '16px', display: 'flex', flexDirection: 'column', height: '100%', position: 'relative' }}>
      {/* Discount badge */}
      {discountPercent > 0 && (
        <span style={{
          position: 'absolute',
          top: '12px',
          left: '12px',
          backgroundColor: 'var(--danger)',
          color: '#ffffff',
          fontSize: '11px',
          fontWeight: '700',
          padding: '2px 8px',
          borderRadius: 'var(--radius-sm)',
          zIndex: 1
        }}>
          -{discountPercent}%
        </span>
      )}

      {/* Book Cover */}
      <Link to={`/books/${book.slug || book.id}`} style={{ display: 'block', aspectRatio: '3/4', overflow: 'hidden', borderRadius: 'var(--radius)', backgroundColor: '#f1f5f9', marginBottom: '14px' }}>
        <img
          src={book.coverImageUrl || 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=400&q=80'}
          alt={book.title}
          style={{ width: '100%', height: '100%', objectFit: 'cover', transition: 'transform 0.3s' }}
          onMouseEnter={(e) => e.currentTarget.style.transform = 'scale(1.04)'}
          onMouseLeave={(e) => e.currentTarget.style.transform = 'scale(1)'}
        />
      </Link>

      {/* Category / Author */}
      <div style={{ fontSize: '12px', color: 'var(--text-muted)', marginBottom: '6px' }}>
        {book.authors?.map(a => a.name).join(', ') || 'Đang cập nhật'}
      </div>

      {/* Title */}
      <Link to={`/books/${book.slug || book.id}`} style={{ textDecoration: 'none' }}>
        <h3 style={{
          fontSize: '15px',
          fontWeight: '700',
          color: 'var(--text-main)',
          marginBottom: '8px',
          lineHeight: '1.4',
          display: '-webkit-box',
          WebkitLineClamp: 2,
          WebkitBoxOrient: 'vertical',
          overflow: 'hidden',
          minHeight: '42px'
        }}>
          {book.title}
        </h3>
      </Link>

      {/* Price section */}
      <div style={{ marginTop: 'auto', paddingTop: '10px' }}>
        <div style={{ display: 'flex', alignItems: 'baseline', gap: '8px', marginBottom: '12px' }}>
          <span style={{ fontSize: '17px', fontWeight: '800', color: 'var(--primary)' }}>
            {formatPrice(book.discountPrice || book.salePrice)}
          </span>
          {book.discountPrice && (
            <span style={{ fontSize: '13px', color: 'var(--text-light)', textDecoration: 'line-through' }}>
              {formatPrice(book.salePrice)}
            </span>
          )}
        </div>

        {/* Add to Cart button */}
        <button
          onClick={handleAddToCart}
          disabled={loading || book.stockQuantity <= 0}
          className={`btn ${added ? 'btn-secondary' : 'btn-primary'}`}
          style={{ width: '100%', padding: '9px', fontSize: '13px' }}
        >
          {book.stockQuantity <= 0 ? (
            'Tạm hết hàng'
          ) : added ? (
            <>
              <Check size={16} /> Đã thêm vào giỏ
            </>
          ) : (
            <>
              <ShoppingCart size={16} /> Thêm vào giỏ
            </>
          )}
        </button>
      </div>
    </div>
  );
};

export const ProtectedRoute = ({ children, requireManager = false }) => {
  const { isAuthenticated, isManager, loading } = useAuth();
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
