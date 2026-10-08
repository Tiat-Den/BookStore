import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { ShoppingCart, ArrowLeft, Check, ShieldCheck, Truck, RotateCcw, Building, User, Calendar, BookOpen } from 'lucide-react';
import { bookService } from '../services/catalogAndOrderServices';
import { useCart } from '../context/CartContext';
import { useAuth } from '../context/AuthContext';
import { LoadingSpinner } from '../components/UIComponents';

export const BookDetail = () => {
  const { id } = useParams(); // can be slug or id
  const navigate = useNavigate();
  const { addToCart } = useCart();
  const { isAuthenticated } = useAuth();

  const [book, setBook] = useState(null);
  const [loading, setLoading] = useState(true);
  const [quantity, setQuantity] = useState(1);
  const [added, setAdded] = useState(false);
  const [adding, setAdding] = useState(false);

  useEffect(() => {
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
          setBook(res.data);
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
    if (adding) return;
    if (!isAuthenticated) {
      navigate('/login');
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
      <button onClick={() => navigate(-1)} className="btn btn-outline btn-sm" style={{ marginBottom: '24px' }}>
        <ArrowLeft size={16} /> Quay lại
      </button>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(360px, 1fr))', gap: '48px', alignItems: 'start' }}>
        {/* Book Cover Image */}
        <div className="card" style={{ padding: '24px', display: 'flex', justifyContent: 'center' }}>
          <img
            src={book.coverImageUrl || 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80'}
            alt={book.title}
            style={{ width: '100%', maxWidth: '380px', maxHeight: '520px', objectFit: 'cover', borderRadius: 'var(--radius)', boxShadow: 'var(--shadow-lg)' }}
          />
        </div>

        {/* Book Details */}
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
              <User size={16} /> Tác giả: <strong>{book.authors?.map(a => a.name).join(', ') || 'Nhiều tác giả'}</strong>
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
                <strong style={{ color: 'var(--success)' }}>Còn hàng ({book.stockQuantity} cuốn)</strong>
              ) : (
                <strong style={{ color: 'var(--danger)' }}>Hết hàng</strong>
              )}
            </div>
          </div>

          {/* Add to Cart Actions */}
          {book.stockQuantity > 0 && (
            <div style={{ display: 'flex', gap: '16px', alignItems: 'center', marginBottom: '32px' }}>
              {/* Quantity input */}
              <div style={{ display: 'flex', alignItems: 'center', border: '1px solid var(--border)', borderRadius: 'var(--radius)', overflow: 'hidden' }}>
                <button
                  onClick={() => setQuantity(Math.max(1, quantity - 1))}
                  style={{ width: '38px', height: '42px', border: 'none', background: '#f1f5f9', cursor: 'pointer', fontWeight: '700' }}
                >
                  -
                </button>
                <input
                  type="number"
                  value={quantity}
                  onChange={(e) => setQuantity(Math.min(book.stockQuantity, Math.max(1, parseInt(e.target.value) || 1)))}
                  style={{ width: '56px', height: '42px', border: 'none', textAlign: 'center', fontSize: '15px', fontWeight: '600', outline: 'none' }}
                />
                <button
                  onClick={() => setQuantity(Math.min(book.stockQuantity, quantity + 1))}
                  style={{ width: '38px', height: '42px', border: 'none', background: '#f1f5f9', cursor: 'pointer', fontWeight: '700' }}
                >
                  +
                </button>
              </div>

              {/* Add Button */}
              <button
                onClick={handleAddToCart}
                disabled={adding}
                className={`btn ${added ? 'btn-secondary' : 'btn-primary'} btn-lg`}
                style={{ flex: 1 }}
              >
                {added ? (
                  <>
                    <Check size={20} /> Đã thêm {quantity} cuốn vào giỏ
                  </>
                ) : (
                  <>
                    <ShoppingCart size={20} /> Thêm vào giỏ hàng
                  </>
                )}
              </button>
            </div>
          )}

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

          {/* Customer Reviews Section */}
          <div style={{ marginTop: '40px' }}>
            <ReviewsSection bookId={book.id} isAuthenticated={isAuthenticated} />
          </div>
        </div>
      </div>
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
            <select className="select" value={rating} onChange={(e) => setRating(parseInt(e.target.value))} style={{ width: '130px', padding: '6px 10px' }}>
              <option value="5">★★★★★ (5 sao)</option>
              <option value="4">★★★★☆ (4 sao)</option>
              <option value="3">★★★☆☆ (3 sao)</option>
              <option value="2">★★☆☆☆ (2 sao)</option>
              <option value="1">★☆☆☆☆ (1 sao)</option>
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
