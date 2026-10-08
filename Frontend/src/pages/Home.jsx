import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { BookOpen, Sparkles, TrendingUp, ArrowRight, ShieldCheck, Truck, RotateCcw } from 'lucide-react';
import { bookService, categoryService } from '../services/catalogAndOrderServices';
import { ProductCard, LoadingSpinner } from '../components/UIComponents';

export const Home = () => {
  const [featuredBooks, setFeaturedBooks] = useState([]);
  const [bestSellers, setBestSellers] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const [booksRes, bestRes, catRes] = await Promise.all([
          bookService.getBooks({ page: 1, pageSize: 8 }),
          bookService.getBooks({ page: 1, pageSize: 4, sort: 'best_seller' }),
          categoryService.getCategories(true)
        ]);

        if (booksRes.success) setFeaturedBooks(booksRes.data.items);
        if (bestRes.success) setBestSellers(bestRes.data.items);
        if (catRes.success) setCategories(catRes.data);
      } catch (err) {
        console.error('Lỗi khi tải trang chủ:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  return (
    <div>
      {/* Hero Banner */}
      <section style={{
        background: 'linear-gradient(135deg, #1e3a8a 0%, #2563eb 50%, #3b82f6 100%)',
        color: '#ffffff',
        padding: '70px 0',
        borderRadius: '0 0 32px 32px',
        marginBottom: '48px'
      }}>
        <div className="container" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(320px, 1fr))', alignItems: 'center', gap: '40px' }}>
          <div>
            <div style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', backgroundColor: 'rgba(255,255,255,0.15)', backdropFilter: 'blur(10px)', padding: '6px 14px', borderRadius: 'var(--radius-full)', fontSize: '13px', fontWeight: '600', marginBottom: '20px' }}>
              <Sparkles size={16} /> Tri Thức Là Sức Mạnh
            </div>
            <h1 style={{ fontSize: '42px', fontWeight: '800', lineHeight: '1.2', marginBottom: '20px', letterSpacing: '-1px' }}>
              Khám Phá Thế Giới Qua Từng Trang Sách Hay
            </h1>
            <p style={{ fontSize: '16px', opacity: 0.9, marginBottom: '32px', lineHeight: '1.6' }}>
              Hàng ngàn đầu sách văn học, kinh tế, công nghệ và phát triển bản thân với mức giá ưu đãi nhất cùng chính sách giao hàng toàn quốc.
            </p>
            <div style={{ display: 'flex', gap: '14px', flexWrap: 'wrap' }}>
              <Link to="/books" className="btn btn-secondary btn-lg" style={{ backgroundColor: '#ffffff', color: 'var(--primary)' }}>
                Xem Tất Cả Sách <ArrowRight size={18} />
              </Link>
              <Link to="/books?sort=best_seller" className="btn btn-outline btn-lg" style={{ borderColor: 'rgba(255,255,255,0.4)', color: '#ffffff' }}>
                Sách Bán Chạy
              </Link>
            </div>
          </div>

          <div style={{ display: 'flex', justifyContent: 'center' }}>
            <img
              src="https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=700&q=80"
              alt="Book collection"
              style={{ width: '100%', maxWidth: '440px', borderRadius: '24px', boxShadow: 'var(--shadow-xl)', transform: 'rotate(-2deg)' }}
            />
          </div>
        </div>
      </section>

      {/* Trust Badges */}
      <section className="container" style={{ marginBottom: '56px' }}>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '20px' }}>
          <div className="card" style={{ display: 'flex', alignItems: 'center', gap: '16px', padding: '20px' }}>
            <div style={{ background: '#dbeafe', color: 'var(--primary)', width: '48px', height: '48px', borderRadius: '12px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <ShieldCheck size={24} />
            </div>
            <div>
              <h4 style={{ fontSize: '15px', fontWeight: '700' }}>100% Chính Hãng</h4>
              <p style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Cam kết sách thật, chuẩn nhà xuất bản</p>
            </div>
          </div>

          <div className="card" style={{ display: 'flex', alignItems: 'center', gap: '16px', padding: '20px' }}>
            <div style={{ background: '#dcfce7', color: '#16a34a', width: '48px', height: '48px', borderRadius: '12px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <Truck size={24} />
            </div>
            <div>
              <h4 style={{ fontSize: '15px', fontWeight: '700' }}>Freeship Toàn Quốc</h4>
              <p style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Miễn phí vận chuyển đơn từ 300.000đ</p>
            </div>
          </div>

          <div className="card" style={{ display: 'flex', alignItems: 'center', gap: '16px', padding: '20px' }}>
            <div style={{ background: '#fef3c7', color: '#d97706', width: '48px', height: '48px', borderRadius: '12px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <RotateCcw size={24} />
            </div>
            <div>
              <h4 style={{ fontSize: '15px', fontWeight: '700' }}>Đổi Trả Dễ Dàng</h4>
              <p style={{ fontSize: '13px', color: 'var(--text-muted)' }}>Đổi trả miễn phí trong 7 ngày nếu lỗi</p>
            </div>
          </div>
        </div>
      </section>

      {/* Categories Grid */}
      <section className="container" style={{ marginBottom: '56px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', marginBottom: '24px' }}>
          <div>
            <span style={{ fontSize: '13px', fontWeight: '700', color: 'var(--primary)', textTransform: 'uppercase', letterSpacing: '0.5px' }}>Khám Phá</span>
            <h2 style={{ fontSize: '26px', fontWeight: '800' }}>Danh Mục Sách</h2>
          </div>
          <Link to="/books" style={{ fontSize: '14px', fontWeight: '600', color: 'var(--primary)', display: 'flex', alignItems: 'center', gap: '4px' }}>
            Xem tất cả <ArrowRight size={16} />
          </Link>
        </div>

        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(160px, 1fr))', gap: '16px' }}>
          {categories.map((cat) => (
            <Link
              key={cat.id}
              to={`/books?categoryId=${cat.id}`}
              className="card"
              style={{
                textAlign: 'center',
                padding: '24px 16px',
                textDecoration: 'none',
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                gap: '10px'
              }}
            >
              <div style={{ background: 'var(--primary-light)', color: 'var(--primary)', width: '48px', height: '48px', borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <BookOpen size={22} />
              </div>
              <span style={{ fontSize: '14px', fontWeight: '700', color: 'var(--text-main)' }}>{cat.name}</span>
              <span style={{ fontSize: '12px', color: 'var(--text-muted)' }}>{cat.bookCount || 0} sách</span>
            </Link>
          ))}
        </div>
      </section>

      {/* Featured Books */}
      <section className="container" style={{ marginBottom: '56px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', marginBottom: '24px' }}>
          <div>
            <span style={{ fontSize: '13px', fontWeight: '700', color: 'var(--primary)', textTransform: 'uppercase', letterSpacing: '0.5px' }}>Đặc Sắc</span>
            <h2 style={{ fontSize: '26px', fontWeight: '800' }}>Sách Nổi Bật Mới Nhất</h2>
          </div>
          <Link to="/books" style={{ fontSize: '14px', fontWeight: '600', color: 'var(--primary)', display: 'flex', alignItems: 'center', gap: '4px' }}>
            Xem thêm <ArrowRight size={16} />
          </Link>
        </div>

        {loading ? (
          <LoadingSpinner />
        ) : (
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '24px' }}>
            {featuredBooks.map((book) => (
              <ProductCard key={book.id} book={book} />
            ))}
          </div>
        )}
      </section>

      {/* Best Sellers */}
      {bestSellers.length > 0 && (
        <section className="container" style={{ marginBottom: '56px' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '24px' }}>
            <TrendingUp size={24} color="var(--primary)" />
            <h2 style={{ fontSize: '26px', fontWeight: '800' }}>Sách Bán Chạy Nhất</h2>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(240px, 1fr))', gap: '24px' }}>
            {bestSellers.map((book) => (
              <ProductCard key={book.id} book={book} />
            ))}
          </div>
        </section>
      )}
    </div>
  );
};
