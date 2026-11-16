import React, { useState, useEffect } from 'react';
import { ChevronUp } from 'lucide-react';

export const BackToTop = () => {
  const [visible, setVisible] = useState(false);
  const [scrollProgress, setScrollProgress] = useState(0);
  const [isHovered, setIsHovered] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      const scrollY = window.scrollY;
      const docHeight = document.documentElement.scrollHeight - window.innerHeight;
      const progress = docHeight > 0 ? Math.min(100, Math.max(0, (scrollY / docHeight) * 100)) : 0;

      setScrollProgress(progress);
      setVisible(scrollY > 240);
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

  // SVG circular progress calculation
  // Radius: 22px => Circumference: 2 * Math.PI * 22 = 138.23px
  const radius = 22;
  const circumference = 2 * Math.PI * radius;
  const strokeDashoffset = circumference - (scrollProgress / 100) * circumference;

  return (
    <div
      style={{
        position: 'fixed',
        bottom: '92px',
        right: '26px',
        zIndex: 9999,
        transition: 'all 0.35s cubic-bezier(0.16, 1, 0.3, 1)',
        opacity: visible ? 1 : 0,
        transform: visible ? 'translateY(0) scale(1)' : 'translateY(20px) scale(0.75)',
        pointerEvents: visible ? 'auto' : 'none'
      }}
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      {/* Floating mini badge / tooltip on hover */}
      <div
        style={{
          position: 'absolute',
          bottom: '58px',
          left: '50%',
          transform: isHovered ? 'translateX(-50%) translateY(0)' : 'translateX(-50%) translateY(6px)',
          opacity: isHovered ? 1 : 0,
          pointerEvents: 'none',
          transition: 'all 0.25s cubic-bezier(0.16, 1, 0.3, 1)',
          background: 'linear-gradient(135deg, rgba(15, 23, 42, 0.94) 0%, rgba(30, 41, 59, 0.96) 100%)',
          backdropFilter: 'blur(8px)',
          WebkitBackdropFilter: 'blur(8px)',
          color: '#ffffff',
          padding: '5px 11px',
          borderRadius: '9999px',
          fontSize: '11px',
          fontWeight: '700',
          whiteSpace: 'nowrap',
          boxShadow: '0 6px 18px rgba(0, 0, 0, 0.22), 0 0 0 1px rgba(255, 255, 255, 0.1)',
          display: 'flex',
          alignItems: 'center',
          gap: '5px'
        }}
      >
        <span style={{ color: '#60a5fa' }}>↑</span>
        <span>Lên đầu trang</span>
        <span
          style={{
            background: 'rgba(59, 130, 246, 0.3)',
            color: '#93c5fd',
            padding: '1px 5px',
            borderRadius: '6px',
            fontSize: '10px'
          }}
        >
          {Math.round(scrollProgress)}%
        </span>
        {/* Tooltip beak */}
        <div
          style={{
            position: 'absolute',
            bottom: '-4px',
            left: '50%',
            transform: 'translateX(-50%) rotate(45deg)',
            width: '8px',
            height: '8px',
            backgroundColor: 'rgba(30, 41, 59, 0.96)',
            boxShadow: '1px 1px 1px rgba(0, 0, 0, 0.1)'
          }}
        />
      </div>

      {/* Button with circular progress ring */}
      <button
        onClick={scrollToTop}
        aria-label="Lên đầu trang"
        title="Lên đầu trang"
        style={{
          width: '50px',
          height: '50px',
          borderRadius: '50%',
          background: 'none',
          border: 'none',
          padding: 0,
          cursor: 'pointer',
          position: 'relative',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          outline: 'none',
          transition: 'transform 0.25s cubic-bezier(0.34, 1.56, 0.64, 1)'
        }}
      >
        {/* Circular Progress SVG */}
        <svg
          width="50"
          height="50"
          viewBox="0 0 50 50"
          style={{
            position: 'absolute',
            top: 0,
            left: 0,
            transform: 'rotate(-90deg)',
            pointerEvents: 'none'
          }}
        >
          <defs>
            <linearGradient id="backToTopProgressGrad" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="0%" stopColor="#93c5fd" />
              <stop offset="50%" stopColor="#3b82f6" />
              <stop offset="100%" stopColor="#1d4ed8" />
            </linearGradient>
            <filter id="ringGlow" x="-20%" y="-20%" width="140%" height="140%">
              <feGaussianBlur stdDeviation="1.5" result="blur" />
              <feComposite in="SourceGraphic" in2="blur" operator="over" />
            </filter>
          </defs>

          {/* Faint track circle */}
          <circle
            cx="25"
            cy="25"
            r={radius}
            fill="none"
            stroke="rgba(226, 232, 240, 0.85)"
            strokeWidth="2.5"
          />

          {/* Animated progress circle */}
          <circle
            cx="25"
            cy="25"
            r={radius}
            fill="none"
            stroke="url(#backToTopProgressGrad)"
            strokeWidth="2.8"
            strokeLinecap="round"
            strokeDasharray={circumference}
            strokeDashoffset={strokeDashoffset}
            filter={isHovered ? 'url(#ringGlow)' : 'none'}
            style={{
              transition: 'stroke-dashoffset 0.15s ease-out, filter 0.2s ease'
            }}
          />
        </svg>

        {/* Inner Solid Capsule / Core */}
        <div
          style={{
            width: '38px',
            height: '38px',
            borderRadius: '50%',
            background: 'linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%)',
            color: '#ffffff',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            boxShadow: isHovered
              ? '0 10px 24px -2px rgba(37, 99, 235, 0.55), inset 0 1.5px 2px rgba(255, 255, 255, 0.6), inset 0 -1.5px 2px rgba(15, 23, 42, 0.25)'
              : '0 6px 16px -2px rgba(37, 99, 235, 0.4), inset 0 1.5px 2px rgba(255, 255, 255, 0.45), inset 0 -1.5px 2px rgba(15, 23, 42, 0.15)',
            transform: isHovered ? 'scale(1.06)' : 'scale(1)',
            transition: 'all 0.25s cubic-bezier(0.34, 1.56, 0.64, 1)',
            position: 'relative',
            overflow: 'hidden'
          }}
        >
          {/* Subtle light sheen highlight across top */}
          <div
            style={{
              position: 'absolute',
              top: '2px',
              left: '10%',
              right: '10%',
              height: '14px',
              background: 'linear-gradient(180deg, rgba(255, 255, 255, 0.35) 0%, rgba(255, 255, 255, 0) 100%)',
              borderRadius: '50% 50% 0 0',
              pointerEvents: 'none'
            }}
          />

          {/* Up Chevron Icon with smooth upward spring glide on hover */}
          <div
            style={{
              transform: isHovered ? 'translateY(-2px)' : 'translateY(0)',
              transition: 'transform 0.25s cubic-bezier(0.34, 1.56, 0.64, 1)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center'
            }}
          >
            <ChevronUp size={21} strokeWidth={3} />
          </div>
        </div>
      </button>
    </div>
  );
};

export default BackToTop;
