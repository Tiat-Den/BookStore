import React from 'react';
import { Link } from 'react-router-dom';
import { ArrowRight, Truck, ShieldCheck, RefreshCw, Award } from 'lucide-react';

const SUGGESTED_CATEGORIES = [
  { name: 'Văn học', slug: 'van-hoc', icon: '📖' },
  { name: 'Kinh tế - Quản trị', slug: 'kinh-te', icon: '📈' },
  { name: 'Kỹ năng - Tâm lý', slug: 'ky-nang-song', icon: '💡' },
  { name: 'Thiếu nhi', slug: 'thieu-nhi', icon: '🧸' },
  { name: 'Khoa học - Kỹ thuật', slug: 'cong-nghe', icon: '🔬' },
  { name: 'Lịch sử - Văn hóa', slug: 'lich-su---van-hoa', icon: '⛩️' }
];

export const EmptyState = ({
  type = 'cart',
  title,
  subtitle,
  buttonText = 'Khám phá sách ngay',
  buttonLink = '/books'
}) => {
  const isWishlist = type === 'wishlist';

  const defaultTitle = isWishlist
    ? 'Danh sách yêu thích của bạn đang còn trống!'
    : 'Giỏ hàng của bạn đang trống trơn!';

  const defaultSubtitle = isWishlist
    ? 'Lưu lại những tựa sách bạn say mê bằng cách nhấn vào biểu tượng trái tim để dễ dàng tìm lại và mua sắm bất cứ khi nào bạn muốn.'
    : 'Hàng ngàn cuốn sách hấp dẫn từ Văn học, Kinh tế, Kỹ năng sống đến Thiếu nhi đang chờ bạn đón đọc cùng nhiều voucher freeship!';

  return (
    <div
      className="card"
      style={{
        textAlign: 'center',
        padding: '56px 24px 44px',
        maxWidth: '820px',
        margin: '0 auto',
        borderRadius: '20px',
        border: '1px solid #e2e8f0',
        boxShadow: '0 10px 30px -5px rgba(15, 23, 42, 0.05)',
        backgroundColor: '#ffffff'
      }}
    >
      {/* Cute Illustration */}
      <div style={{ position: 'relative', width: '160px', height: '160px', margin: '0 auto 24px' }}>
        {isWishlist ? (
          /* Cute Wishlist Illustration */
          <svg viewBox="0 0 200 200" width="160" height="160" fill="none" xmlns="http://www.w3.org/2000/svg">
            <defs>
              <linearGradient id="wishlistBgGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stopColor="#fff1f2" />
                <stop offset="100%" stopColor="#ffe4e6" />
              </linearGradient>
              <linearGradient id="heartGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stopColor="#f43f5e" />
                <stop offset="100%" stopColor="#e11d48" />
              </linearGradient>
            </defs>

            {/* Pastel background blob */}
            <circle cx="100" cy="100" r="82" fill="url(#wishlistBgGrad)" />

            {/* Floating Sparkles & Small Hearts */}
            <path d="M42 68L44 62L50 60L44 58L42 52L40 58L34 60L40 62L42 68Z" fill="#fb7185" opacity="0.85" />
            <path d="M162 52L163.5 47.5L168 46L163.5 44.5L162 40L160.5 44.5L156 46L160.5 47.5L162 52Z" fill="#fda4af" />
            <path d="M154 135L155.5 131L160 129.5L155.5 128L154 123.5L152.5 128L148 129.5L152.5 131L154 135Z" fill="#fb7185" />

            {/* Little floating heart */}
            <path d="M48 120 C48 114 55 110 59 115 C63 110 70 114 70 120 C70 128 59 135 59 135 C59 135 48 128 48 120 Z" fill="#fda4af" />

            {/* Open Book Base */}
            <rect x="52" y="112" width="46" height="32" rx="4" transform="rotate(-6 52 112)" fill="#3b82f6" />
            <rect x="50" y="110" width="46" height="32" rx="4" transform="rotate(-6 50 110)" fill="#ffffff" stroke="#cbd5e1" strokeWidth="2" />
            <line x1="56" y1="118" x2="86" y2="115" stroke="#94a3b8" strokeWidth="2" strokeLinecap="round" />
            <line x1="56" y1="126" x2="82" y2="123" stroke="#cbd5e1" strokeWidth="2" strokeLinecap="round" />

            <rect x="102" y="107" width="46" height="32" rx="4" transform="rotate(6 102 107)" fill="#2563eb" />
            <rect x="104" y="105" width="46" height="32" rx="4" transform="rotate(6 104 105)" fill="#ffffff" stroke="#cbd5e1" strokeWidth="2" />
            <line x1="112" y1="115" x2="142" y2="118" stroke="#94a3b8" strokeWidth="2" strokeLinecap="round" />
            <line x1="112" y1="123" x2="138" y2="126" stroke="#cbd5e1" strokeWidth="2" strokeLinecap="round" />

            {/* Big Cute Center Heart Character */}
            <path d="M100 50 C80 32 50 50 50 78 C50 106 90 128 100 134 C110 128 150 106 150 78 C150 50 120 32 100 50 Z" fill="url(#heartGrad)" filter="drop-shadow(0 6px 12px rgba(225, 29, 72, 0.28))" />

            {/* Kawaii Face on Heart */}
            <ellipse cx="88" cy="80" rx="3.5" ry="4.5" fill="#ffffff" />
            <ellipse cx="112" cy="80" rx="3.5" ry="4.5" fill="#ffffff" />
            {/* Cute Rosy Cheeks */}
            <circle cx="80" cy="89" r="4.5" fill="#fecdd3" opacity="0.9" />
            <circle cx="120" cy="89" r="4.5" fill="#fecdd3" opacity="0.9" />
            {/* Cheerful Smile */}
            <path d="M96 87 Q100 93 104 87" stroke="#ffffff" strokeWidth="2.5" strokeLinecap="round" fill="none" />
          </svg>
        ) : (
          /* Cute Shopping Cart Mascot Illustration */
          <svg viewBox="0 0 200 200" width="160" height="160" fill="none" xmlns="http://www.w3.org/2000/svg">
            <defs>
              <linearGradient id="cartBgGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stopColor="#eff6ff" />
                <stop offset="100%" stopColor="#dbeafe" />
              </linearGradient>
              <linearGradient id="cartBodyGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stopColor="#3b82f6" />
                <stop offset="100%" stopColor="#1d4ed8" />
              </linearGradient>
            </defs>

            {/* Pastel background blob */}
            <circle cx="100" cy="100" r="82" fill="url(#cartBgGrad)" />

            {/* Floating Sparkles & Books */}
            <path d="M38 72L40 66L46 64L40 62L38 56L36 62L30 64L36 66L38 72Z" fill="#3b82f6" opacity="0.8" />
            <path d="M165 60L166.5 55.5L171 54L166.5 52.5L165 48L163.5 52.5L159 54L163.5 55.5L165 60Z" fill="#60a5fa" />
            <circle cx="158" cy="120" r="4" fill="#93c5fd" />
            <circle cx="44" cy="130" r="5" fill="#bfdbfe" />

            {/* Small book peeking out with red bookmark ribbon */}
            <rect x="70" y="44" width="34" height="42" rx="4" transform="rotate(-12 70 44)" fill="#f59e0b" />
            <rect x="74" y="46" width="28" height="38" rx="3" transform="rotate(-12 74 46)" fill="#fef3c7" />
            <line x1="78" y1="56" x2="96" y2="52" stroke="#d97706" strokeWidth="2" strokeLinecap="round" />
            <line x1="80" y1="64" x2="94" y2="61" stroke="#d97706" strokeWidth="2" strokeLinecap="round" />
            {/* Bookmark ribbon */}
            <path d="M88 40L88 56L93 52L98 56L98 38" fill="#ef4444" />

            {/* Shopping Cart Body with Kawaii Face */}
            <rect x="58" y="74" width="86" height="56" rx="14" fill="url(#cartBodyGrad)" filter="drop-shadow(0 6px 14px rgba(37, 99, 235, 0.28))" />
            <path d="M48 76L58 76" stroke="#1e40af" strokeWidth="5" strokeLinecap="round" />
            
            {/* Kawaii Cart Face */}
            <ellipse cx="88" cy="98" rx="3.5" ry="4.5" fill="#ffffff" />
            <ellipse cx="114" cy="98" rx="3.5" ry="4.5" fill="#ffffff" />
            {/* Blushing Cheeks */}
            <circle cx="80" cy="106" r="4.5" fill="#93c5fd" opacity="0.9" />
            <circle cx="122" cy="106" r="4.5" fill="#93c5fd" opacity="0.9" />
            {/* Warm Smile */}
            <path d="M97 104 Q101 110 105 104" stroke="#ffffff" strokeWidth="2.5" strokeLinecap="round" fill="none" />

            {/* Wheels */}
            <circle cx="78" cy="142" r="10" fill="#1e293b" />
            <circle cx="78" cy="142" r="4" fill="#ffffff" />
            <circle cx="124" cy="142" r="10" fill="#1e293b" />
            <circle cx="124" cy="142" r="4" fill="#ffffff" />
          </svg>
        )}
      </div>

      {/* Badge Pill */}
      <div style={{ display: 'inline-flex', alignItems: 'center', gap: '6px', backgroundColor: isWishlist ? '#fff1f2' : '#eff6ff', color: isWishlist ? '#e11d48' : '#2563eb', padding: '6px 16px', borderRadius: '9999px', fontSize: '13px', fontWeight: '700', marginBottom: '16px' }}>
        <span>{isWishlist ? '💖 Danh sách yêu thích trống' : '🛒 Giỏ hàng chưa có sách'}</span>
      </div>

      {/* Main Title & Subtitle */}
      <h2
        style={{
          fontSize: '24px',
          fontWeight: '800',
          color: '#0f172a',
          marginBottom: '10px',
          lineHeight: '1.3'
        }}
      >
        {title || defaultTitle}
      </h2>

      <p
        style={{
          fontSize: '14.5px',
          color: '#64748b',
          maxWidth: '540px',
          margin: '0 auto 28px',
          lineHeight: '1.6'
        }}
      >
        {subtitle || defaultSubtitle}
      </p>

      {/* Prominent CTA Button */}
      <div style={{ marginBottom: '36px' }}>
        <Link
          to={buttonLink}
          className="btn btn-primary"
          style={{
            display: 'inline-flex',
            alignItems: 'center',
            gap: '10px',
            padding: '13px 34px',
            fontSize: '15px',
            fontWeight: '700',
            borderRadius: '9999px',
            background: 'linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%)',
            boxShadow: '0 8px 24px rgba(37, 99, 235, 0.35)',
            transition: 'all 0.25s ease'
          }}
          onMouseEnter={(e) => {
            e.currentTarget.style.transform = 'translateY(-2px)';
            e.currentTarget.style.boxShadow = '0 12px 28px rgba(37, 99, 235, 0.45)';
          }}
          onMouseLeave={(e) => {
            e.currentTarget.style.transform = 'translateY(0)';
            e.currentTarget.style.boxShadow = '0 8px 24px rgba(37, 99, 235, 0.35)';
          }}
        >
          <span>{buttonText}</span>
          <ArrowRight size={18} />
        </Link>
      </div>

      {/* Category Suggestion Pills */}
      <div style={{ borderTop: '1px solid #f1f5f9', paddingTop: '28px', marginBottom: '28px' }}>
        <div style={{ fontSize: '13.5px', fontWeight: '700', color: '#475569', marginBottom: '14px' }}>
          Gợi ý danh mục sách được bạn đọc yêu thích nhất:
        </div>
        <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px', justifyContent: 'center' }}>
          {SUGGESTED_CATEGORIES.map((cat) => (
            <Link
              key={cat.slug}
              to={`/books?category=${cat.slug}`}
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: '6px',
                padding: '7px 14px',
                borderRadius: '9999px',
                backgroundColor: '#f8fafc',
                border: '1px solid #e2e8f0',
                color: '#334155',
                fontSize: '13px',
                fontWeight: '600',
                textDecoration: 'none',
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
            </Link>
          ))}
        </div>
      </div>

      {/* Trust Guarantee Badges */}
      <div
        style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(160px, 1fr))',
          gap: '12px',
          borderTop: '1px dashed #e2e8f0',
          paddingTop: '20px'
        }}
      >
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', justifyContent: 'center', color: '#64748b', fontSize: '12px', fontWeight: '600' }}>
          <Truck size={16} color="#2563eb" />
          <span>Freeship đơn từ 250k</span>
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', justifyContent: 'center', color: '#64748b', fontSize: '12px', fontWeight: '600' }}>
          <ShieldCheck size={16} color="#16a34a" />
          <span>100% Sách chính hãng</span>
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', justifyContent: 'center', color: '#64748b', fontSize: '12px', fontWeight: '600' }}>
          <RefreshCw size={16} color="#d97706" />
          <span>Đổi trả 7 ngày dễ dàng</span>
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', justifyContent: 'center', color: '#64748b', fontSize: '12px', fontWeight: '600' }}>
          <Award size={16} color="#7c3aed" />
          <span>Tích điểm đổi quà VIP</span>
        </div>
      </div>
    </div>
  );
};

export default EmptyState;
