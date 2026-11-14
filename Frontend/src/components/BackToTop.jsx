import React, { useState, useEffect } from 'react';
import { ChevronUp } from 'lucide-react';

export const BackToTop = () => {
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      if (window.scrollY > 280) {
        setVisible(true);
      } else {
        setVisible(false);
      }
    };

    window.addEventListener('scroll', handleScroll, { passive: true });
    handleScroll();

    return () => {
      window.removeEventListener('scroll', handleScroll);
    };
  }, []);

  const scrollToTop = () => {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  };

  return (
    <button
      onClick={scrollToTop}
      aria-label="Lên đầu trang"
      title="Lên đầu trang"
      style={{
        position: 'fixed',
        bottom: '92px',
        right: '28px',
        width: '46px',
        height: '46px',
        borderRadius: '50%',
        backgroundColor: '#2563eb',
        background: 'linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%)',
        color: '#ffffff',
        border: '1px solid rgba(255, 255, 255, 0.3)',
        boxShadow: '0 8px 24px rgba(37, 99, 235, 0.38), 0 2px 6px rgba(0, 0, 0, 0.08)',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        cursor: 'pointer',
        zIndex: 9999,
        transition: 'all 0.3s cubic-bezier(0.16, 1, 0.3, 1)',
        opacity: visible ? 1 : 0,
        transform: visible ? 'translateY(0) scale(1)' : 'translateY(16px) scale(0.8)',
        pointerEvents: visible ? 'auto' : 'none'
      }}
      onMouseEnter={(e) => {
        if (visible) {
          e.currentTarget.style.transform = 'translateY(-3px) scale(1.08)';
          e.currentTarget.style.boxShadow = '0 12px 28px rgba(37, 99, 235, 0.48)';
        }
      }}
      onMouseLeave={(e) => {
        if (visible) {
          e.currentTarget.style.transform = 'translateY(0) scale(1)';
          e.currentTarget.style.boxShadow = '0 8px 24px rgba(37, 99, 235, 0.38), 0 2px 6px rgba(0, 0, 0, 0.08)';
        }
      }}
    >
      <ChevronUp size={22} strokeWidth={2.8} />
    </button>
  );
};

export default BackToTop;
