import React, { useState, useEffect } from 'react';
import { ChevronUp } from 'lucide-react';

export const BackToTop = () => {
  const [visible, setVisible] = useState(false);
  const [isHovered, setIsHovered] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      if (window.scrollY > 240) {
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
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
      aria-label="Lên đầu trang"
      title="Lên đầu trang"
      style={{
        position: 'fixed',
        bottom: '90px',
        right: '31px',
        zIndex: 9999,
        background: 'transparent',
        border: 'none',
        outline: 'none',
        padding: '6px',
        cursor: 'pointer',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        color: isHovered ? '#1d4ed8' : '#2563eb',
        transition: 'all 0.25s cubic-bezier(0.16, 1, 0.3, 1)',
        opacity: visible ? 1 : 0,
        transform: visible
          ? isHovered
            ? 'translateY(-4px) scale(1.15)'
            : 'translateY(0) scale(1)'
          : 'translateY(12px) scale(0.8)',
        pointerEvents: visible ? 'auto' : 'none',
        filter: isHovered
          ? 'drop-shadow(0 4px 10px rgba(37, 99, 235, 0.55))'
          : 'drop-shadow(0 2px 6px rgba(37, 99, 235, 0.35))'
      }}
    >
      <ChevronUp size={36} strokeWidth={3} />
    </button>
  );
};

export default BackToTop;
