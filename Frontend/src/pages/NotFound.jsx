import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Home, BookOpen, Search, ArrowRight, Compass, Sparkles } from 'lucide-react';

const SUGGESTED_CATEGORIES = [
  { name: 'Văn học', slug: 'van-hoc', icon: '📖' },
  { name: 'Kinh tế - Quản trị', slug: 'kinh-te', icon: '📈' },
  { name: 'Kỹ năng sống', slug: 'ky-nang-song', icon: '💡' },
  { name: 'Khoa học - Công nghệ', slug: 'cong-nghe', icon: '🔬' },
  { name: 'Thiếu nhi', slug: 'thieu-nhi', icon: '🧸' },
  { name: 'Lịch sử - Văn hóa', slug: 'lich-su---van-hoa', icon: '⛩️' }
];

export const NotFound = () => {
  const [searchKeyword, setSearchKeyword] = useState('');
  const navigate = useNavigate();

  const handleSearch = (e) => {
    e.preventDefault();
    if (searchKeyword.trim()) {
      navigate(`/books?keyword=${encodeURIComponent(searchKeyword.trim())}`);
    } else {
      navigate('/books');
    }
  };

  return (
    <div style={{ backgroundColor: '#f8fafc', minHeight: '80vh', padding: '60px 20px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
      <div 
        className="card" 
        style={{ 
          maxWidth: '840px', 
          width: '100%', 
          margin: '0 auto', 
          padding: '52px 32px 48px', 
          textAlign: 'center',
          borderRadius: '24px',
          border: '1px solid #e2e8f0',
          boxShadow: '0 20px 45px -10px rgba(15, 23, 42, 0.08)',
          backgroundColor: '#ffffff'
        }}
      >
        {/* Cute Animated Book Vector Illustration */}
        <div style={{ position: 'relative', width: '220px', height: '170px', margin: '0 auto 20px' }}>
          <svg viewBox="0 0 240 180" width="220" height="170" fill="none" xmlns="http://www.w3.org/2000/svg">
            <defs>
              <linearGradient id="nfBgGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stopColor="#eff6ff" />
                <stop offset="100%" stopColor="#dbeafe" />
              </linearGradient>
              <linearGradient id="nfBookGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stopColor="#3b82f6" />
                <stop offset="100%" stopColor="#1d4ed8" />
              </linearGradient>
              <linearGradient id="nfCoverGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stopColor="#2563eb" />
                <stop offset="100%" stopColor="#1e40af" />
              </linearGradient>
            </defs>

            {/* Soft Ambient Background Circle */}
            <circle cx="120" cy="90" r="82" fill="url(#nfBgGrad)" opacity="0.6" />

            {/* Floating Star & Sparkles */}
            <circle cx="48" cy="40" r="4" fill="#fbbf24" />
            <circle cx="195" cy="52" r="3.5" fill="#60a5fa" />
            <circle cx="36" cy="115" r="2.5" fill="#f43f5e" />
            <circle cx="202" cy="120" r="4" fill="#fbbf24" />
            <path d="M180 32 L183 39 L190 42 L183 45 L180 52 L177 45 L170 42 L177 39 Z" fill="#f59e0b" opacity="0.75" />
            <path d="M58 85 L60 90 L65 92 L60 94 L58 99 L56 94 L51 92 L56 90 Z" fill="#60a5fa" opacity="0.7" />

            {/* Magnifying Glass Searching */}
            <circle cx="178" cy="96" r="24" stroke="#f59e0b" strokeWidth="6" fill="#fffbeb" fillOpacity="0.4" />
            <line x1="195" y1="113" x2="215" y2="133" stroke="#d97706" strokeWidth="6" strokeLinecap="round" />
            <circle cx="173" cy="91" r="5" fill="#ffffff" fillOpacity="0.8" />

            {/* Big Open Flying Book */}
            {/* Left Page Shadow */}
            <path d="M120 128 C95 124 60 128 42 138 L42 66 C60 56 95 52 120 58 Z" fill="#cbd5e1" opacity="0.4" />
            {/* Left Page Spine/Base */}
            <path d="M120 124 C95 120 60 124 45 134 L45 62 C60 52 95 48 120 54 Z" fill="#ffffff" stroke="#94a3b8" strokeWidth="2.5" />
            {/* Left Page Content Lines */}
            <line x1="58" y1="74" x2="108" y2="69" stroke="#cbd5e1" strokeWidth="2.5" strokeLinecap="round" />
            <line x1="58" y1="88" x2="108" y2="83" stroke="#cbd5e1" strokeWidth="2.5" strokeLinecap="round" />
            <line x1="58" y1="102" x2="96" y2="98" stroke="#cbd5e1" strokeWidth="2.5" strokeLinecap="round" />

            {/* Right Page Shadow */}
            <path d="M120 128 C145 124 180 128 198 138 L198 66 C180 56 145 52 120 58 Z" fill="#cbd5e1" opacity="0.4" />
            {/* Right Page Spine/Base */}
            <path d="M120 124 C145 120 180 124 195 134 L195 62 C180 52 145 48 120 54 Z" fill="#ffffff" stroke="#94a3b8" strokeWidth="2.5" />
            {/* Right Page Content Lines */}
            <line x1="132" y1="69" x2="182" y2="74" stroke="#cbd5e1" strokeWidth="2.5" strokeLinecap="round" />
            <line x1="132" y1="83" x2="182" y2="88" stroke="#cbd5e1" strokeWidth="2.5" strokeLinecap="round" />
            <line x1="132" y1="98" x2="170" y2="102" stroke="#cbd5e1" strokeWidth="2.5" strokeLinecap="round" />

            {/* Center Book Spine */}
            <path d="M120 54 L120 126" stroke="#64748b" strokeWidth="3" strokeLinecap="round" />

            {/* Cute Kawaii Face on Book Spine */}
            <circle cx="106" cy="94" r="3" fill="#1e293b" />
            <circle cx="134" cy="94" r="3" fill="#1e293b" />
            {/* Blushing cheeks */}
            <ellipse cx="100" cy="99" rx="3.5" ry="2" fill="#f43f5e" opacity="0.4" />
            <ellipse cx="140" cy="99" rx="3.5" ry="2" fill="#f43f5e" opacity="0.4" />
            {/* Confused smile */}
            <path d="M116 102 Q120 106 124 102" stroke="#1e293b" strokeWidth="2" strokeLinecap="round" fill="none" />

            {/* Cute Floating Question Mark */}
            <path d="M115 28 C115 23 125 23 125 27 C125 31 120 32 120 36" stroke="#2563eb" strokeWidth="3" strokeLinecap="round" fill="none" />
            <circle cx="120" cy="42" r="1.8" fill="#2563eb" />
          </svg>
        </div>

        {/* 404 Status Badge */}
        <div style={{ marginBottom: '16px' }}>
          <span 
            style={{ 
              display: 'inline-flex', 
              alignItems: 'center', 
              gap: '6px', 
              padding: '6px 16px', 
              backgroundColor: '#eff6ff', 
              color: '#2563eb', 
              fontSize: '13px', 
              fontWeight: '800', 
              borderRadius: '20px',
              border: '1px solid #bfdbfe',
              letterSpacing: '0.8px'
            }}
          >
            <Compass size={15} /> 404 • KHÔNG TÌM THẤY TRANG
          </span>
        </div>

        {/* Title & Subtitle */}
        <h1 style={{ fontSize: '28px', fontWeight: '800', color: '#0f172a', marginBottom: '12px' }}>
          Ối! Trang này dường như đã bị lạc giữa biển sách
        </h1>
        <p style={{ fontSize: '15px', color: '#64748b', maxWidth: '580px', margin: '0 auto 28px', lineHeight: '1.6' }}>
          Trang bạn đang truy cập có thể đã được di chuyển, đổi tên hoặc không còn tồn tại trên BookStore.
          Nhưng đừng lo, kho tàng tri thức với hàng ngàn tựa sách hấp dẫn vẫn đang chờ đón bạn!
        </p>

        {/* Quick Search Form Right On 404 Page */}
        <form 
          onSubmit={handleSearch}
          style={{ 
            maxWidth: '520px', 
            margin: '0 auto 32px', 
            display: 'flex', 
            gap: '8px',
            backgroundColor: '#f1f5f9',
            padding: '6px 8px',
            borderRadius: '12px',
            border: '1px solid #cbd5e1'
          }}
        >
          <div style={{ position: 'relative', flex: 1, display: 'flex', alignItems: 'center' }}>
            <Search size={18} color="#94a3b8" style={{ marginLeft: '10px', position: 'absolute' }} />
            <input 
              type="text"
              value={searchKeyword}
              onChange={(e) => setSearchKeyword(e.target.value)}
              placeholder="Nhập tên sách, tác giả bạn muốn tìm..."
              style={{
                width: '100%',
                padding: '10px 12px 10px 38px',
                border: 'none',
                backgroundColor: 'transparent',
                outline: 'none',
                fontSize: '14px',
                color: '#1e293b'
              }}
            />
          </div>
          <button 
            type="submit"
            className="btn btn-primary"
            style={{ padding: '10px 20px', borderRadius: '8px', fontWeight: '700', fontSize: '13.5px', whiteSpace: 'nowrap' }}
          >
            Tìm sách
          </button>
        </form>

        {/* Action Buttons */}
        <div style={{ display: 'flex', justifyContent: 'center', gap: '14px', flexWrap: 'wrap', marginBottom: '36px' }}>
          <Link 
            to="/" 
            className="btn btn-primary" 
            style={{ 
              display: 'inline-flex', 
              alignItems: 'center', 
              gap: '8px', 
              padding: '12px 26px', 
              fontSize: '14px', 
              fontWeight: '700', 
              borderRadius: '10px',
              boxShadow: '0 4px 14px rgba(37, 99, 235, 0.25)'
            }}
          >
            <Home size={18} /> Về Trang Chủ
          </Link>
          <Link 
            to="/books" 
            className="btn btn-outline" 
            style={{ 
              display: 'inline-flex', 
              alignItems: 'center', 
              gap: '8px', 
              padding: '12px 24px', 
              fontSize: '14px', 
              fontWeight: '700', 
              borderRadius: '10px'
            }}
          >
            <BookOpen size={18} /> Khám Phá Kho Sách
          </Link>
        </div>

        {/* Suggested Categories */}
        <div style={{ borderTop: '1px solid #f1f5f9', paddingTop: '28px' }}>
          <p style={{ fontSize: '13.5px', fontWeight: '700', color: '#64748b', marginBottom: '14px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '6px' }}>
            <Sparkles size={15} color="#f59e0b" /> Hoặc khám phá các chủ đề được yêu thích nhất:
          </p>
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: '10px', justifyContent: 'center' }}>
            {SUGGESTED_CATEGORIES.map((cat, idx) => (
              <Link
                key={idx}
                to={`/books?category=${cat.slug}`}
                style={{
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: '6px',
                  padding: '7px 14px',
                  backgroundColor: '#f8fafc',
                  border: '1px solid #e2e8f0',
                  borderRadius: '20px',
                  color: '#334155',
                  textDecoration: 'none',
                  fontSize: '12.5px',
                  fontWeight: '600',
                  transition: 'all 0.2s ease'
                }}
                onMouseEnter={(e) => {
                  e.currentTarget.style.backgroundColor = '#eff6ff';
                  e.currentTarget.style.borderColor = '#93c5fd';
                  e.currentTarget.style.color = '#2563eb';
                  e.currentTarget.style.transform = 'translateY(-1px)';
                }}
                onMouseLeave={(e) => {
                  e.currentTarget.style.backgroundColor = '#f8fafc';
                  e.currentTarget.style.borderColor = '#e2e8f0';
                  e.currentTarget.style.color = '#334155';
                  e.currentTarget.style.transform = 'translateY(0)';
                }}
              >
                <span>{cat.icon}</span>
                <span>{cat.name}</span>
                <ArrowRight size={12} color="#94a3b8" />
              </Link>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default NotFound;
