import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { ShoppingCart, ArrowLeft, Check, ShieldCheck, Truck, RotateCcw, Building, User, Calendar, BookOpen, Heart, Zap, ArrowRight } from 'lucide-react';
import { bookService } from '../services/catalogAndOrderServices';
import { useCart } from '../context/CartContext';
import { useAuth } from '../context/AuthContext';
import { useWishlist } from '../context/WishlistContext';
import { LoadingSpinner, ProductCard } from '../components/UIComponents';

export const BookDetail = () => {
  const { id } = useParams(); // can be slug or id
  const navigate = useNavigate();
  const { addToCart } = useCart();
  const { isAuthenticated } = useAuth();
  const { isInWishlist, toggleWishlist } = useWishlist();

  const [book, setBook] = useState(null);
  const [loading, setLoading] = useState(true);
  const [quantity, setQuantity] = useState(1);
  const [added, setAdded] = useState(false);
  const [adding, setAdding] = useState(false);
  const [buying, setBuying] = useState(false);
  const [wishlistLoading, setWishlistLoading] = useState(false);
  const [relatedBooks, setRelatedBooks] = useState([]);

  const isWishlisted = book ? isInWishlist(book.id) : false;

  const handleToggleWishlist = async () => {
    if (!book) return;
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

  useEffect(() => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
    const fetchBook = async () => {
      setLoading(true);
      try {
        let res;
        // Check if id is GUID format
        const isGuid = /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$/.test(id);
        if (isGuid) {
          res = await bookService.getBookById(id);
        } else {
          res = await bookService.getBookBySlug(id);
        }

        if (res.success && res.data) {
          const currentBook = res.data;
          setBook(currentBook);

          // Tải danh sách sách cùng thể loại (loại trừ sách hiện tại)
          if (currentBook.categories && currentBook.categories.length > 0) {
            const primaryCat = currentBook.categories[0];
            try {
              const relRes = await bookService.getBooks({ categoryId: primaryCat.id, pageSize: 6 });
              if (relRes.success && relRes.data?.items) {
                const filtered = relRes.data.items.filter(b => b.id !== currentBook.id);
                setRelatedBooks(filtered.slice(0, 4));
              }
            } catch (relErr) {
              console.error('Lỗi khi tải sách cùng thể loại:', relErr);
            }
          }
        }
      } catch (err) {
        console.error('Lỗi khi tải chi tiết sách:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchBook();
  }, [id]);

  const formatPrice = (val) => new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(val);

  const handleAddToCart = async (e) => {
    if (e) {
      e.preventDefault();
      e.stopPropagation();
    }
    if (adding || buying) return;
    if (!isAuthenticated) {
      navigate('/login', { state: { from: `/books/${id}` } });
      return;
    }

    setAdding(true);
    const res = await addToCart(book.id, quantity);
    setAdding(false);

    if (res.success) {
      setAdded(true);
      setTimeout(() => setAdded(false), 2000);
    } else {
      alert(res.message);
    }
  };

  const handleBuyNow = async (e) => {
    if (e) {
      e.preventDefault();
      e.stopPropagation();
    }
    if (buying || adding) return;
    if (!isAuthenticated) {
      navigate('/login', { state: { from: `/books/${id}` } });
      return;
    }

    setBuying(true);
    const res = await addToCart(book.id, quantity);
    setBuying(false);

    if (res.success) {
      navigate('/checkout');
    } else {
      alert(res.message || 'Không thể tiến hành đặt mua ngay.');
    }
  };

  if (loading) return <LoadingSpinner text="Đang tải chi tiết sách..." />;
  if (!book) return (
    <div className="container" style={{ padding: '80px 20px', textAlign: 'center' }}>
      <h2>Không tìm thấy cuốn sách này.</h2>
      <Link to="/books" className="btn btn-primary" style={{ marginTop: '20px' }}>Quay lại danh sách sách</Link>
    </div>
  );

  const discountPercent = book.discountPrice && book.salePrice > 0
    ? Math.round(((book.salePrice - book.discountPrice) / book.salePrice) * 100)
    : 0;

  return (
    <div className="container" style={{ padding: '32px 20px' }}>
      {/* Breadcrumb & Back button */}
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '20px', flexWrap: 'wrap', gap: '10px' }}>
        <button onClick={() => navigate(-1)} className="btn btn-outline btn-sm" style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
          <ArrowLeft size={16} /> Quay lại
        </button>
        <div style={{ fontSize: '13px', color: '#64748b' }}>
          <Link to="/" style={{ color: '#64748b', textDecoration: 'none' }}>Trang chủ</Link>
          <span style={{ margin: '0 6px' }}>/</span>
          <Link to="/books" style={{ color: '#64748b', textDecoration: 'none' }}>Sách</Link>
          <span style={{ margin: '0 6px' }}>/</span>
          <span style={{ color: '#2563eb', fontWeight: '600' }}>{book.title}</span>
        </div>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(360px, 1fr))', gap: '40px', alignItems: 'start' }}>
        {/* Left Column: Book Cover Image & Customer Reviews */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: '28px' }}>
          {/* Book Cover Card - Edge to Edge Full Fill */}
          <div className="card" style={{
            position: 'relative',
            padding: 0,
            overflow: 'hidden',
            borderRadius: '16px',
            border: '1px solid #e2e8f0',
            aspectRatio: '3 / 4.2',
            width: '100%',
            maxWidth: '440px',
            margin: '0 auto',
            backgroundColor: '#f1f5f9',
            boxShadow: '0 10px 25px -5px rgba(15, 23, 42, 0.1)'
          }}>
            <img
              src={book.coverImageUrl || 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80'}
              alt={book.title}
              style={{
                width: '100%',
                height: '100%',
                objectFit: 'cover',
                display: 'block',
                transition: 'transform 0.4s ease'
              }}
              onError={(e) => {
                e.currentTarget.onerror = null;
                e.currentTarget.src = 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80';
              }}
            />
            {/* Quick floating wishlist button on image */}
            <button
              type="button"
              onClick={handleToggleWishlist}
              disabled={wishlistLoading}
              title={isWishlisted ? "Bỏ khỏi danh sách yêu thích" : "Thêm vào danh sách yêu thích"}
              style={{
                position: 'absolute',
                top: '16px',
                right: '16px',
                background: 'rgba(255, 255, 255, 0.92)',
                backdropFilter: 'blur(6px)',
                border: isWishlisted ? '1px solid #fecaca' : '1px solid #e2e8f0',
                borderRadius: '50%',
                width: '42px',
                height: '42px',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                cursor: 'pointer',
                boxShadow: '0 4px 12px rgba(0,0,0,0.12)',
                transition: 'transform 0.2s ease, background-color 0.2s ease',
                zIndex: 2
              }}
              onMouseEnter={(e) => { e.currentTarget.style.transform = 'scale(1.1)'; e.currentTarget.style.backgroundColor = '#ffffff'; }}
              onMouseLeave={(e) => { e.currentTarget.style.transform = 'scale(1)'; e.currentTarget.style.backgroundColor = 'rgba(255,255,255,0.92)'; }}
            >
              <Heart
                size={22}
                color={isWishlisted ? '#ef4444' : '#64748b'}
                fill={isWishlisted ? '#ef4444' : 'none'}
              />
            </button>
          </div>

          {/* Customer Reviews Section on Left Column */}
          <div className="card" style={{ padding: '24px' }}>
            <ReviewsSection bookId={book.id} isAuthenticated={isAuthenticated} />
          </div>
        </div>

        {/* Right Column: Book Details */}
        <div>
          {/* Categories tags */}
          <div style={{ display: 'flex', gap: '8px', marginBottom: '12px' }}>
            {book.categories?.map((c) => (
              <span key={c.id} className="badge badge-primary">{c.name}</span>
            ))}
          </div>

          <h1 style={{ fontSize: '32px', fontWeight: '800', lineHeight: '1.25', marginBottom: '16px' }}>
            {book.title}
          </h1>

          {/* Metadata chips */}
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: '20px', fontSize: '14px', color: 'var(--text-muted)', marginBottom: '24px' }}>
            <span style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
              Tác giả: <strong>{book.authors?.map(a => a.name).join(', ') || 'Nhiều tác giả'}</strong>
            </span>
            {book.publisherName && (
              <span style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                <Building size={16} /> NXB: <strong>{book.publisherName}</strong>
              </span>
            )}
            {book.publishedYear && (
              <span style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                <Calendar size={16} /> Năm: <strong>{book.publishedYear}</strong>
              </span>
            )}
          </div>

          {/* Pricing Box */}
          <div className="card" style={{ padding: '20px 24px', backgroundColor: '#f8fafc', marginBottom: '28px' }}>
            <div style={{ display: 'flex', alignItems: 'baseline', gap: '14px' }}>
              <span style={{ fontSize: '32px', fontWeight: '800', color: 'var(--primary)' }}>
                {formatPrice(book.discountPrice || book.salePrice)}
              </span>
              {book.discountPrice && (
                <>
                  <span style={{ fontSize: '18px', color: 'var(--text-light)', textDecoration: 'line-through' }}>
                    {formatPrice(book.salePrice)}
                  </span>
                  <span className="badge badge-danger">-{discountPercent}%</span>
                </>
              )}
            </div>

            <div style={{ marginTop: '12px', fontSize: '13px', color: 'var(--text-muted)' }}>
              Tình trạng tồn kho: {book.stockQuantity > 0 ? (
                <strong style={{ color: 'var(--success)' }}>Còn hàng</strong>
              ) : (
                <strong style={{ color: 'var(--danger)' }}>Hết hàng</strong>
              )}
            </div>
          </div>

          {/* Actions: Add to Cart & Wishlist */}
          <div style={{ display: 'flex', gap: '16px', alignItems: 'center', marginBottom: '32px', flexWrap: 'wrap' }}>
            {book.stockQuantity > 0 ? (
              <>
                {/* Quantity input - perfectly centered */}
                <div style={{
                  display: 'inline-flex',
                  alignItems: 'center',
                  border: '1.5px solid #cbd5e1',
                  borderRadius: '8px',
                  overflow: 'hidden',
                  height: '46px',
                  backgroundColor: '#ffffff'
                }}>
                  <button
                    type="button"
                    onClick={() => setQuantity(Math.max(1, quantity - 1))}
                    style={{
                      width: '42px',
                      height: '100%',
                      border: 'none',
                      borderRight: '1px solid #e2e8f0',
                      background: '#f8fafc',
                      cursor: 'pointer',
                      fontWeight: '700',
                      fontSize: '18px',
                      color: '#334155',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      transition: 'background-color 0.15s ease'
                    }}
                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f1f5f9'}
                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = '#f8fafc'}
                  >
                    -
                  </button>
                  <input
                    type="text"
                    inputMode="numeric"
                    value={quantity}
                    onChange={(e) => {
                      const val = e.target.value.replace(/\D/g, '');
                      const num = parseInt(val, 10);
                      if (!isNaN(num)) {
                        setQuantity(Math.min(book.stockQuantity, Math.max(1, num)));
                      }
                    }}
                    onBlur={() => {
                      if (!quantity || quantity < 1) setQuantity(1);
                    }}
                    style={{
                      width: '54px',
                      height: '100%',
                      border: 'none',
                      textAlign: 'center',
                      fontSize: '15px',
                      fontWeight: '700',
                      color: '#0f172a',
                      outline: 'none',
                      backgroundColor: '#ffffff',
                      padding: 0,
                      margin: 0,
                      lineHeight: '46px'
                    }}
                  />
                  <button
                    type="button"
                    onClick={() => setQuantity(Math.min(book.stockQuantity, quantity + 1))}
                    style={{
                      width: '42px',
                      height: '100%',
                      border: 'none',
                      borderLeft: '1px solid #e2e8f0',
                      background: '#f8fafc',
                      cursor: 'pointer',
                      fontWeight: '700',
                      fontSize: '18px',
                      color: '#334155',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      transition: 'background-color 0.15s ease'
                    }}
                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f1f5f9'}
                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = '#f8fafc'}
                  >
                    +
                  </button>
                </div>

                {/* Add to Cart Button */}
                <button
                  type="button"
                  onClick={handleAddToCart}
                  disabled={adding || buying}
                  className={`btn ${added ? 'btn-secondary' : 'btn-outline'} btn-lg`}
                  style={{
                    flex: '1 1 180px',
                    minHeight: '48px',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    gap: '8px',
                    fontWeight: '700',
                    fontSize: '15px',
                    borderColor: 'var(--primary)',
                    color: added ? '#ffffff' : 'var(--primary)'
                  }}
                >
                  {added ? (
                    <>
                      <Check size={20} /> Đã thêm vào giỏ
                    </>
                  ) : (
                    <>
                      <ShoppingCart size={20} /> {adding ? 'Đang thêm...' : 'Thêm vào giỏ'}
                    </>
                  )}
                </button>

                {/* Buy Now Button */}
                <button
                  type="button"
                  onClick={handleBuyNow}
                  disabled={buying || adding}
                  className="btn btn-lg"
                  style={{
                    flex: '1 1 170px',
                    minHeight: '48px',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    gap: '8px',
                    fontWeight: '700',
                    fontSize: '15px',
                    color: '#ffffff',
                    background: 'linear-gradient(135deg, #f97316 0%, #ea580c 100%)',
                    border: 'none',
                    boxShadow: '0 4px 14px rgba(234, 88, 12, 0.35)',
                    cursor: 'pointer',
                    borderRadius: 'var(--radius)',
                    transition: 'all 0.2s ease'
                  }}
                  onMouseEnter={(e) => {
                    e.currentTarget.style.transform = 'translateY(-2px)';
                    e.currentTarget.style.boxShadow = '0 6px 18px rgba(234, 88, 12, 0.45)';
                  }}
                  onMouseLeave={(e) => {
                    e.currentTarget.style.transform = 'translateY(0)';
                    e.currentTarget.style.boxShadow = '0 4px 14px rgba(234, 88, 12, 0.35)';
                  }}
                >
                  <Zap size={18} fill="#ffffff" /> {buying ? 'Đang chuyển...' : 'Mua Ngay'}
                </button>
              </>
            ) : (
              <button disabled className="btn btn-secondary btn-lg" style={{ flex: 1, minHeight: '48px', opacity: 0.6, cursor: 'not-allowed' }}>
                Tạm thời hết hàng
              </button>
            )}

            {/* Wishlist Button */}
            <button
              type="button"
              onClick={handleToggleWishlist}
              disabled={wishlistLoading}
              className="btn btn-lg"
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                justifyContent: 'center',
                gap: '8px',
                height: '48px',
                padding: '0 22px',
                borderRadius: 'var(--radius)',
                border: isWishlisted ? '1.5px solid #f87171' : '1.5px solid var(--border)',
                color: isWishlisted ? '#ef4444' : '#475569',
                backgroundColor: isWishlisted ? '#fef2f2' : '#ffffff',
                boxShadow: 'var(--shadow-sm)',
                transition: 'all 0.2s ease',
                cursor: 'pointer'
              }}
              onMouseEnter={(e) => {
                if (!isWishlisted) {
                  e.currentTarget.style.borderColor = '#fca5a5';
                  e.currentTarget.style.backgroundColor = '#fff5f5';
                  e.currentTarget.style.color = '#ef4444';
                }
              }}
              onMouseLeave={(e) => {
                if (!isWishlisted) {
                  e.currentTarget.style.borderColor = 'var(--border)';
                  e.currentTarget.style.backgroundColor = '#ffffff';
                  e.currentTarget.style.color = '#475569';
                }
              }}
              title={isWishlisted ? "Bỏ khỏi danh sách yêu thích" : "Lưu vào danh sách yêu thích"}
            >
              <Heart
                size={20}
                color={isWishlisted ? '#ef4444' : 'currentColor'}
                fill={isWishlisted ? '#ef4444' : 'none'}
              />
              <span style={{ fontSize: '15px', fontWeight: '600' }}>
                {isWishlisted ? 'Đã yêu thích' : 'Yêu thích'}
              </span>
            </button>
          </div>

          {/* Trust Guarantees */}
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(180px, 1fr))', gap: '12px', padding: '16px', background: '#f8fafc', borderRadius: '12px', border: '1px solid #e2e8f0', marginBottom: '28px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
              <ShieldCheck size={20} color="#2563eb" />
              <div>
                <div style={{ fontSize: '13px', fontWeight: '700', color: '#1e293b' }}>100% Sách Thật</div>
                <div style={{ fontSize: '11px', color: '#64748b' }}>Đền 200% nếu sách giả</div>
              </div>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
              <Truck size={20} color="#059669" />
              <div>
                <div style={{ fontSize: '13px', fontWeight: '700', color: '#1e293b' }}>Giao Toàn Quốc</div>
                <div style={{ fontSize: '11px', color: '#64748b' }}>Freeship từ 300.000đ</div>
              </div>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
              <RotateCcw size={20} color="#d97706" />
              <div>
                <div style={{ fontSize: '13px', fontWeight: '700', color: '#1e293b' }}>Đổi Trả 7 Ngày</div>
                <div style={{ fontSize: '11px', color: '#64748b' }}>Miễn phí nếu lỗi in ấn</div>
              </div>
            </div>
          </div>

          {/* Description */}
          <div>
            <h3 style={{ fontSize: '18px', fontWeight: '700', marginBottom: '12px', borderBottom: '1px solid var(--border)', paddingBottom: '8px' }}>
              Mô Tả Tác Phẩm
            </h3>
            <p style={{ fontSize: '15px', color: '#334155', lineHeight: '1.8', whiteSpace: 'pre-line' }}>
              {book.description || 'Chưa có thông tin mô tả chi tiết cho cuốn sách này.'}
            </p>
          </div>

          {/* Specifications table */}
          <div style={{ marginTop: '28px' }}>
            <h3 style={{ fontSize: '18px', fontWeight: '700', marginBottom: '12px', borderBottom: '1px solid var(--border)', paddingBottom: '8px' }}>
              Thông Tin Chi Tiết
            </h3>
            <table className="table" style={{ fontSize: '13px' }}>
              <tbody>
                <tr>
                  <td style={{ width: '180px', color: 'var(--text-muted)' }}>Mã ISBN</td>
                  <td><strong>{book.isbn}</strong></td>
                </tr>
                {book.pageCount && (
                  <tr>
                    <td style={{ color: 'var(--text-muted)' }}>Số trang</td>
                    <td>{book.pageCount} trang</td>
                  </tr>
                )}
                {book.language && (
                  <tr>
                    <td style={{ color: 'var(--text-muted)' }}>Ngôn ngữ</td>
                    <td>{book.language}</td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>

      {/* Sách Cùng Thể Loại Section */}
      {relatedBooks.length > 0 && (
        <div style={{ marginTop: '56px', borderTop: '1px solid #e2e8f0', paddingTop: '40px' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', marginBottom: '24px', flexWrap: 'wrap', gap: '12px' }}>
            <div>
              <div style={{ fontSize: '13px', fontWeight: '700', color: '#2563eb', textTransform: 'uppercase', letterSpacing: '0.5px', marginBottom: '4px' }}>
                Gợi ý cho bạn
              </div>
              <h2 style={{ fontSize: '24px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
                Sách Cùng Thể Loại
              </h2>
            </div>
            {book.categories && book.categories.length > 0 && (
              <Link
                to={`/books?categoryId=${book.categories[0].id}`}
                style={{
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: '6px',
                  color: '#2563eb',
                  fontWeight: '600',
                  fontSize: '14px',
                  textDecoration: 'none'
                }}
              >
                Xem tất cả sách {book.categories[0].name} <ArrowRight size={16} />
              </Link>
            )}
          </div>

          <div style={{
            display: 'grid',
            gridTemplateColumns: 'repeat(auto-fill, minmax(230px, 1fr))',
            gap: '24px'
          }}>
            {relatedBooks.map((relBook) => (
              <ProductCard key={relBook.id} book={relBook} />
            ))}
          </div>
        </div>
      )}
    </div>
  );
};

const ReviewsSection = ({ bookId, isAuthenticated }) => {
  const [reviews, setReviews] = useState([]);
  const [rating, setRating] = useState(5);
  const [content, setContent] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [msg, setMsg] = useState('');

  const fetchReviews = async () => {
    try {
      const res = await (await import('../services/marketingServices')).reviewService.getBookReviews(bookId);
      if (res.success) setReviews(res.data);
    } catch (e) {
      console.error(e);
    }
  };

  useEffect(() => {
    fetchReviews();
  }, [bookId]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!content.trim()) return;
    setSubmitting(true);
    setMsg('');
    try {
      const res = await (await import('../services/marketingServices')).reviewService.createReview(bookId, rating, content.trim());
      if (res.success) {
        setMsg('Cảm ơn bạn đã gửi đánh giá!');
        setContent('');
        fetchReviews();
      } else {
        setMsg(res.message || 'Không thể gửi đánh giá.');
      }
    } catch (err) {
      setMsg(err.message || 'Lỗi khi gửi đánh giá.');
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div>
      <h3 style={{ fontSize: '18px', fontWeight: '700', marginBottom: '16px', borderBottom: '1px solid var(--border)', paddingBottom: '8px' }}>
        Đánh Giá & Nhận Xét ({reviews.length})
      </h3>

      {/* Write review form (for buyers) */}
      {isAuthenticated ? (
        <form onSubmit={handleSubmit} className="card" style={{ padding: '20px', marginBottom: '24px', backgroundColor: '#f8fafc' }}>
          <h4 style={{ fontSize: '15px', fontWeight: '700', marginBottom: '12px' }}>Viết đánh giá của bạn</h4>
          {msg && (
            <div style={{ fontSize: '13px', fontWeight: '600', color: msg.includes('Cảm ơn') ? 'var(--success)' : 'var(--danger)', marginBottom: '12px' }}>
              {msg}
            </div>
          )}
          <div style={{ display: 'flex', gap: '8px', alignItems: 'center', marginBottom: '12px' }}>
            <span style={{ fontSize: '13px', fontWeight: '600' }}>Số sao đánh giá:</span>
            <select className="select" value={rating} onChange={(e) => setRating(parseInt(e.target.value))} style={{ width: '100px', padding: '6px 10px' }}>
              <option value="5">★★★★★</option>
              <option value="4">★★★★☆</option>
              <option value="3">★★★☆☆</option>
              <option value="2">★★☆☆☆</option>
              <option value="1">★☆☆☆☆</option>
            </select>
          </div>
          <div className="form-group">
            <textarea
              className="textarea"
              rows="3"
              required
              placeholder="Chia sẻ cảm nhận chân thực của bạn sau khi đọc cuốn sách này..."
              value={content}
              onChange={(e) => setContent(e.target.value)}
            />
          </div>
          <button type="submit" disabled={submitting} className="btn btn-primary btn-sm">
            {submitting ? 'Đang gửi...' : 'Gửi Đánh Giá'}
          </button>
        </form>
      ) : (
        <div style={{ fontSize: '13px', color: 'var(--text-muted)', marginBottom: '20px' }}>
          Vui lòng <Link to="/login" style={{ color: 'var(--primary)', fontWeight: '600' }}>đăng nhập</Link> bằng tài khoản đã mua sách để gửi đánh giá.
        </div>
      )}

      {/* Reviews list */}
      {reviews.length === 0 ? (
        <p style={{ fontSize: '14px', color: 'var(--text-muted)', fontStyle: 'italic' }}>Chưa có đánh giá nào cho cuốn sách này.</p>
      ) : (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '14px' }}>
          {reviews.map((r) => (
            <div key={r.id} className="card" style={{ padding: '16px' }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '8px' }}>
                <strong style={{ fontSize: '14px' }}>{r.userName}</strong>
                <span style={{ color: '#eab308', fontSize: '14px' }}>{'★'.repeat(r.rating)}{'☆'.repeat(5 - r.rating)}</span>
              </div>
              <p style={{ fontSize: '14px', color: '#334155', lineHeight: '1.5' }}>{r.content}</p>
              <small style={{ color: 'var(--text-light)', marginTop: '8px', display: 'block' }}>{new Date(r.createdAt).toLocaleDateString('vi-VN')}</small>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};
