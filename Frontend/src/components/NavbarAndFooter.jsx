import React, { useState, useEffect, useRef } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { 
  BookOpen, ShoppingCart, User, Search, LogOut, Shield, Heart, Tag, ShoppingBag,
  ChevronDown, FileText, ShieldCheck, Truck, CreditCard, HelpCircle, Phone, 
  Menu, X, Flame, Clock, Award, CheckCircle2, Send, Building, MapPin
} from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import { useCart } from '../context/CartContext';
import { useWishlist } from '../context/WishlistContext';
import { categoryService } from '../services/catalogAndOrderServices';
import bookStoreLogo from '../assets/book-store-logo.png';
import boCongThuongLogo from '../assets/bo-cong-thuong.png';
import vnpayLogo from '../assets/vnpay-logo.svg';
import momoLogo from '../assets/momo-logo.png';
import codLogo from '../assets/cod-logo.png';

const POPULAR_SEARCHES = ['Đắc Nhân Tâm', 'Mắt Biếc', 'Sapiens', 'Tư Duy Nhanh & Chậm', 'Kinh Tế', 'Dế Mèn'];

const STATIC_CATEGORIES = [
  { name: 'Chính trị - Triết học', slug: 'chinh-tri---triet-hoc', icon: '🏛️' },
  { name: 'Văn học', slug: 'van-hoc', icon: '📖' },
  { name: 'Kỹ năng - Tâm lý', slug: 'ky-nang-song', icon: '💡' },
  { name: 'Thể thao', slug: 'the-thao', icon: '⚽' },
  { name: 'Khoa học - Kỹ thuật', slug: 'cong-nghe', icon: '🔬' },
  { name: 'Kinh tế - Quản trị', slug: 'kinh-te', icon: '📈' },
  { name: 'Thiếu nhi', slug: 'thieu-nhi', icon: '🧸' },
  { name: 'Giáo dục', slug: 'giao-duc', icon: '🎓' },
  { name: 'Lịch sử - Văn hóa', slug: 'lich-su---van-hoa', icon: '⛩️' }
];

