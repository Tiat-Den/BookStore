import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { BookOpen, ShoppingCart, User, Search, LogOut, Shield, Heart, Tag } from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import { useCart } from '../context/CartContext';

export const Navbar = () => {
  const { user, isAuthenticated, isManager, logout } = useAuth();
  const { totalItems } = useCart();
  const [keyword, setKeyword] = useState('');
  const [menuOpen, setMenuOpen] = useState(false);
  const navigate = useNavigate();

  const handleSearch = (e) => {
    e.preventDefault();
    if (keyword.trim()) {
      navigate(`/books?keyword=${encodeURIComponent(keyword.trim())}`);
    } else {
      navigate('/books');
    }
  };

  return (
    <header style={{ backgroundColor: '#ffffff', borderBottom: '1px solid var(--border)', position: 'sticky', top: 0, zIndex: 100 }}>
      <div className="container" style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', height: '72px', gap: '20px' }}>
        
        {/* Brand Logo */}
        <Link to="/" style={{ display: 'flex', alignItems: 'center', gap: '10px', textDecoration: 'none' }}>
          <div style={{ background: 'linear-gradient(135deg, #2563eb, #1d4ed8)', width: '40px', height: '40px', borderRadius: '10px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#fff' }}>
            <BookOpen size={22} />
          </div>
          <div>
            <span style={{ fontSize: '20px', fontWeight: '800', color: 'var(--primary)', letterSpacing: '-0.5px' }}>BookStore</span>
            <span style={{ display: 'block', fontSize: '10px', color: 'var(--text-muted)', marginTop: '-4px', fontWeight: '500' }}>Sách Cho Mọi Nhà</span>
          </div>
        </Link>

        {/* Search Bar */}
        <form onSubmit={handleSearch} style={{ flex: 1, maxWidth: '480px', position: 'relative' }}>
          <input
            type="text"
            className="input"
            placeholder="Tìm kiếm sách theo tên, tác giả, ISBN..."
            value={keyword}
            onChange={(e) => setKeyword(e.target.value)}
            style={{ paddingLeft: '40px', height: '42px', borderRadius: 'var(--radius-full)' }}
          />
          <Search size={18} color="var(--text-light)" style={{ position: 'absolute', left: '14px', top: '12px' }} />
        </form>

        {/* Navigation & User actions */}
        <nav style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
          <Link to="/books" style={{ fontSize: '14px', fontWeight: '600', color: 'var(--text-main)', padding: '8px 12px' }}>
            Tất cả sách
          </Link>

          {/* Wishlist Link */}
          {isAuthenticated && (
            <Link to="/wishlist" title="Sách yêu thích" style={{ display: 'flex', alignItems: 'center', padding: '8px', color: 'var(--text-main)' }}>
              <Heart size={20} color="var(--danger)" />
            </Link>
          )}

          {/* Cart Icon */}
          <Link to="/cart" style={{ position: 'relative', display: 'flex', alignItems: 'center', padding: '8px', color: 'var(--text-main)' }}>
            <ShoppingCart size={22} />
            {totalItems > 0 && (
              <span style={{
                position: 'absolute',
                top: '0',
                right: '0',
                backgroundColor: 'var(--danger)',
                color: '#fff',
                fontSize: '11px',
                fontWeight: '700',
                borderRadius: '50%',
                width: '18px',
                height: '18px',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center'
              }}>
                {totalItems}
              </span>
            )}
          </Link>

          {/* User Section */}
          {isAuthenticated ? (
            <div style={{ position: 'relative' }}>
              <button
                onClick={() => setMenuOpen(!menuOpen)}
                className="btn btn-outline btn-sm"
                style={{ borderRadius: 'var(--radius-full)', padding: '6px 14px' }}
              >
                <User size={16} />
                <span>{user?.fullName?.split(' ').pop() || 'Tài khoản'}</span>
              </button>

              {menuOpen && (
                <div style={{
                  position: 'absolute',
                  right: 0,
                  top: '110%',
                  backgroundColor: '#ffffff',
                  boxShadow: 'var(--shadow-xl)',
                  borderRadius: 'var(--radius)',
                  border: '1px solid var(--border)',
                  minWidth: '200px',
                  padding: '8px 0',
                  zIndex: 200
                }}>
                  <div style={{ padding: '8px 16px', borderBottom: '1px solid var(--border)' }}>
                    <p style={{ fontSize: '13px', fontWeight: '700' }}>{user?.fullName}</p>
                    <p style={{ fontSize: '11px', color: 'var(--text-muted)' }}>{user?.email}</p>
                  </div>

                  <Link
                    to="/orders"
                    onClick={() => setMenuOpen(false)}
                    style={{ display: 'block', padding: '10px 16px', fontSize: '13px', color: 'var(--text-main)' }}
                  >
                    Đơn hàng của tôi
                  </Link>

                  {isManager && (
                    <Link
                      to="/admin"
                      onClick={() => setMenuOpen(false)}
                      style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '10px 16px', fontSize: '13px', color: 'var(--primary)', fontWeight: '600', backgroundColor: 'var(--primary-light)' }}
                    >
                      <Shield size={16} />
                      Trang Quản Trị
                    </Link>
                  )}

                  <button
                    onClick={() => { setMenuOpen(false); logout(); }}
                    style={{
                      width: '100%',
                      textAlign: 'left',
                      display: 'flex',
                      alignItems: 'center',
                      gap: '8px',
                      padding: '10px 16px',
                      fontSize: '13px',
                      color: 'var(--danger)',
                      background: 'none',
                      border: 'none',
                      cursor: 'pointer'
                    }}
                  >
                    <LogOut size={16} />
                    Đăng xuất
                  </button>
                </div>
              )}
            </div>
          ) : (
            <div style={{ display: 'flex', gap: '10px' }}>
              <Link to="/login" className="btn btn-outline btn-sm">
                Đăng nhập
              </Link>
              <Link to="/register" className="btn btn-primary btn-sm">
                Đăng ký
              </Link>
            </div>
          )}
        </nav>
      </div>
    </header>
  );
};

