import React, { useState, useEffect, useRef } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { 
  BookOpen, ShoppingCart, User, Search, LogOut, Shield, Heart, Tag, ShoppingBag,
  ChevronDown, FileText, ShieldCheck, Truck, CreditCard, HelpCircle, Phone 
} from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import { useCart } from '../context/CartContext';
import { useWishlist } from '../context/WishlistContext';

export const Navbar = () => {
  const { user, isAuthenticated, isManager, isAdmin, logout } = useAuth();
  const { totalItems } = useCart();
  const { totalItems: totalWishlistItems } = useWishlist();
  const [keyword, setKeyword] = useState('');
  const [menuOpen, setMenuOpen] = useState(false);
  const [policyOpen, setPolicyOpen] = useState(false);
  const userMenuRef = useRef(null);
  const policyMenuRef = useRef(null);
  const navigate = useNavigate();

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (userMenuRef.current && !userMenuRef.current.contains(event.target)) {
        setMenuOpen(false);
      }
      if (policyMenuRef.current && !policyMenuRef.current.contains(event.target)) {
        setPolicyOpen(false);
      }
    };

    if (menuOpen || policyOpen) {
      document.addEventListener('mousedown', handleClickOutside);
      document.addEventListener('touchstart', handleClickOutside);
    }

    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
      document.removeEventListener('touchstart', handleClickOutside);
    };
  }, [menuOpen, policyOpen]);

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
        <nav style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
          <Link to="/books" style={{ fontSize: '14px', fontWeight: '600', color: 'var(--text-main)', padding: '8px 12px' }}>
            Tất cả sách
          </Link>

          {/* Chính Sách & Hỗ Trợ Dropdown */}
          <div ref={policyMenuRef} style={{ position: 'relative' }}>
            <button
              onClick={() => setPolicyOpen(!policyOpen)}
              type="button"
              style={{
                background: policyOpen ? '#eff6ff' : 'transparent',
                border: 'none',
                cursor: 'pointer',
                display: 'inline-flex',
                alignItems: 'center',
                gap: '5px',
                fontSize: '14px',
                fontWeight: '600',
                color: policyOpen ? 'var(--primary)' : 'var(--text-main)',
                padding: '8px 12px',
                borderRadius: '8px',
                transition: 'all 0.15s ease'
              }}
              onMouseEnter={(e) => {
                if (!policyOpen) {
                  e.currentTarget.style.backgroundColor = '#f8fafc';
                  e.currentTarget.style.color = 'var(--primary)';
                }
              }}
              onMouseLeave={(e) => {
                if (!policyOpen) {
                  e.currentTarget.style.backgroundColor = 'transparent';
                  e.currentTarget.style.color = 'var(--text-main)';
                }
              }}
            >
              <span>Chính Sách & Hỗ Trợ</span>
              <ChevronDown 
                size={14} 
                style={{ 
                  transform: policyOpen ? 'rotate(180deg)' : 'none', 
                  transition: 'transform 0.2s ease' 
                }} 
              />
            </button>

            {policyOpen && (
              <div style={{
                position: 'absolute',
                top: 'calc(100% + 8px)',
                right: '0',
                backgroundColor: '#ffffff',
                boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.05)',
                borderRadius: '14px',
                border: '1px solid var(--border)',
                width: '350px',
                padding: '12px',
                zIndex: 200
              }}>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
                  <Link
                    to="/shipping-policy"
                    onClick={() => setPolicyOpen(false)}
                    style={{
                      display: 'flex',
                      alignItems: 'flex-start',
                      gap: '12px',
                      padding: '8px 10px',
                      borderRadius: '8px',
                      textDecoration: 'none',
                      transition: 'background-color 0.15s ease'
                    }}
                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f8fafc'}
                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                  >
                    <div style={{
                      width: '34px',
                      height: '34px',
                      borderRadius: '8px',
                      backgroundColor: '#eff6ff',
                      color: '#2563eb',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      flexShrink: 0
                    }}>
                      <Truck size={17} />
                    </div>
                    <div>
                      <div style={{ fontSize: '13px', fontWeight: '600', color: '#0f172a' }}>Chính Sách Giao Hàng</div>
                      <div style={{ fontSize: '12px', color: '#64748b', marginTop: '1px' }}>Thời gian vận chuyển, cước phí & tra cứu</div>
                    </div>
                  </Link>

                  <Link
                    to="/payment-guide"
                    onClick={() => setPolicyOpen(false)}
                    style={{
                      display: 'flex',
                      alignItems: 'flex-start',
                      gap: '12px',
                      padding: '8px 10px',
                      borderRadius: '8px',
                      textDecoration: 'none',
                      transition: 'background-color 0.15s ease'
                    }}
                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f8fafc'}
                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                  >
                    <div style={{
                      width: '34px',
                      height: '34px',
                      borderRadius: '8px',
                      backgroundColor: '#f0fdf4',
                      color: '#16a34a',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      flexShrink: 0
                    }}>
                      <CreditCard size={17} />
                    </div>
                    <div>
                      <div style={{ fontSize: '13px', fontWeight: '600', color: '#0f172a' }}>Hướng Dẫn Thanh Toán</div>
                      <div style={{ fontSize: '12px', color: '#64748b', marginTop: '1px' }}>COD, thẻ ngân hàng, quét mã QR</div>
                    </div>
                  </Link>

                  <Link
                    to="/privacy"
                    onClick={() => setPolicyOpen(false)}
                    style={{
                      display: 'flex',
                      alignItems: 'flex-start',
                      gap: '12px',
                      padding: '8px 10px',
                      borderRadius: '8px',
                      textDecoration: 'none',
                      transition: 'background-color 0.15s ease'
                    }}
                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f8fafc'}
                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                  >
                    <div style={{
                      width: '34px',
                      height: '34px',
                      borderRadius: '8px',
                      backgroundColor: '#faf5ff',
                      color: '#9333ea',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      flexShrink: 0
                    }}>
                      <ShieldCheck size={17} />
                    </div>
                    <div>
                      <div style={{ fontSize: '13px', fontWeight: '600', color: '#0f172a' }}>Chính Sách Bảo Mật</div>
                      <div style={{ fontSize: '12px', color: '#64748b', marginTop: '1px' }}>Cam kết an toàn dữ liệu khách hàng</div>
                    </div>
                  </Link>

                  <Link
                    to="/terms"
                    onClick={() => setPolicyOpen(false)}
                    style={{
                      display: 'flex',
                      alignItems: 'flex-start',
                      gap: '12px',
                      padding: '8px 10px',
                      borderRadius: '8px',
                      textDecoration: 'none',
                      transition: 'background-color 0.15s ease'
                    }}
                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f8fafc'}
                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                  >
                    <div style={{
                      width: '34px',
                      height: '34px',
                      borderRadius: '8px',
                      backgroundColor: '#fff7ed',
                      color: '#ea580c',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      flexShrink: 0
                    }}>
                      <FileText size={17} />
                    </div>
                    <div>
                      <div style={{ fontSize: '13px', fontWeight: '600', color: '#0f172a' }}>Điều Khoản Dịch Vụ</div>
                      <div style={{ fontSize: '12px', color: '#64748b', marginTop: '1px' }}>Quy chế mua bán & chính sách đổi trả</div>
                    </div>
                  </Link>
                </div>

                {/* Footer Quick Support */}
                <div style={{
                  marginTop: '8px',
                  padding: '8px 10px',
                  borderTop: '1px solid #f1f5f9',
                  backgroundColor: '#f8fafc',
                  borderRadius: '6px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  fontSize: '11px',
                  color: '#64748b'
                }}>
                  <span>Hỗ trợ 24/7:</span>
                  <a href="tel:1900123456" style={{ fontWeight: '700', color: 'var(--primary)', textDecoration: 'none', display: 'flex', alignItems: 'center', gap: '4px' }}>
                    <Phone size={12} /> 1900 123 456
                  </a>
                </div>
              </div>
            )}
          </div>

          {/* Wishlist Link */}
          {isAuthenticated && (
            <Link to="/wishlist" title="Sách yêu thích" style={{ position: 'relative', display: 'flex', alignItems: 'center', padding: '8px', color: 'var(--text-main)' }}>
              <Heart size={20} color="var(--danger)" />
              {totalWishlistItems > 0 && (
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
                  {totalWishlistItems}
                </span>
              )}
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
            <div ref={userMenuRef} style={{ position: 'relative' }}>
              <button
                onClick={() => setMenuOpen(!menuOpen)}
                className="btn btn-outline btn-sm"
                style={{
                  borderRadius: 'var(--radius-full)',
                  padding: '6px 14px',
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: '6px'
                }}
              >
                <User size={16} />
                <span style={{ maxWidth: '200px', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                  {user?.fullName || user?.username || 'Tài khoản'}
                </span>
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
                    to="/profile"
                    onClick={() => setMenuOpen(false)}
                    style={{
                      display: 'flex',
                      alignItems: 'center',
                      gap: '8px',
                      padding: '10px 16px',
                      fontSize: '13px',
                      color: 'var(--text-main)',
                      transition: 'background-color 0.15s ease'
                    }}
                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f8fafc'}
                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                  >
                    <User size={15} color="var(--primary)" />
                    Thông tin tài khoản
                  </Link>

                  <Link
                    to="/orders"
                    onClick={() => setMenuOpen(false)}
                    style={{
                      display: 'flex',
                      alignItems: 'center',
                      gap: '8px',
                      padding: '10px 16px',
                      fontSize: '13px',
                      color: 'var(--text-main)',
                      transition: 'background-color 0.15s ease'
                    }}
                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f8fafc'}
                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                  >
                    <ShoppingBag size={15} color="var(--primary)" />
                    Đơn hàng của tôi
                  </Link>

                  {isAdmin && (
                    <Link
                      to="/admin"
                      onClick={() => setMenuOpen(false)}
                      style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '10px 16px', fontSize: '13px', color: 'var(--primary)', fontWeight: '700', backgroundColor: 'var(--primary-light)' }}
                    >
                      <Shield size={16} />
                      Quản Trị Admin
                    </Link>
                  )}

                  {!isAdmin && isManager && (
                    <Link
                      to="/employee"
                      onClick={() => setMenuOpen(false)}
                      style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '10px 16px', fontSize: '13px', color: '#16a34a', fontWeight: '700', backgroundColor: '#f0fdf4' }}
                    >
                      <Shield size={16} />
                      Kênh Nhân Viên
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
              <li>
                <Link to="/terms" style={{ color: 'inherit', transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>
                  Điều khoản dịch vụ
                </Link>
              </li>
              <li>
                <Link to="/privacy" style={{ color: 'inherit', transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>
                  Chính sách bảo mật
                </Link>
              </li>
              <li>
                <Link to="/shipping-policy" style={{ color: 'inherit', transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>
                  Chính sách giao hàng
                </Link>
              </li>
              <li>
                <Link to="/payment-guide" style={{ color: 'inherit', transition: 'color 0.2s' }} onMouseEnter={(e) => e.currentTarget.style.color = 'var(--primary)'} onMouseLeave={(e) => e.currentTarget.style.color = 'inherit'}>
                  Hướng dẫn thanh toán
                </Link>
              </li>
            </ul>
          </div>

          <div>
            <h4 style={{ fontSize: '15px', fontWeight: '700', marginBottom: '16px' }}>Liên Hệ</h4>
            <p style={{ fontSize: '13px', color: 'var(--text-muted)', lineHeight: '1.6' }}>
              Hotline: 1900 123 456<br />
              Email: support@bookstore.com<br />
              Địa chỉ: Bà Rịa - Vũng Tàu, TP.HCM
            </p>
          </div>
        </div>

        <div style={{ borderTop: '1px solid var(--border)', paddingTop: '20px', textAlign: 'center', fontSize: '12px', color: 'var(--text-light)' }}>
          © 2026 BookStore
        </div>
      </div>
    </footer>
  );
};
