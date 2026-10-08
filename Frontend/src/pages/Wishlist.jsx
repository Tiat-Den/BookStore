import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { Heart, ShoppingCart, Trash2, ArrowRight } from 'lucide-react';
import { wishlistService } from '../services/marketingServices';
import { useCart } from '../context/CartContext';
import { LoadingSpinner } from '../components/UIComponents';

export const Wishlist = () => {
  const [wishlist, setWishlist] = useState({ items: [] });
  const [loading, setLoading] = useState(true);
  const { addToCart } = useCart();

  const fetchWishlist = async () => {
    try {
      setLoading(true);
      const res = await wishlistService.getWishlist();
      if (res.success && res.data) setWishlist(res.data);
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchWishlist();
  }, []);

  const handleRemove = async (bookId) => {
    const res = await wishlistService.removeFromWishlist(bookId);
    if (res.success) setWishlist(res.data);
  };

  const handleAddToCart = async (bookId) => {
    const res = await addToCart(bookId, 1);
    if (res.success) {
      alert('Đã thêm sách vào giỏ hàng!');
    } else {
      alert(res.message);
    }
  };

  const formatPrice = (val) => new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val);

  if (loading) return <LoadingSpinner text="Đang tải danh sách yêu thích..." />;

  const items = wishlist.items || [];

  return (
    <div className="container" style={{ padding: '36px 20px' }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '24px' }}>
        <Heart size={26} color="var(--danger)" fill="var(--danger)" />
        <h1 style={{ fontSize: '28px', fontWeight: '800' }}>Sách Yêu Thích Của Tôi ({items.length})</h1>
      </div>

      {items.length === 0 ? (
        <div className="card" style={{ textAlign: 'center', padding: '60px 20px' }}>
          <Heart size={56} color="var(--text-light)" style={{ margin: '0 auto 16px' }} />
          <h3 style={{ fontSize: '18px', fontWeight: '700', marginBottom: '8px' }}>Danh sách yêu thích trống</h3>
          <p style={{ fontSize: '14px', color: 'var(--text-muted)', marginBottom: '20px' }}>
            Hãy bấm vào biểu tượng trái tim để lưu lại những cuốn sách bạn yêu thích để mua sau nhé.
          </p>
          <Link to="/books" className="btn btn-primary">Khám phá sách ngay <ArrowRight size={16} /></Link>
        </div>
      ) : (
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '24px' }}>
          {items.map((item) => (
            <div key={item.id} className="card" style={{ padding: '16px', display: 'flex', flexDirection: 'column' }}>
              <Link to={`/books/${item.slug || item.bookId}`} style={{ display: 'block', aspectRatio: '3/4', borderRadius: 'var(--radius)', overflow: 'hidden', marginBottom: '12px' }}>
                <img
                  src={item.coverImageUrl || 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=400&q=80'}
                  alt={item.title}
                  style={{ width: '100%', height: '100%', objectFit: 'cover' }}
                />
              </Link>

              <Link to={`/books/${item.slug || item.bookId}`}>
                <h4 style={{ fontSize: '15px', fontWeight: '700', color: 'var(--text-main)', marginBottom: '8px', lineHeight: '1.4' }}>
                  {item.title}
                </h4>
              </Link>

              <div style={{ marginTop: 'auto', paddingTop: '10px' }}>
                <div style={{ fontSize: '16px', fontWeight: '800', color: 'var(--primary)', marginBottom: '12px' }}>
                  {formatPrice(item.discountPrice || item.salePrice)}
                </div>

                <div style={{ display: 'flex', gap: '8px' }}>
                  <button onClick={() => handleAddToCart(item.bookId)} className="btn btn-primary btn-sm" style={{ flex: 1 }}>
                    <ShoppingCart size={15} /> Thêm giỏ
                  </button>
                  <button onClick={() => handleRemove(item.bookId)} className="btn btn-danger btn-sm" title="Xóa khỏi yêu thích">
                    <Trash2 size={15} />
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};