export const Footer = () => {
  return (
    <footer style={{ backgroundColor: '#ffffff', borderTop: '1px solid var(--border)', padding: '48px 0 24px', marginTop: '60px' }}>
      <div className="container">
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))', gap: '32px', marginBottom: '40px' }}>
          <div>
            <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '14px' }}>
              <div style={{ background: 'var(--primary)', width: '32px', height: '32px', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#fff' }}>
                <BookOpen size={18} />
              </div>
              <span style={{ fontSize: '18px', fontWeight: '800', color: 'var(--primary)' }}>BookStore</span>
            </div>
            <p style={{ fontSize: '13px', color: 'var(--text-muted)', lineHeight: '1.6' }}>
              Hệ thống bán sách trực tuyến uy tín hàng đầu. Cam kết 100% sách chính hãng, hỗ trợ giao hàng nhanh và đổi trả thuận tiện.
            </p>
          </div>

          <div>
            <h4 style={{ fontSize: '15px', fontWeight: '700', marginBottom: '16px' }}>Danh Mục Nổi Bật</h4>
            <ul style={{ listStyle: 'none', fontSize: '13px', color: 'var(--text-muted)', display: 'flex', flexDirection: 'column', gap: '8px' }}>
              <li><Link to="/books?category=van-hoc">Văn học</Link></li>
              <li><Link to="/books?category=kinh-te">Kinh tế & Quản trị</Link></li>
              <li><Link to="/books?category=ky-nang-song">Kỹ năng sống</Link></li>
              <li><Link to="/books?category=cong-nghe">Công nghệ thông tin</Link></li>
            </ul>
          </div>

          <div>
            <h4 style={{ fontSize: '15px', fontWeight: '700', marginBottom: '16px' }}>Chính Sách & Hỗ Trợ</h4>
            <ul style={{ listStyle: 'none', fontSize: '13px', color: 'var(--text-muted)', display: 'flex', flexDirection: 'column', gap: '8px' }}>
              <li>Điều khoản dịch vụ</li>
              <li>Chính sách bảo mật</li>
              <li>Chính sách giao hàng</li>
              <li>Hướng dẫn thanh toán</li>
            </ul>
          </div>

          <div>
            <h4 style={{ fontSize: '15px', fontWeight: '700', marginBottom: '16px' }}>Liên Hệ</h4>
            <p style={{ fontSize: '13px', color: 'var(--text-muted)', lineHeight: '1.6' }}>
              Hotline: 1900 123 456<br />
              Email: support@bookstore.com<br />
              Địa chỉ: Đại học Công nghệ TP.HCM
            </p>
          </div>
        </div>

        <div style={{ borderTop: '1px solid var(--border)', paddingTop: '20px', textAlign: 'center', fontSize: '12px', color: 'var(--text-light)' }}>
          © 2026 BookStore E-Commerce. Xây dựng bởi React + ASP.NET Core Web API + Microsoft SQL Server.
        </div>
      </div>
    </footer>
  );
};
