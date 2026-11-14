import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { 
  BookOpen, TrendingUp, ArrowRight, ShieldCheck, Truck, RotateCcw, 
  Flame, Clock, Award, Headphones, Quote, Percent, ChevronLeft, ChevronRight, CheckCircle2
} from 'lucide-react';
import { bookService, categoryService } from '../services/catalogAndOrderServices';
import { ProductCard, LoadingSpinner } from '../components/UIComponents';

const CATEGORY_MAP = {
  'chinh-tri---triet-hoc': { icon: '🏛️', bg: '#fef3c7', color: '#b45309' },
  'van-hoc': { icon: '📖', bg: '#e0e7ff', color: '#4338ca' },
  'ky-nang-song': { icon: '💡', bg: '#fef9c3', color: '#a16207' },
  'the-thao': { icon: '⚽', bg: '#dcfce7', color: '#15803d' },
  'cong-nghe': { icon: '🔬', bg: '#dbeafe', color: '#1d4ed8' },
  'kinh-te': { icon: '📈', bg: '#ecfdf5', color: '#047857' },
  'thieu-nhi': { icon: '🧸', bg: '#fce7f3', color: '#be185d' },
  'giao-duc': { icon: '🎓', bg: '#ede9fe', color: '#6d28d9' },
  'lich-su---van-hoa': { icon: '⛩️', bg: '#ffedd5', color: '#c2410c' }
};

const HERO_SLIDES = [
  {
    url: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=800&q=80',
    title: 'Nuôi Dưỡng Tâm Hồn & Tri Thức',
    subtitle: 'Đọc sách mỗi ngày để mở mang tầm nhìn cuộc sống',
    tag: 'Đọc Sách Mỗi Ngày',
    badge: 'Khuyên Đọc',
    link: '/books'
  },
  {
    url: 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=800&q=80',
    title: 'Hàng Ngàn Tác Phẩm Tuyển Chọn',
    subtitle: 'Tuyển tập các cuốn sách bán chạy & kinh điển mọi thời đại',
    tag: 'Sách Bán Chạy',
    badge: 'Hot Nhất',
    link: '/books?sort=best_seller'
  },
  {
    url: 'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=800&q=80',
    title: 'Ưu Đãi & Giao Hàng Toàn Quốc',
    subtitle: 'Freeship mọi đơn hàng từ 300.000đ - Đổi trả trong 7 ngày',
    tag: 'Freeship Toàn Quốc',
    badge: 'Tiết Kiệm',
    link: '/books'
  }
];