export const Navbar = () => {
  const { user, isAuthenticated, isManager, isAdmin, logout } = useAuth();
  const { totalItems } = useCart();
  const { totalItems: totalWishlistItems } = useWishlist();
  const [keyword, setKeyword] = useState('');
  const [menuOpen, setMenuOpen] = useState(false);
  const [policyOpen, setPolicyOpen] = useState(false);
  const [catMenuOpen, setCatMenuOpen] = useState(false);
  const [categories, setCategories] = useState(STATIC_CATEGORIES);
  const userMenuRef = useRef(null);
  const policyMenuRef = useRef(null);
  const catMenuRef = useRef(null);
  const navigate = useNavigate();
  const location = useLocation();

  useEffect(() => {
    categoryService.getCategories(true).then((res) => {
      if (res.success && res.data && res.data.length > 0) {
        // Merge with icons
        const merged = res.data.map(c => {
          const matched = STATIC_CATEGORIES.find(sc => sc.slug === c.slug);
          return { ...c, icon: matched ? matched.icon : '📚' };
        });
        setCategories(merged);
      }
    }).catch(() => {});
  }, []);

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (userMenuRef.current && !userMenuRef.current.contains(event.target)) {
        setMenuOpen(false);
      }
      if (policyMenuRef.current && !policyMenuRef.current.contains(event.target)) {
        setPolicyOpen(false);
      }
      if (catMenuRef.current && !catMenuRef.current.contains(event.target)) {
        setCatMenuOpen(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    document.addEventListener('touchstart', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
      document.removeEventListener('touchstart', handleClickOutside);
    };
  }, []);

  // Close menus on route change
  useEffect(() => {
    setCatMenuOpen(false);
    setPolicyOpen(false);
    setMenuOpen(false);
  }, [location.pathname, location.search]);

  const handleSearch = (e) => {
    e.preventDefault();
    if (keyword.trim()) {
      navigate(`/books?keyword=${encodeURIComponent(keyword.trim())}`);
    } else {
      navigate('/books');
    }
  };

  return (
    <header style={{ position: 'sticky', top: 0, zIndex: 100, backgroundColor: '#ffffff', boxShadow: '0 2px 10px rgba(0,0,0,0.06)' }}>
      {/* 1. Top Utility Announcement Bar */}
      <div className="top-utility-bar">
        <div className="container" style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '8px' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
            <span style={{ display: 'inline-flex', alignItems: 'center', gap: '5px', color: '#f59e0b', fontWeight: '700' }}>
              <Tag size={13} /> ƯU ĐÃI HÔM NAY:
            </span>
            <span>Freeship toàn quốc từ <strong>200.000đ</strong> (mã <strong>FREESHIP</strong>) | Giảm 15% cho bạn mới (mã <strong>BANMOI15</strong>)</span>
          </div>

          <div style={{ display: 'flex', alignItems: 'center', gap: '16px', fontSize: '12px' }}>
            <span style={{ display: 'flex', alignItems: 'center', gap: '5px' }}>
              <Phone size={13} color="#60a5fa" /> Hotline: <strong style={{ color: '#ffffff' }}>1900 123 456</strong>
            </span>
            <span style={{ color: 'rgba(255,255,255,0.2)' }}>|</span>
            <Link to="/orders" style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
              <ShoppingBag size={13} /> Tra cứu đơn hàng
            </Link>
            <span style={{ color: 'rgba(255,255,255,0.2)' }}>|</span>
            <Link to="/shipping-policy">Chính sách vận chuyển</Link>
          </div>
        </div>
      </div>

      {/* 2. Main Header */}
      <div style={{ borderBottom: '1px solid var(--border)', backgroundColor: '#ffffff' }}>
        <div className="container" style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', height: '76px', gap: '20px' }}>
          
          {/* Brand Logo */}
          <Link to="/" style={{ display: 'flex', alignItems: 'center', textDecoration: 'none', flexShrink: 0 }}>
            <img 
              src={bookStoreLogo} 
              alt="BOOK STORE" 
              style={{ 
                height: '48px', 
                width: 'auto',
                objectFit: 'contain',
                display: 'block',
                transition: 'transform 0.25s ease'
              }} 
              onMouseEnter={(e) => (e.currentTarget.style.transform = 'scale(1.04)')}
              onMouseLeave={(e) => (e.currentTarget.style.transform = 'scale(1)')}
            />
          </Link>

          {/* Mega Category Trigger */}
          <div ref={catMenuRef} style={{ position: 'relative', flexShrink: 0 }}>
            <button
              onClick={() => setCatMenuOpen(!catMenuOpen)}
              type="button"
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: '8px',
                padding: '10px 16px',
                borderRadius: 'var(--radius)',
                backgroundColor: catMenuOpen ? 'var(--primary)' : 'var(--primary-light)',
                color: catMenuOpen ? '#ffffff' : 'var(--primary)',
                border: '1px solid transparent',
                fontSize: '14px',
                fontWeight: '700',
                cursor: 'pointer',
                transition: 'all 0.2s ease'
              }}
            >
              <Menu size={18} />
              <span>Danh Mục Sách</span>
              <ChevronDown size={15} style={{ transform: catMenuOpen ? 'rotate(180deg)' : 'none', transition: 'transform 0.2s' }} />
            </button>

            {/* Mega Category Dropdown */}
            {catMenuOpen && (
              <div style={{
                position: 'absolute',
                top: 'calc(100% + 10px)',
                left: 0,
                width: '320px',
                backgroundColor: '#ffffff',
                borderRadius: '16px',
                boxShadow: '0 20px 30px -10px rgba(15, 23, 42, 0.2), 0 0 0 1px rgba(0,0,0,0.06)',
                padding: '12px',
                zIndex: 300,
                animation: 'fadeIn 0.2s ease'
              }}>
                <div style={{ fontSize: '11px', fontWeight: '800', color: 'var(--text-light)', textTransform: 'uppercase', letterSpacing: '0.8px', padding: '6px 12px 10px' }}>
                  9 Danh Mục Tuyển Chọn
                </div>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '3px' }}>
                  {categories.map((c) => (
                    <Link
                      key={c.id || c.slug}
                      to={`/books?category=${c.slug}`}
                      onClick={() => setCatMenuOpen(false)}
                      style={{
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'space-between',
                        padding: '10px 12px',
                        borderRadius: '10px',
                        textDecoration: 'none',
                        color: 'var(--text-main)',
                        fontSize: '14px',
                        fontWeight: '600',
                        transition: 'all 0.15s ease'
                      }}
                      onMouseEnter={(e) => {
                        e.currentTarget.style.backgroundColor = '#eff6ff';
                        e.currentTarget.style.color = 'var(--primary)';
                        e.currentTarget.style.transform = 'translateX(4px)';
                      }}
                      onMouseLeave={(e) => {
                        e.currentTarget.style.backgroundColor = 'transparent';
                        e.currentTarget.style.color = 'var(--text-main)';
                        e.currentTarget.style.transform = 'translateX(0)';
                      }}
                    >
                      <span style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                        <span style={{ fontSize: '18px' }}>{c.icon || '📚'}</span>
                        <span>{c.name}</span>
                      </span>
                    </Link>
                  ))}
                </div>
                <div style={{ borderTop: '1px solid var(--border)', marginTop: '8px', paddingTop: '8px' }}>
                  <Link
                    to="/books"
                    onClick={() => setCatMenuOpen(false)}
                    style={{
                      display: 'block',
                      textAlign: 'center',
                      padding: '8px',
                      fontSize: '13px',
                      fontWeight: '700',
                      color: 'var(--primary)',
                      borderRadius: '8px',
                      backgroundColor: '#f8fafc'
                    }}
                  >
                    Xem tất cả 155+ tác phẩm →
                  </Link>
                </div>
              </div>
            )}
          </div>

          {/* Search Bar with Quick Chips */}
          <div style={{ flex: 1, maxWidth: '560px' }}>
            <form onSubmit={handleSearch} style={{ position: 'relative' }}>
              <input
                type="text"
                className="input"
                placeholder="Tìm kiếm theo tên sách, tác giả, nhà xuất bản, ISBN..."
                value={keyword}
                onChange={(e) => setKeyword(e.target.value)}
                style={{
                  paddingLeft: '44px',
                  paddingRight: '100px',
                  height: '44px',
                  borderRadius: 'var(--radius-full)',
                  border: '2px solid #e2e8f0',
                  fontSize: '14px',
                  boxShadow: '0 2px 6px rgba(0,0,0,0.03)'
                }}
              />
              <Search size={19} color="var(--primary)" style={{ position: 'absolute', left: '16px', top: '13px' }} />
              
              <button
                type="submit"
                style={{
                  position: 'absolute',
                  right: '4px',
                  top: '4px',
                  bottom: '4px',
                  backgroundColor: 'var(--primary)',
                  color: '#ffffff',
                  border: 'none',
                  borderRadius: 'var(--radius-full)',
                  padding: '0 18px',
                  fontSize: '13px',
                  fontWeight: '700',
                  cursor: 'pointer',
                  transition: 'background-color 0.15s ease'
                }}
                onMouseEnter={(e) => (e.currentTarget.style.backgroundColor = 'var(--primary-hover)')}
                onMouseLeave={(e) => (e.currentTarget.style.backgroundColor = 'var(--primary)')}
              >
                Tìm Kiếm
              </button>
            </form>

            {/* Quick Suggested Tags */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '6px', marginTop: '6px', overflowX: 'auto', whiteSpace: 'nowrap' }}>
              <span style={{ fontSize: '11px', color: 'var(--text-light)', fontWeight: '600' }}>Gợi ý:</span>
              {POPULAR_SEARCHES.map((tag) => (
                <Link
                  key={tag}
                  to={`/books?keyword=${encodeURIComponent(tag)}`}
                  className="search-chip"
                >
                  {tag}
                </Link>
              ))}
            </div>
          </div>

          {/* User actions: Wishlist, Policy, Cart, Account */}
          <nav style={{ display: 'flex', alignItems: 'center', gap: '14px', flexShrink: 0 }}>
            {/* Wishlist */}
            <Link
              to="/wishlist"
              title="Sách yêu thích"
              style={{
                position: 'relative',
                width: '42px',
                height: '42px',
                borderRadius: '50%',
                backgroundColor: '#f8fafc',
                border: '1px solid #e2e8f0',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                color: 'var(--text-main)',
                transition: 'all 0.15s ease'
              }}
              onMouseEnter={(e) => {
                e.currentTarget.style.backgroundColor = '#fee2e2';
                e.currentTarget.style.color = '#ef4444';
              }}
              onMouseLeave={(e) => {
                e.currentTarget.style.backgroundColor = '#f8fafc';
                e.currentTarget.style.color = 'var(--text-main)';
              }}
            >
              <Heart size={20} />
              {totalWishlistItems > 0 && (
                <span style={{
                  position: 'absolute',
                  top: '-4px',
                  right: '-4px',
                  backgroundColor: 'var(--danger)',
                  color: '#ffffff',
                  fontSize: '10px',
                  fontWeight: '800',
                  borderRadius: '9999px',
                  minWidth: '18px',
                  height: '18px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  padding: '0 4px',
                  border: '2px solid #ffffff'
                }}>
                  {totalWishlistItems}
                </span>
              )}
            </Link>

            {/* Cart with Price Preview */}
            <Link
              to="/cart"
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: '8px',
                padding: '9px 16px',
                borderRadius: 'var(--radius-full)',
                backgroundColor: 'var(--primary-light)',
                color: 'var(--primary)',
                textDecoration: 'none',
                fontWeight: '700',
                fontSize: '14px',
                position: 'relative',
                transition: 'all 0.15s ease',
                border: '1px solid rgba(37, 99, 235, 0.2)'
              }}
              onMouseEnter={(e) => {
                e.currentTarget.style.backgroundColor = 'var(--primary)';
                e.currentTarget.style.color = '#ffffff';
              }}
              onMouseLeave={(e) => {
                e.currentTarget.style.backgroundColor = 'var(--primary-light)';
                e.currentTarget.style.color = 'var(--primary)';
              }}
            >
              <ShoppingCart size={19} />
              <span>Giỏ Hàng</span>
              {totalItems > 0 && (
                <span style={{
                  backgroundColor: 'var(--danger)',
                  color: '#ffffff',
                  fontSize: '11px',
                  fontWeight: '800',
                  borderRadius: '9999px',
                  padding: '1px 7px',
                  marginLeft: '2px'
                }}>
                  {totalItems}
                </span>
              )}
            </Link>

            {/* User Account / Auth */}
            {isAuthenticated ? (
              <div ref={userMenuRef} style={{ position: 'relative' }}>
                <button
                  onClick={() => setMenuOpen(!menuOpen)}
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '8px',
                    padding: '7px 14px',
                    borderRadius: 'var(--radius-full)',
                    border: '1px solid #e2e8f0',
                    backgroundColor: '#ffffff',
                    cursor: 'pointer',
                    fontSize: '13px',
                    fontWeight: '700',
                    color: 'var(--text-main)',
                    boxShadow: '0 1px 3px rgba(0,0,0,0.04)'
                  }}
                >
                  <div style={{
                    width: '28px',
                    height: '28px',
                    borderRadius: '50%',
                    backgroundColor: 'var(--primary)',
                    color: '#ffffff',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    fontSize: '12px',
                    fontWeight: '800'
                  }}>
                    {(user?.fullName || user?.username || 'U')[0].toUpperCase()}
                  </div>
                  <span style={{ maxWidth: '120px', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                    {user?.fullName || user?.username}
                  </span>
                  <ChevronDown size={13} color="var(--text-muted)" />
                </button>

                {menuOpen && (
                  <div style={{
                    position: 'absolute',
                    right: 0,
                    top: 'calc(100% + 8px)',
                    backgroundColor: '#ffffff',
                    boxShadow: 'var(--shadow-xl)',
                    borderRadius: '14px',
                    border: '1px solid var(--border)',
                    minWidth: '220px',
                    padding: '8px 0',
                    zIndex: 200
                  }}>
                    <div style={{ padding: '10px 16px', borderBottom: '1px solid var(--border)' }}>
                      <p style={{ fontSize: '14px', fontWeight: '800', color: 'var(--text-main)' }}>{user?.fullName || user?.username}</p>
                      <p style={{ fontSize: '11px', color: 'var(--text-muted)', marginTop: '2px' }}>{user?.email}</p>
                    </div>

                    <Link to="/profile" onClick={() => setMenuOpen(false)} style={{ display: 'flex', alignItems: 'center', gap: '10px', padding: '10px 16px', fontSize: '13px', color: 'var(--text-main)', textDecoration: 'none' }}>
                      <User size={15} color="var(--primary)" /> Thông tin tài khoản
                    </Link>

                    <Link to="/orders" onClick={() => setMenuOpen(false)} style={{ display: 'flex', alignItems: 'center', gap: '10px', padding: '10px 16px', fontSize: '13px', color: 'var(--text-main)', textDecoration: 'none' }}>
                      <ShoppingBag size={15} color="var(--primary)" /> Đơn hàng của tôi
                    </Link>

                    <Link to="/wishlist" onClick={() => setMenuOpen(false)} style={{ display: 'flex', alignItems: 'center', gap: '10px', padding: '10px 16px', fontSize: '13px', color: 'var(--text-main)', textDecoration: 'none' }}>
                      <Heart size={15} color="var(--danger)" /> Sách yêu thích
                    </Link>

                    {isAdmin && (
                      <Link to="/admin" onClick={() => setMenuOpen(false)} style={{ display: 'flex', alignItems: 'center', gap: '10px', padding: '10px 16px', fontSize: '13px', color: 'var(--primary)', fontWeight: '700', backgroundColor: '#eff6ff', textDecoration: 'none' }}>
                        <Shield size={15} /> Trang Quản Trị Admin
                      </Link>
                    )}

                    {!isAdmin && isManager && (
                      <Link to="/employee" onClick={() => setMenuOpen(false)} style={{ display: 'flex', alignItems: 'center', gap: '10px', padding: '10px 16px', fontSize: '13px', color: '#16a34a', fontWeight: '700', backgroundColor: '#f0fdf4', textDecoration: 'none' }}>
                        <Shield size={15} /> Kênh Nhân Viên
                      </Link>
                    )}

                    <div style={{ borderTop: '1px solid var(--border)', margin: '4px 0' }} />

                    <button
                      onClick={() => { setMenuOpen(false); logout(); }}
                      style={{
                        width: '100%',
                        textAlign: 'left',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '10px',
                        padding: '10px 16px',
                        fontSize: '13px',
                        color: 'var(--danger)',
                        background: 'none',
                        border: 'none',
                        cursor: 'pointer',
                        fontWeight: '600'
                      }}
                    >
                      <LogOut size={15} /> Đăng xuất
                    </button>
                  </div>
                )}
              </div>
            ) : (
              <div style={{ display: 'flex', gap: '8px' }}>
                <Link to="/login" className="btn btn-outline btn-sm" style={{ fontWeight: '700' }}>
                  Đăng nhập
                </Link>
                <Link to="/register" className="btn btn-primary btn-sm" style={{ fontWeight: '700' }}>
                  Đăng ký
                </Link>
              </div>
            )}
          </nav>
        </div>
      </div>

      {/* 3. Sub-Navbar (Quick Category Bar) */}
      <nav className="sub-navbar">
        <div className="container" style={{ display: 'flex', alignItems: 'center', gap: '2px', overflowX: 'auto', scrollbarWidth: 'none' }}>
          <Link
            to="/books"
            className={`sub-nav-item ${location.pathname === '/books' && !location.search ? 'active' : ''}`}
            style={{ fontWeight: '700', color: 'var(--primary)' }}
          >
            📚 Tất cả sách
          </Link>

          {categories.map((c) => (
            <Link
              key={c.id || c.slug}
              to={`/books?category=${c.slug}`}
              className={`sub-nav-item ${location.search.includes(c.slug) ? 'active' : ''}`}
            >
              <span>{c.icon || '📖'}</span>
              <span>{c.name}</span>
            </Link>
          ))}

          <Link
            to="/books?sort=discount"
            className="sub-nav-item"
            style={{ color: '#ef4444', fontWeight: '700', marginLeft: 'auto' }}
          >
            <Flame size={15} /> Flash Sale
          </Link>
        </div>
      </nav>
    </header>
  );
};

