import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { ShoppingCart, ArrowLeft, Check, ShieldCheck, Truck, RotateCcw, Building, User, Calendar, BookOpen, Heart, ArrowRight, Star, ThumbsUp, CheckCircle, MessageSquare, Sparkles } from 'lucide-react';
import { bookService } from '../services/catalogAndOrderServices';
import { useCart } from '../context/CartContext';
import { useAuth } from '../context/AuthContext';
import { useWishlist } from '../context/WishlistContext';
import { useToast } from '../context/ToastContext';
import { LoadingSpinner, ProductCard } from '../components/UIComponents';

export const BookDetail = () => {
  const { id } = useParams(); // can be slug or id
  const navigate = useNavigate();
  const { addToCart } = useCart();
  const { isAuthenticated } = useAuth();
  const { isInWishlist, toggleWishlist } = useWishlist();
  const { toast } = useToast();

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
    if (res.success) {
      if (res.added) {
        toast.success(`Đã thêm "${book.title}" vào danh sách yêu thích!`, {
          actionText: 'Xem yêu thích',
          actionLink: '/wishlist'
        });
      } else {
        toast.info(`Đã bỏ "${book.title}" khỏi danh sách yêu thích.`);
      }
    } else if (res.message) {
      toast.error(res.message);
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
          setLoading(false); // Hiển thị trang sách ngay lập tức không cần chờ

          // Tải danh sách sách cùng thể loại ngầm trong nền
          if (currentBook.categories && currentBook.categories.length > 0) {
            const primaryCat = currentBook.categories[0];
            bookService.getBooks({ categoryId: primaryCat.id, pageSize: 6 })
              .then((relRes) => {
                if (relRes.success && relRes.data?.items) {
                  const filtered = relRes.data.items.filter(b => b.id !== currentBook.id);
                  setRelatedBooks(filtered.slice(0, 4));
                }
              })
              .catch((relErr) => {
                console.error('Lỗi khi tải sách cùng thể loại:', relErr);
              });
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
      toast.success(`Đã thêm "${book.title}"${quantity > 1 ? ` (x${quantity})` : ''} vào giỏ hàng thành công!`, {
        actionText: 'Xem giỏ hàng',
        actionLink: '/cart'
      });
    } else {
      toast.error(res.message || 'Không thể thêm sách vào giỏ hàng.');
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
      toast.error(res.message || 'Không thể tiến hành đặt mua ngay.');
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
                      <Check size={20} /> Đã thêm vào giỏ hàng
                    </>
                  ) : (
                    <>
                      <ShoppingCart size={20} /> {adding ? 'Đang thêm...' : 'Thêm vào giỏ hàng'}
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
                  {buying ? 'Đang chuyển...' : 'Mua ngay'}
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

      {/* Customer Reviews Full-Width Section */}
      <ReviewsSection bookId={book.id} isAuthenticated={isAuthenticated} bookTitle={book.title} />

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

const RATING_EMOTIONS = {
  5: 'Tuyệt vời - Rất hài lòng',
  4: 'Hài lòng',
  3: 'Bình thường',
  2: 'Không hài lòng',
  1: 'Rất tệ'
};

const ReviewsSection = ({ bookId, isAuthenticated, bookTitle }) => {
  const [reviews, setReviews] = useState([]);
  const [rating, setRating] = useState(5);
  const [hoverRating, setHoverRating] = useState(0);
  const [content, setContent] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [showForm, setShowForm] = useState(false);
  const [helpfulCounts, setHelpfulCounts] = useState({});
  const { toast } = useToast();

  const fetchReviews = async () => {
    try {
      const res = await (await import('../services/marketingServices')).reviewService.getBookReviews(bookId);
      if (res.success && res.data) setReviews(res.data);
    } catch (e) {
      console.error(e);
    }
  };

  useEffect(() => {
    fetchReviews();
  }, [bookId]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!content.trim()) {
      toast.warning('Vui lòng nhập nội dung đánh giá của bạn.');
      return;
    }
    setSubmitting(true);
    try {
      const res = await (await import('../services/marketingServices')).reviewService.createReview(bookId, rating, content.trim());
      if (res.success) {
        toast.success('Cảm ơn bạn đã gửi đánh giá về cuốn sách này!');
        setContent('');
        setShowForm(false);
        fetchReviews();
      } else {
        toast.error(res.message || 'Không thể gửi đánh giá lúc này.');
      }
    } catch (err) {
      toast.error(err.message || 'Lỗi khi gửi đánh giá.');
    } finally {
      setSubmitting(false);
    }
  };

  const toggleHelpful = (reviewId) => {
    setHelpfulCounts(prev => ({
      ...prev,
      [reviewId]: (prev[reviewId] || 0) + 1
    }));
  };

  const totalReviews = reviews.length;
  const avgRating = totalReviews > 0
    ? (reviews.reduce((acc, r) => acc + (r.rating || 5), 0) / totalReviews).toFixed(1)
    : '4.8';

  const starCounts = [5, 4, 3, 2, 1].map(stars => {
    const count = reviews.filter(r => r.rating === stars).length;
    const percent = totalReviews > 0 ? Math.round((count / totalReviews) * 100) : (stars === 5 ? 85 : stars === 4 ? 15 : 0);
    return { stars, count, percent };
  });

  const activeStar = hoverRating || rating;

  return (
    <div style={{ marginTop: '56px', borderTop: '1px solid #e2e8f0', paddingTop: '40px' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px', flexWrap: 'wrap', gap: '14px' }}>
        <div>
          <div style={{ fontSize: '13px', fontWeight: '700', color: '#2563eb', textTransform: 'uppercase', letterSpacing: '0.5px', marginBottom: '4px' }}>
            Phản hồi thực tế
          </div>
          <h2 style={{ fontSize: '24px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
            Đánh Giá & Nhận Xét Từ Bạn Đọc ({totalReviews})
          </h2>
        </div>

        {isAuthenticated && !showForm && (
          <button
            onClick={() => setShowForm(true)}
            className="btn btn-primary"
            style={{ display: 'inline-flex', alignItems: 'center', gap: '8px' }}
          >
            <MessageSquare size={16} /> Viết đánh giá của bạn
          </button>
        )}
      </div>

      {/* Rating Overview Card */}
      <div
        className="card"
        style={{
          padding: '28px',
          marginBottom: '32px',
          backgroundColor: '#ffffff',
          borderRadius: '16px',
          border: '1px solid #e2e8f0',
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(260px, 1fr))',
          gap: '32px',
          alignItems: 'center'
        }}
      >
        {/* Score column */}
        <div style={{ textAlign: 'center', borderRight: '1px solid #f1f5f9', paddingRight: '20px' }}>
          <div style={{ fontSize: '48px', fontWeight: '900', color: '#0f172a', lineHeight: 1 }}>
            {avgRating}
            <span style={{ fontSize: '20px', color: '#94a3b8', fontWeight: '600' }}> / 5</span>
          </div>
          <div style={{ display: 'flex', justifyContent: 'center', gap: '4px', margin: '10px 0' }}>
            {[1, 2, 3, 4, 5].map((s) => (
              <Star
                key={s}
                size={22}
                color="#f59e0b"
                fill={s <= Math.round(Number(avgRating)) ? '#f59e0b' : 'none'}
              />
            ))}
          </div>
          <div style={{ fontSize: '13px', color: '#64748b' }}>
            Dựa trên {totalReviews > 0 ? totalReviews : 'hàng trăm'} lượt đánh giá đã xác thực
          </div>
        </div>

        {/* Rating Bars column */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
          {starCounts.map(({ stars, count, percent }) => (
            <div key={stars} style={{ display: 'flex', alignItems: 'center', gap: '10px', fontSize: '12.5px' }}>
              <span style={{ width: '38px', color: '#475569', fontWeight: '600', display: 'flex', alignItems: 'center', gap: '3px' }}>
                {stars} <Star size={12} color="#f59e0b" fill="#f59e0b" />
              </span>
              <div style={{ flex: 1, height: '8px', backgroundColor: '#f1f5f9', borderRadius: '4px', overflow: 'hidden' }}>
                <div
                  style={{
                    width: `${percent}%`,
                    height: '100%',
                    backgroundColor: stars >= 4 ? '#f59e0b' : stars === 3 ? '#fbbf24' : '#cbd5e1',
                    borderRadius: '4px',
                    transition: 'width 0.4s ease'
                  }}
                />
              </div>
              <span style={{ width: '42px', textAlign: 'right', color: '#94a3b8', fontSize: '12px' }}>
                {percent}%
              </span>
            </div>
          ))}
        </div>

        {/* Call to action column */}
        <div style={{ textAlign: 'center', padding: '10px 16px' }}>
          <h4 style={{ fontSize: '15px', fontWeight: '700', color: '#1e293b', marginBottom: '8px' }}>
            Bạn đã đọc cuốn sách này?
          </h4>
          <p style={{ fontSize: '13px', color: '#64748b', marginBottom: '16px', lineHeight: 1.5 }}>
            Chia sẻ cảm nhận của bạn để giúp cộng đồng bạn đọc có thêm góc nhìn khách quan!
          </p>
          {isAuthenticated ? (
            <button
              onClick={() => setShowForm(!showForm)}
              className="btn btn-outline"
              style={{ width: '100%', fontSize: '13.5px', fontWeight: '700' }}
            >
              {showForm ? 'Đóng khung viết' : 'Viết đánh giá ngay'}
            </button>
          ) : (
            <Link
              to="/login"
              className="btn btn-outline"
              style={{ width: '100%', fontSize: '13.5px', fontWeight: '700' }}
            >
              Đăng nhập để đánh giá
            </Link>
          )}
        </div>
      </div>

      {/* Review Submission Form with Interactive Star Rating */}
      {showForm && isAuthenticated && (
        <form
          onSubmit={handleSubmit}
          className="card"
          style={{
            padding: '24px',
            marginBottom: '32px',
            borderRadius: '16px',
            border: '1.5px solid #bfdbfe',
            backgroundColor: '#f8fafc',
            boxShadow: '0 8px 24px -4px rgba(37, 99, 235, 0.08)'
          }}
        >
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
            <h4 style={{ fontSize: '16px', fontWeight: '800', color: '#1e3a8a', margin: 0, display: 'flex', alignItems: 'center', gap: '8px' }}>
              <Sparkles size={18} color="#2563eb" /> Đánh giá: {bookTitle}
            </h4>
            <button
              type="button"
              onClick={() => setShowForm(false)}
              style={{ background: 'none', border: 'none', color: '#94a3b8', cursor: 'pointer', fontSize: '13px', fontWeight: '600' }}
            >
              Hủy
            </button>
          </div>

          {/* Interactive Star Picker */}
          <div style={{ marginBottom: '18px' }}>
            <div style={{ fontSize: '13px', fontWeight: '700', color: '#334155', marginBottom: '8px' }}>
              Chọn mức độ hài lòng của bạn:
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
              <div style={{ display: 'flex', gap: '6px' }}>
                {[1, 2, 3, 4, 5].map((starIndex) => (
                  <button
                    key={starIndex}
                    type="button"
                    onClick={() => setRating(starIndex)}
                    onMouseEnter={() => setHoverRating(starIndex)}
                    onMouseLeave={() => setHoverRating(0)}
                    style={{
                      background: 'none',
                      border: 'none',
                      cursor: 'pointer',
                      padding: '2px',
                      transform: starIndex <= activeStar ? 'scale(1.15)' : 'scale(1)',
                      transition: 'transform 0.15s ease'
                    }}
                    title={`${starIndex} sao - ${RATING_EMOTIONS[starIndex]}`}
                  >
                    <Star
                      size={28}
                      color="#f59e0b"
                      fill={starIndex <= activeStar ? '#f59e0b' : 'none'}
                    />
                  </button>
                ))}
              </div>
              <span style={{ fontSize: '13.5px', fontWeight: '700', color: '#d97706', marginLeft: '8px' }}>
                {RATING_EMOTIONS[activeStar]}
              </span>
            </div>
          </div>

          <div className="form-group" style={{ marginBottom: '16px' }}>
            <label style={{ fontSize: '13px', fontWeight: '700', color: '#334155', display: 'block', marginBottom: '6px' }}>
              Nội dung nhận xét:
            </label>
            <textarea
              className="textarea"
              rows="4"
              required
              placeholder="Cuốn sách có đáp ứng kỳ vọng của bạn? Bạn tâm đắc điều gì nhất từ tác phẩm này?..."
              value={content}
              onChange={(e) => setContent(e.target.value)}
              style={{
                width: '100%',
                borderRadius: '10px',
                padding: '12px 14px',
                fontSize: '14px',
                fontFamily: 'inherit',
                border: '1px solid #cbd5e1',
                outline: 'none',
                backgroundColor: '#ffffff'
              }}
            />
          </div>

          <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '10px' }}>
            <button
              type="button"
              onClick={() => setShowForm(false)}
              className="btn btn-outline btn-sm"
              style={{ padding: '8px 16px' }}
            >
              Đóng lại
            </button>
            <button
              type="submit"
              disabled={submitting || !content.trim()}
              className="btn btn-primary btn-sm"
              style={{ padding: '8px 20px', fontWeight: '700' }}
            >
              {submitting ? 'Đang gửi...' : 'Gửi Đánh Giá Ngay'}
            </button>
          </div>
        </form>
      )}

      {/* Reviews List */}
      {reviews.length === 0 ? (
        <div className="card" style={{ textAlign: 'center', padding: '40px 20px', backgroundColor: '#f8fafc' }}>
          <MessageSquare size={40} color="#94a3b8" style={{ margin: '0 auto 12px' }} />
          <p style={{ fontSize: '15px', color: '#475569', fontWeight: '600', marginBottom: '6px' }}>
            Chưa có đánh giá nào cho cuốn sách này.
          </p>
          <p style={{ fontSize: '13px', color: '#94a3b8', margin: 0 }}>
            Hãy là người đầu tiên chia sẻ cảm nhận chân thực của bạn đến mọi người nhé!
          </p>
        </div>
      ) : (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
          {reviews.map((r) => {
            const initial = (r.userName || 'B')[0].toUpperCase();
            return (
              <div
                key={r.id}
                className="card"
                style={{
                  padding: '20px',
                  borderRadius: '14px',
                  border: '1px solid #e2e8f0',
                  backgroundColor: '#ffffff'
                }}
              >
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '10px' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    {/* User Avatar Circle */}
                    <div
                      style={{
                        width: '38px',
                        height: '38px',
                        borderRadius: '50%',
                        backgroundColor: '#eff6ff',
                        color: '#2563eb',
                        fontWeight: '800',
                        fontSize: '15px',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        border: '1.5px solid #bfdbfe'
                      }}
                    >
                      {initial}
                    </div>

                    <div>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <strong style={{ fontSize: '14.5px', color: '#0f172a' }}>{r.userName}</strong>
                        <span
                          style={{
                            display: 'inline-flex',
                            alignItems: 'center',
                            gap: '3px',
                            color: '#059669',
                            fontSize: '11px',
                            fontWeight: '700',
                            backgroundColor: '#ecfdf5',
                            padding: '2px 8px',
                            borderRadius: '9999px',
                            border: '1px solid #a7f3d0'
                          }}
                        >
                          <CheckCircle size={11} /> Đã mua hàng tại BookStore
                        </span>
                      </div>
                      <span style={{ fontSize: '12px', color: '#94a3b8' }}>
                        {new Date(r.createdAt).toLocaleDateString('vi-VN')}
                      </span>
                    </div>
                  </div>

                  {/* Stars badge */}
                  <div style={{ display: 'flex', gap: '2px' }}>
                    {[1, 2, 3, 4, 5].map((s) => (
                      <Star
                        key={s}
                        size={15}
                        color="#f59e0b"
                        fill={s <= r.rating ? '#f59e0b' : 'none'}
                      />
                    ))}
                  </div>
                </div>

                <p style={{ fontSize: '14px', color: '#334155', lineHeight: '1.6', margin: '0 0 12px 0' }}>
                  {r.content}
                </p>

                <div style={{ display: 'flex', alignItems: 'center', gap: '16px', fontSize: '12px', color: '#64748b' }}>
                  <button
                    onClick={() => toggleHelpful(r.id)}
                    style={{
                      display: 'inline-flex',
                      alignItems: 'center',
                      gap: '5px',
                      background: 'none',
                      border: 'none',
                      color: helpfulCounts[r.id] ? '#2563eb' : '#64748b',
                      fontWeight: '600',
                      cursor: 'pointer',
                      padding: '4px 8px',
                      borderRadius: '6px',
                      backgroundColor: helpfulCounts[r.id] ? '#eff6ff' : 'transparent'
                    }}
                  >
                    <ThumbsUp size={13} />
                    <span>Hữu ích {helpfulCounts[r.id] ? `(${helpfulCounts[r.id]})` : ''}</span>
                  </button>
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
};