export const Home = () => {
  const [featuredBooks, setFeaturedBooks] = useState([]);
  const [flashSaleBooks, setFlashSaleBooks] = useState([]);
  const [bestSellers, setBestSellers] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);

  // Carousel slide state & auto-play
  const [currentSlide, setCurrentSlide] = useState(0);
  const [isHovered, setIsHovered] = useState(false);

  // Countdown timer for Flash Sale (resets every 8 hours)
  const [timeLeft, setTimeLeft] = useState({ hours: 5, minutes: 42, seconds: 18 });

  useEffect(() => {
    const timer = setInterval(() => {
      setTimeLeft(prev => {
        if (prev.seconds > 0) {
          return { ...prev, seconds: prev.seconds - 1 };
        } else if (prev.minutes > 0) {
          return { ...prev, minutes: 59, seconds: 59 };
        } else if (prev.hours > 0) {
          return { hours: prev.hours - 1, minutes: 59, seconds: 59 };
        }
        return { hours: 8, minutes: 0, seconds: 0 };
      });
    }, 1000);
    return () => clearInterval(timer);
  }, []);

  useEffect(() => {
    if (isHovered) return;
    const interval = setInterval(() => {
      setCurrentSlide((prev) => (prev + 1) % HERO_SLIDES.length);
    }, 3800);

    return () => clearInterval(interval);
  }, [isHovered]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const [booksRes, bestRes, catRes] = await Promise.all([
          bookService.getBooks({ page: 1, pageSize: 8 }),
          bookService.getBooks({ page: 1, pageSize: 8, sort: 'best_seller' }),
          categoryService.getCategories(true)
        ]);

        if (booksRes.success && booksRes.data) {
          setFeaturedBooks(booksRes.data.items || []);
          // Pick discounted books or top items for Flash Sale
          const itemsWithDiscount = (booksRes.data.items || []).filter(b => b.discountPrice && b.discountPrice < b.salePrice);
          setFlashSaleBooks(itemsWithDiscount.length >= 4 ? itemsWithDiscount.slice(0, 4) : (booksRes.data.items || []).slice(0, 4));
        }
        if (bestRes.success && bestRes.data) {
          setBestSellers(bestRes.data.items || []);
        }
        if (catRes.success && catRes.data) {
          setCategories(catRes.data);
        }
      } catch (err) {
        console.error('Lỗi khi tải trang chủ:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  const padZero = (n) => String(n).padStart(2, '0');

  const handlePrevSlide = (e) => {
    if (e) {
      e.preventDefault();
      e.stopPropagation();
    }
    setCurrentSlide((prev) => (prev - 1 + HERO_SLIDES.length) % HERO_SLIDES.length);
  };

  const handleNextSlide = (e) => {
    if (e) {
      e.preventDefault();
      e.stopPropagation();
    }
    setCurrentSlide((prev) => (prev + 1) % HERO_SLIDES.length);
  };

  return (
    <div style={{ background: '#f8fafc', paddingBottom: '60px' }}>
      {/* Hero Banner Section */}
      <section style={{
        background: 'linear-gradient(135deg, #0f172a 0%, #1e3a8a 50%, #2563eb 100%)',
        color: '#ffffff',
        padding: '60px 0 70px 0',
        borderRadius: '0 0 32px 32px',
        marginBottom: '36px',
        boxShadow: '0 10px 30px -10px rgba(15, 23, 42, 0.25)',
        position: 'relative'
      }}>
        <div className="container" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(320px, 1fr))', alignItems: 'center', gap: '40px' }}>
          <div>
            <h1 style={{ fontSize: '42px', fontWeight: '800', lineHeight: '1.2', marginBottom: '18px', letterSpacing: '-0.8px' }}>
              Khám Phá Tri Thức,<br />Nâng Tầm Tương Lai
            </h1>
            <p style={{ fontSize: '16px', color: '#cbd5e1', marginBottom: '32px', lineHeight: '1.6', maxWidth: '540px' }}>
              Tập hợp các tác phẩm sách chọn lọc từ 9 danh mục chuyên sâu: Văn học, Kinh tế, Công nghệ, Lịch sử... Đầy đủ bản quyền, cam kết 100% sách thật.
            </p>
            <div style={{ display: 'flex', gap: '14px', flexWrap: 'wrap' }}>
              <Link to="/books" className="btn btn-secondary btn-lg" style={{ backgroundColor: '#ffffff', color: '#1e3a8a', fontWeight: '700', boxShadow: '0 4px 14px rgba(0,0,0,0.2)' }}>
                Khám Phá Sách Ngay <ArrowRight size={18} />
              </Link>
              <Link to="/books?sort=best_seller" className="btn btn-outline btn-lg" style={{ borderColor: 'rgba(255,255,255,0.4)', color: '#ffffff', fontWeight: '600' }}>
                <Flame size={18} color="#f97316" /> Sách Bán Chạy
              </Link>
            </div>
          </div>

          {/* Interactive Slide Container (Slidebar) */}
          <div
            style={{ display: 'flex', justifyContent: 'center' }}
            onMouseEnter={() => setIsHovered(true)}
            onMouseLeave={() => setIsHovered(false)}
          >
            <div style={{
              position: 'relative',
              width: '100%',
              maxWidth: '480px',
              height: '330px',
              borderRadius: '24px',
              overflow: 'hidden',
              boxShadow: '0 25px 50px -12px rgba(15, 23, 42, 0.5), 0 0 0 1px rgba(255, 255, 255, 0.15)',
              border: '2.5px solid rgba(255, 255, 255, 0.22)',
              backgroundColor: '#0f172a'
            }}>
              {HERO_SLIDES.map((slide, index) => (
                <Link
                  key={index}
                  to={slide.link}
                  style={{
                    position: 'absolute',
                    inset: 0,
                    opacity: currentSlide === index ? 1 : 0,
                    transform: currentSlide === index ? 'scale(1)' : 'scale(1.05)',
                    transition: 'opacity 0.6s cubic-bezier(0.4, 0, 0.2, 1), transform 0.6s cubic-bezier(0.4, 0, 0.2, 1)',
                    pointerEvents: currentSlide === index ? 'auto' : 'none',
                    textDecoration: 'none'
                  }}
                >
                  <img
                    src={slide.url}
                    alt={slide.title}
                    style={{
                      width: '100%',
                      height: '100%',
                      objectFit: 'cover'
                    }}
                  />
                  <div style={{
                    position: 'absolute',
                    inset: 0,
                    background: 'linear-gradient(to top, rgba(15, 23, 42, 0.92) 0%, rgba(15, 23, 42, 0.35) 55%, rgba(0, 0, 0, 0.2) 100%)'
                  }} />

                  {/* Slide Content Box */}
                  <div style={{
                    position: 'absolute',
                    bottom: '24px',
                    left: '22px',
                    right: '22px',
                    display: 'flex',
                    flexDirection: 'column',
                    gap: '6px'
                  }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                      <span style={{
                        backgroundColor: 'rgba(255, 255, 255, 0.22)',
                        backdropFilter: 'blur(8px)',
                        color: '#ffffff',
                        fontSize: '11px',
                        fontWeight: '800',
                        padding: '3px 10px',
                        borderRadius: '6px',
                        letterSpacing: '0.5px',
                        textTransform: 'uppercase',
                        border: '1px solid rgba(255, 255, 255, 0.25)'
                      }}>
                        {slide.tag}
                      </span>
                      <span style={{
                        backgroundColor: '#f97316',
                        color: '#ffffff',
                        fontSize: '10.5px',
                        fontWeight: '700',
                        padding: '2px 8px',
                        borderRadius: '4px'
                      }}>
                        {slide.badge}
                      </span>
                    </div>

                    <h3 style={{
                      fontSize: '18px',
                      fontWeight: '800',
                      color: '#ffffff',
                      margin: 0,
                      textShadow: '0 2px 4px rgba(0,0,0,0.6)',
                      lineHeight: '1.3'
                    }}>
                      {slide.title}
                    </h3>
                    <p style={{
                      fontSize: '13px',
                      color: '#cbd5e1',
                      margin: 0,
                      textShadow: '0 1px 3px rgba(0,0,0,0.6)'
                    }}>
                      {slide.subtitle}
                    </p>
                  </div>
                </Link>
              ))}

              {/* Slider Navigation Arrows */}
              <button
                type="button"
                onClick={handlePrevSlide}
                aria-label="Slide trước"
                style={{
                  position: 'absolute',
                  top: '50%',
                  left: '12px',
                  transform: 'translateY(-50%)',
                  width: '36px',
                  height: '36px',
                  borderRadius: '50%',
                  backgroundColor: 'rgba(15, 23, 42, 0.6)',
                  backdropFilter: 'blur(6px)',
                  border: '1px solid rgba(255, 255, 255, 0.3)',
                  color: '#ffffff',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  cursor: 'pointer',
                  zIndex: 6,
                  transition: 'all 0.2s ease',
                  padding: 0
                }}
                onMouseEnter={(e) => {
                  e.currentTarget.style.backgroundColor = '#ffffff';
                  e.currentTarget.style.color = '#0f172a';
                }}
                onMouseLeave={(e) => {
                  e.currentTarget.style.backgroundColor = 'rgba(15, 23, 42, 0.6)';
                  e.currentTarget.style.color = '#ffffff';
                }}
              >
                <ChevronLeft size={20} />
              </button>

              <button
                type="button"
                onClick={handleNextSlide}
                aria-label="Slide tiếp theo"
                style={{
                  position: 'absolute',
                  top: '50%',
                  right: '12px',
                  transform: 'translateY(-50%)',
                  width: '36px',
                  height: '36px',
                  borderRadius: '50%',
                  backgroundColor: 'rgba(15, 23, 42, 0.6)',
                  backdropFilter: 'blur(6px)',
                  border: '1px solid rgba(255, 255, 255, 0.3)',
                  color: '#ffffff',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  cursor: 'pointer',
                  zIndex: 6,
                  transition: 'all 0.2s ease',
                  padding: 0
                }}
                onMouseEnter={(e) => {
                  e.currentTarget.style.backgroundColor = '#ffffff';
                  e.currentTarget.style.color = '#0f172a';
                }}
                onMouseLeave={(e) => {
                  e.currentTarget.style.backgroundColor = 'rgba(15, 23, 42, 0.6)';
                  e.currentTarget.style.color = '#ffffff';
                }}
              >
                <ChevronRight size={20} />
              </button>

              {/* Slider Pagination Dots */}
              <div style={{
                position: 'absolute',
                bottom: '12px',
                right: '22px',
                display: 'flex',
                alignItems: 'center',
                gap: '6px',
                zIndex: 6
              }}>
                {HERO_SLIDES.map((_, idx) => (
                  <button
                    key={idx}
                    type="button"
                    onClick={(e) => {
                      e.preventDefault();
                      e.stopPropagation();
                      setCurrentSlide(idx);
                    }}
                    style={{
                      width: currentSlide === idx ? '22px' : '7px',
                      height: '7px',
                      borderRadius: '4px',
                      backgroundColor: currentSlide === idx ? '#38bdf8' : 'rgba(255, 255, 255, 0.45)',
                      border: 'none',
                      padding: 0,
                      cursor: 'pointer',
                      transition: 'all 0.3s ease'
                    }}
                    title={`Chuyển tới slide ${idx + 1}`}
                  />
                ))}
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* 4 Gold Trust Commitment Pillars */}
      <section className="container" style={{ marginBottom: '44px' }}>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '16px' }}>
          <div className="trust-pillar">
            <div style={{ background: '#eff6ff', color: '#2563eb', width: '48px', height: '48px', borderRadius: '12px', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
              <ShieldCheck size={26} />
            </div>
            <div>
              <h4 style={{ fontSize: '14.5px', fontWeight: '700', color: '#1e293b', marginBottom: '2px' }}>100% Sách Thật</h4>
              <p style={{ fontSize: '12.5px', color: '#64748b', margin: 0, lineHeight: 1.4 }}>Cam kết chuẩn NXB, hoàn tiền 200% nếu phát hiện sách giả</p>
            </div>
          </div>

          <div className="trust-pillar">
            <div style={{ background: '#ecfdf5', color: '#059669', width: '48px', height: '48px', borderRadius: '12px', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
              <Truck size={26} />
            </div>
            <div>
              <h4 style={{ fontSize: '14.5px', fontWeight: '700', color: '#1e293b', marginBottom: '2px' }}>Freeship Toàn Quốc</h4>
              <p style={{ fontSize: '12.5px', color: '#64748b', margin: 0, lineHeight: 1.4 }}>Miễn phí giao hàng đơn từ 300K, đóng gói chống sốc 3 lớp</p>
            </div>
          </div>

          <div className="trust-pillar">
            <div style={{ background: '#fef3c7', color: '#d97706', width: '48px', height: '48px', borderRadius: '12px', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
              <RotateCcw size={26} />
            </div>
            <div>
              <h4 style={{ fontSize: '14.5px', fontWeight: '700', color: '#1e293b', marginBottom: '2px' }}>Đổi Trả Trong 7 Ngày</h4>
              <p style={{ fontSize: '12.5px', color: '#64748b', margin: 0, lineHeight: 1.4 }}>1 đổi 1 miễn phí và nhanh chóng nếu phát hiện lỗi in ấn</p>
            </div>
          </div>

          <div className="trust-pillar">
            <div style={{ background: '#ede9fe', color: '#7c3aed', width: '48px', height: '48px', borderRadius: '12px', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
              <Headphones size={26} />
            </div>
            <div>
              <h4 style={{ fontSize: '14.5px', fontWeight: '700', color: '#1e293b', marginBottom: '2px' }}>Hỗ Trợ Tận Tâm 24/7</h4>
              <p style={{ fontSize: '12.5px', color: '#64748b', margin: 0, lineHeight: 1.4 }}>Hotline 1900 123 456 & AI Chatbox thông minh hỗ trợ tức thì</p>
            </div>
          </div>
        </div>
      </section>

      {/* FLASH SALE TODAY SECTION */}
      {flashSaleBooks.length > 0 && (
        <section className="container" style={{ marginBottom: '48px' }}>
          <div style={{
            background: 'linear-gradient(135deg, #fff1f2 0%, #ffe4e6 50%, #fef2f2 100%)',
            border: '2px solid #fecdd3',
            borderRadius: '18px',
            padding: '24px 28px',
            boxShadow: '0 4px 16px rgba(225, 29, 72, 0.08)'
          }}>
            {/* Header with Countdown */}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '16px', marginBottom: '22px' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                <div style={{
                  background: 'linear-gradient(135deg, #ef4444, #dc2626)',
                  color: '#ffffff',
                  padding: '6px 14px',
                  borderRadius: '9999px',
                  fontWeight: '800',
                  fontSize: '14px',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '6px',
                  boxShadow: '0 2px 8px rgba(239, 68, 68, 0.35)'
                }}>
                  <Flame size={18} fill="#ffffff" /> FLASH SALE
                </div>
                <div style={{ display: 'flex', alignItems: 'center', gap: '6px', fontSize: '13px', fontWeight: '600', color: '#475569' }}>
                  <Clock size={16} color="#dc2626" />
                  <span>Kết thúc sau:</span>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
                    <span className="countdown-digit">{padZero(timeLeft.hours)}</span>
                    <span style={{ fontWeight: '800', color: '#0f172a' }}>:</span>
                    <span className="countdown-digit">{padZero(timeLeft.minutes)}</span>
                    <span style={{ fontWeight: '800', color: '#0f172a' }}>:</span>
                    <span className="countdown-digit">{padZero(timeLeft.seconds)}</span>
                  </div>
                </div>
              </div>

              <Link to="/books?sort=best_seller" style={{
                fontSize: '13.5px',
                fontWeight: '700',
                color: '#e11d48',
                display: 'inline-flex',
                alignItems: 'center',
                gap: '4px',
                textDecoration: 'none'
              }}>
                Xem tất cả ưu đãi <ChevronRight size={16} />
              </Link>
            </div>

            {/* Flash Sale Products Grid */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(230px, 1fr))', gap: '20px' }}>
              {flashSaleBooks.map((book) => (
                <ProductCard key={book.id} book={book} />
              ))}
            </div>
          </div>
        </section>
      )}

      {/* 9 Categories Showcase */}
      <section className="container" style={{ marginBottom: '52px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', marginBottom: '22px' }}>
          <div>
            <div style={{ fontSize: '12px', fontWeight: '800', color: '#2563eb', textTransform: 'uppercase', letterSpacing: '0.8px', marginBottom: '4px' }}>
              DANH MỤC CHUYÊN SÂU
            </div>
            <h2 style={{ fontSize: '26px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
              Khám Phá 9 Thể Loại Sách
            </h2>
          </div>
          <Link to="/books" style={{ fontSize: '14px', fontWeight: '700', color: '#2563eb', display: 'flex', alignItems: 'center', gap: '4px', textDecoration: 'none' }}>
            Xem toàn bộ sách <ArrowRight size={16} />
          </Link>
        </div>

        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(180px, 1fr))', gap: '14px' }}>
          {categories.map((cat) => {
            const meta = CATEGORY_MAP[cat.slug] || { icon: '📚', bg: '#eff6ff', color: '#2563eb' };
            return (
              <Link
                key={cat.id}
                to={`/books?categoryId=${cat.id}`}
                className="card"
                style={{
                  textAlign: 'center',
                  padding: '20px 14px',
                  textDecoration: 'none',
                  display: 'flex',
                  flexDirection: 'column',
                  alignItems: 'center',
                  gap: '8px',
                  borderRadius: '12px',
                  border: '1px solid #e2e8f0',
                  transition: 'all 0.2s ease',
                  backgroundColor: '#ffffff'
                }}
                onMouseEnter={(e) => {
                  e.currentTarget.style.transform = 'translateY(-3px)';
                  e.currentTarget.style.borderColor = '#93c5fd';
                  e.currentTarget.style.boxShadow = '0 8px 20px -4px rgba(37, 99, 235, 0.12)';
                }}
                onMouseLeave={(e) => {
                  e.currentTarget.style.transform = 'translateY(0)';
                  e.currentTarget.style.borderColor = '#e2e8f0';
                  e.currentTarget.style.boxShadow = 'none';
                }}
              >
                <div style={{
                  fontSize: '26px',
                  width: '52px',
                  height: '52px',
                  borderRadius: '14px',
                  background: meta.bg,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  marginBottom: '2px'
                }}>
                  {meta.icon}
                </div>
                <span style={{ fontSize: '13.5px', fontWeight: '700', color: '#1e293b', lineHeight: 1.3 }}>
                  {cat.name}
                </span>
              </Link>
            );
          })}
        </div>
      </section>

      {/* Featured Books Section */}
      <section className="container" style={{ marginBottom: '52px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', marginBottom: '22px' }}>
          <div>
            <div style={{ fontSize: '12px', fontWeight: '800', color: '#2563eb', textTransform: 'uppercase', letterSpacing: '0.8px', marginBottom: '4px' }}>
              TUYỂN TẬP ĐỘC QUYỀN
            </div>
            <h2 style={{ fontSize: '26px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
              Sách Nổi Bật Mới Nhất
            </h2>
          </div>
          <Link to="/books" style={{ fontSize: '14px', fontWeight: '700', color: '#2563eb', display: 'flex', alignItems: 'center', gap: '4px', textDecoration: 'none' }}>
            Xem thêm <ArrowRight size={16} />
          </Link>
        </div>

        {loading ? (
          <LoadingSpinner />
        ) : (
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(230px, 1fr))', gap: '22px' }}>
            {featuredBooks.map((book) => (
              <ProductCard key={book.id} book={book} />
            ))}
          </div>
        )}
      </section>

      {/* Best Sellers Section */}
      {bestSellers.length > 0 && (
        <section className="container" style={{ marginBottom: '52px' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', marginBottom: '22px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
              <div style={{ background: '#fef3c7', color: '#d97706', padding: '6px 12px', borderRadius: '8px', display: 'flex', alignItems: 'center', gap: '6px' }}>
                <Award size={18} />
                <span style={{ fontSize: '12.5px', fontWeight: '800', textTransform: 'uppercase' }}>Bảng Xếp Hạng</span>
              </div>
              <h2 style={{ fontSize: '26px', fontWeight: '800', color: '#0f172a', margin: 0 }}>
                Top Sách Bán Chạy Nhất
              </h2>
            </div>
            <Link to="/books?sort=best_seller" style={{ fontSize: '14px', fontWeight: '700', color: '#2563eb', display: 'flex', alignItems: 'center', gap: '4px', textDecoration: 'none' }}>
              Xem toàn bộ BXH <ArrowRight size={16} />
            </Link>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(230px, 1fr))', gap: '22px' }}>
            {bestSellers.map((book) => (
              <ProductCard key={book.id} book={book} />
            ))}
          </div>
        </section>
      )}

      {/* Literary Inspiration Quote Block */}
      <section className="container" style={{ marginBottom: '40px' }}>
        <div style={{
          background: 'linear-gradient(135deg, #1e293b 0%, #0f172a 100%)',
          color: '#ffffff',
          borderRadius: '20px',
          padding: '40px 32px',
          position: 'relative',
          overflow: 'hidden',
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))',
          alignItems: 'center',
          gap: '30px'
        }}>
          <div>
            <div style={{ display: 'inline-flex', alignItems: 'center', gap: '6px', color: '#60a5fa', fontSize: '12px', fontWeight: '700', textTransform: 'uppercase', letterSpacing: '1px', marginBottom: '12px' }}>
              <Quote size={18} /> Góc Đọc Sách & Suy Ngẫm
            </div>
            <h3 style={{ fontSize: '22px', fontWeight: '700', lineHeight: 1.5, marginBottom: '14px', fontStyle: 'italic', color: '#f1f5f9' }}>
              "Một cuốn sách thực sự hay dạy tôi nhiều điều hơn là đọc nó. Tôi phải nhanh chóng đặt nó xuống, bắt đầu sống theo những gì nó gợi ý."
            </h3>
            <div style={{ fontSize: '14px', color: '#94a3b8', fontWeight: '600' }}>
              — Henry David Thoreau
            </div>
          </div>

          {/* Quick promotion promo voucher */}
          <div style={{
            background: 'rgba(255, 255, 255, 0.08)',
            border: '1px solid rgba(255, 255, 255, 0.15)',
            borderRadius: '14px',
            padding: '24px',
            backdropFilter: 'blur(10px)'
          }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '10px' }}>
              <span style={{ background: '#22c55e', color: '#ffffff', padding: '3px 8px', borderRadius: '4px', fontSize: '11px', fontWeight: '800' }}>
                VOUCHER MỚI
              </span>
              <span style={{ fontSize: '15px', fontWeight: '700', color: '#ffffff' }}>Giảm 50.000đ</span>
            </div>
            <p style={{ fontSize: '13px', color: '#cbd5e1', marginBottom: '16px', lineHeight: 1.4 }}>
              Nhập mã <strong>BOOKSTORE50</strong> khi thanh toán cho đơn hàng đầu tiên từ 250.000đ.
            </p>
            <Link to="/books" className="btn btn-primary" style={{ width: '100%', fontSize: '13px', fontWeight: '700', padding: '10px' }}>
              Áp Dụng & Mua Ngay
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
};