export const Footer = () => {
  const [email, setEmail] = useState('');
  const [subscribed, setSubscribed] = useState(false);

  const handleSubscribe = (e) => {
    e.preventDefault();
    if (email.trim()) {
      setSubscribed(true);
      setTimeout(() => setSubscribed(false), 3000);
      setEmail('');
    }
  };

  return (
    <footer style={{ backgroundColor: '#ffffff', borderTop: '1px solid var(--border)', marginTop: '80px' }}>
      {/* 1. Newsletter Banner */}
      <div style={{ backgroundColor: '#f8fafc', borderBottom: '1px solid #e2e8f0', padding: '36px 0' }}>
        <div className="container" style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '24px' }}>
          <div>
            <span style={{ fontSize: '12px', fontWeight: '800', color: 'var(--primary)', textTransform: 'uppercase', letterSpacing: '0.5px' }}>
              Bản Tin Sách BOOK STORE
            </span>
            <h3 style={{ fontSize: '22px', fontWeight: '800', color: '#0f172a', marginTop: '4px' }}>
              Đăng Ký Nhận Tin & Voucher 50.000đ
            </h3>
            <p style={{ fontSize: '13px', color: 'var(--text-muted)', marginTop: '4px' }}>
              Cập nhật sớm nhất các tựa sách mới phát hành, sự kiện giao lưu tác giả và mã giảm giá độc quyền.
            </p>
          </div>

          <form onSubmit={handleSubscribe} style={{ display: 'flex', gap: '8px', minWidth: '340px' }}>
            <input
              type="email"
              className="input"
              placeholder="Nhập địa chỉ email của bạn..."
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
              style={{ height: '46px', borderRadius: '10px' }}
            />
            <button
              type="submit"
              className="btn btn-primary"
              style={{ height: '46px', padding: '0 22px', borderRadius: '10px', fontWeight: '700', whiteSpace: 'nowrap' }}
            >
              {subscribed ? <CheckCircle2 size={18} /> : <Send size={16} />}
              {subscribed ? 'Đã Đăng Ký!' : 'Đăng Ký'}
            </button>
          </form>
        </div>
      </div>

      {/* 2. Main Footer Links */}
      <div className="container" style={{ padding: '56px 20px 32px' }}>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(230px, 1fr))', gap: '40px', marginBottom: '48px' }}>
          {/* Brand & Contact */}
          <div>
            <Link to="/" style={{ display: 'inline-block', marginBottom: '16px' }}>
              <img 
                src={bookStoreLogo} 
                alt="BOOK STORE" 
                style={{ height: '42px', width: 'auto', objectFit: 'contain' }} 
              />
            </Link>
            <p style={{ fontSize: '13px', color: 'var(--text-muted)', lineHeight: '1.7', marginBottom: '16px' }}>
              Hệ thống phát hành và phân phối sách trực tuyến uy tín hàng đầu Việt Nam. Nơi hội tụ tinh hoa tri thức nhân loại với hơn 150+ đầu sách tuyển chọn.
            </p>
            <div style={{ fontSize: '13px', color: '#334155', display: 'flex', flexDirection: 'column', gap: '8px' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                <Phone size={15} color="var(--primary)" /> Hotline đặt hàng: <strong>1900 123 456</strong>
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                <Clock size={15} color="var(--primary)" /> Thời gian phục vụ: 8h00 - 21h00 (Tất cả các ngày)
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                <Building size={15} color="var(--primary)" /> Địa chỉ: Bà Rịa - Vũng Tàu, TP. Hồ Chí Minh
              </div>
            </div>
          </div>

          {/* Categories */}
          <div>
            <h4 style={{ fontSize: '15px', fontWeight: '800', color: '#0f172a', marginBottom: '18px', textTransform: 'uppercase', letterSpacing: '0.4px' }}>
              Danh Mục Sách
            </h4>
            <ul style={{ listStyle: 'none', fontSize: '13px', color: 'var(--text-muted)', display: 'flex', flexDirection: 'column', gap: '10px' }}>
              <li><Link to="/books?category=van-hoc" style={{ transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>📖 Văn học kinh điển & Đương đại</Link></li>
              <li><Link to="/books?category=kinh-te" style={{ transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>📈 Kinh tế - Quản trị - Tài chính</Link></li>
              <li><Link to="/books?category=ky-nang-song" style={{ transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>💡 Kỹ năng sống & Tâm lý học</Link></li>
              <li><Link to="/books?category=cong-nghe" style={{ transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>🔬 Khoa học - Công nghệ - Lập trình</Link></li>
              <li><Link to="/books?category=lich-su---van-hoa" style={{ transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>⛩️ Lịch sử - Văn hóa truyền thống</Link></li>
              <li><Link to="/books?category=thieu-nhi" style={{ transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>🧸 Văn học thiếu nhi & Tranh truyện</Link></li>
            </ul>
          </div>

          {/* Customer Service & Policies */}
          <div>
            <h4 style={{ fontSize: '15px', fontWeight: '800', color: '#0f172a', marginBottom: '18px', textTransform: 'uppercase', letterSpacing: '0.4px' }}>
              Chính Sách & Hỗ Trợ
            </h4>
            <ul style={{ listStyle: 'none', fontSize: '13px', color: 'var(--text-muted)', display: 'flex', flexDirection: 'column', gap: '10px' }}>
              <li><Link to="/shipping-policy" style={{ transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>Chính sách giao hàng & cước phí</Link></li>
              <li><Link to="/payment-guide" style={{ transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>Phương thức thanh toán bảo mật</Link></li>
              <li><Link to="/terms" style={{ transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>Chính sách đổi trả trong 7 ngày</Link></li>
              <li><Link to="/privacy" style={{ transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>Chính sách bảo mật thông tin</Link></li>
              <li><Link to="/orders" style={{ transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>Kiểm tra tình trạng đơn hàng</Link></li>
            </ul>
          </div>

          {/* Trust Badges & Payments */}
          <div>
            <h4 style={{ fontSize: '15px', fontWeight: '800', color: '#0f172a', marginBottom: '16px', textTransform: 'uppercase', letterSpacing: '0.4px' }}>
              Chứng Nhận & Thanh Toán
            </h4>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
              {/* MoIT Certificate Official Logo */}
              <div>
                <a
                  href="http://online.gov.vn"
                  target="_blank"
                  rel="noopener noreferrer"
                  style={{ display: 'inline-block', transition: 'transform 0.2s ease' }}
                  onMouseEnter={(e) => (e.currentTarget.style.transform = 'scale(1.03)')}
                  onMouseLeave={(e) => (e.currentTarget.style.transform = 'scale(1)')}
                  title="Website đã đăng ký & thông báo Bộ Công Thương"
                >
                  <img
                    src={boCongThuongLogo}
                    alt="Đã thông báo Bộ Công Thương"
                    style={{ height: '44px', width: 'auto', display: 'block', objectFit: 'contain' }}
                  />
                </a>
              </div>

              {/* Payment Method Logos */}
              <div>
                <div style={{ fontSize: '12px', fontWeight: '700', color: '#475569', marginBottom: '10px' }}>
                  Phương thức thanh toán
                </div>
                <div style={{ display: 'flex', gap: '8px', flexWrap: 'wrap', alignItems: 'center' }}>
                  {/* COD */}
                  <div
                    title="Thanh toán khi nhận hàng (COD)"
                    style={{
                      background: '#ffffff',
                      border: '1px solid #e2e8f0',
                      borderRadius: '8px',
                      padding: '4px 10px',
                      height: '34px',
                      display: 'inline-flex',
                      alignItems: 'center',
                      gap: '6px',
                      boxShadow: '0 1px 3px rgba(0,0,0,0.04)',
                      transition: 'transform 0.15s ease'
                    }}
                    onMouseEnter={(e) => (e.currentTarget.style.transform = 'translateY(-2px)')}
                    onMouseLeave={(e) => (e.currentTarget.style.transform = 'translateY(0)')}
                  >
                    <img src={codLogo} alt="COD" style={{ height: '20px', width: 'auto', objectFit: 'contain' }} />
                    <span style={{ fontWeight: '800', fontSize: '11.5px', color: '#16a34a' }}>COD</span>
                  </div>

                  {/* VNPay */}
                  <div
                    title="Cổng thanh toán VNPAY / QR Code"
                    style={{
                      background: '#ffffff',
                      border: '1px solid #e2e8f0',
                      borderRadius: '8px',
                      padding: '4px 10px',
                      height: '34px',
                      display: 'inline-flex',
                      alignItems: 'center',
                      boxShadow: '0 1px 3px rgba(0,0,0,0.04)',
                      transition: 'transform 0.15s ease'
                    }}
                    onMouseEnter={(e) => (e.currentTarget.style.transform = 'translateY(-2px)')}
                    onMouseLeave={(e) => (e.currentTarget.style.transform = 'translateY(0)')}
                  >
                    <img src={vnpayLogo} alt="VNPAY" style={{ height: '20px', width: 'auto', objectFit: 'contain' }} />
                  </div>

                  {/* MoMo */}
                  <div
                    title="Ví điện tử MoMo"
                    style={{
                      background: '#ffffff',
                      border: '1px solid #e2e8f0',
                      borderRadius: '8px',
                      padding: '4px 10px',
                      height: '34px',
                      display: 'inline-flex',
                      alignItems: 'center',
                      gap: '6px',
                      boxShadow: '0 1px 3px rgba(0,0,0,0.04)',
                      transition: 'transform 0.15s ease'
                    }}
                    onMouseEnter={(e) => (e.currentTarget.style.transform = 'translateY(-2px)')}
                    onMouseLeave={(e) => (e.currentTarget.style.transform = 'translateY(0)')}
                  >
                    <img src={momoLogo} alt="MoMo" style={{ height: '22px', width: 'auto', objectFit: 'contain', borderRadius: '4px' }} />
                    <span style={{ fontWeight: '800', fontSize: '11.5px', color: '#a50064' }}>MoMo</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Bottom copyright */}
        <div style={{ borderTop: '1px solid var(--border)', paddingTop: '24px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: '12px', fontSize: '12px', color: 'var(--text-light)' }}>
          <div>
            © 2026 <strong>BOOK STORE</strong>. Tất cả quyền được bảo lưu. Giấy phép kinh doanh xuất bản phẩm trực tuyến.
          </div>
          <div style={{ display: 'flex', gap: '16px' }}>
            <Link to="/terms" style={{ color: 'inherit' }}>Điều khoản</Link>
            <Link to="/privacy" style={{ color: 'inherit' }}>Bảo mật</Link>
            <Link to="/shipping-policy" style={{ color: 'inherit' }}>Giao hàng</Link>
          </div>
        </div>
      </div>
    </footer>
  );
};
