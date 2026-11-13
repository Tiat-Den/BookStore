import React, { useState, useEffect } from 'react';
import { useSearchParams, Link } from 'react-router-dom';
import { 
  Filter, SlidersHorizontal, ChevronLeft, ChevronRight, X, 
  Home as HomeIcon, ChevronRight as BreadcrumbSeparator, Sparkles, Tag
} from 'lucide-react';
import { bookService, categoryService } from '../services/catalogAndOrderServices';
import { ProductCard, LoadingSpinner } from '../components/UIComponents';

const CATEGORY_ICONS = {
  'chinh-tri---triet-hoc': '🏛️',
  'van-hoc': '📖',
  'ky-nang-song': '💡',
  'the-thao': '⚽',
  'cong-nghe': '🔬',
  'kinh-te': '📈',
  'thieu-nhi': '🧸',
  'giao-duc': '🎓',
  'lich-su---van-hoa': '⛩️'
};

const PRICE_RANGES = [
  { label: 'Tất cả mức giá', min: '', max: '' },
  { label: 'Dưới 100.000đ', min: '', max: '100000' },
  { label: '100.000đ - 250.000đ', min: '100000', max: '250000' },
  { label: '250.000đ - 500.000đ', min: '250000', max: '500000' },
  { label: 'Trên 500.000đ', min: '500000', max: '' }
];

export const Books = () => {
  const [searchParams, setSearchParams] = useSearchParams();
  const [books, setBooks] = useState([]);
  const [categories, setCategories] = useState([]);
  const [totalCount, setTotalCount] = useState(0);
  const [totalPages, setTotalPages] = useState(1);
  const [loading, setLoading] = useState(true);

  // Filters state
  const keyword = searchParams.get('keyword') || '';
  const rawCategoryId = searchParams.get('categoryId') || '';
  const categorySlug = searchParams.get('category') || '';
  const matchedCategory = categories.find(c => c.slug === categorySlug || c.id === rawCategoryId);
  const categoryId = rawCategoryId || (matchedCategory ? matchedCategory.id : '');
  const sort = searchParams.get('sort') || 'new';
  const page = parseInt(searchParams.get('page') || '1', 10);
  const minPrice = searchParams.get('minPrice') || '';
  const maxPrice = searchParams.get('maxPrice') || '';

  const activeCategory = categories.find(c => c.id === categoryId);

  useEffect(() => {
    categoryService.getCategories(true).then((res) => {
      if (res.success && res.data) {
        setCategories(res.data);
      }
    });
  }, []);

  useEffect(() => {
    const fetchBooks = async () => {
      setLoading(true);
      try {
        const params = {
          keyword: keyword || undefined,
          categoryId: categoryId || undefined,
          sort,
          page,
          pageSize: 12,
          minPrice: minPrice ? parseFloat(minPrice) : undefined,
          maxPrice: maxPrice ? parseFloat(maxPrice) : undefined
        };

        const res = await bookService.getBooks(params);
        if (res.success && res.data) {
          setBooks(res.data.items || []);
          setTotalCount(res.data.totalCount || 0);
          setTotalPages(res.data.totalPages || 1);
        }
      } catch (err) {
        console.error('Lỗi khi tải sách:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchBooks();
  }, [keyword, categoryId, sort, page, minPrice, maxPrice]);

  const updateParam = (key, val) => {
    const newParams = new URLSearchParams(searchParams);
    if (key === 'categoryId') {
      newParams.delete('category');
    }
    if (val) {
      newParams.set(key, val);
    } else {
      newParams.delete(key);
    }
    if (key !== 'page') {
      newParams.set('page', '1');
    }
    setSearchParams(newParams);
    window.scrollTo({ top: 0, left: 0, behavior: 'smooth' });
  };

  const handlePriceSelect = (min, max) => {
    const p = new URLSearchParams(searchParams);
    if (min) p.set('minPrice', min); else p.delete('minPrice');
    if (max) p.set('maxPrice', max); else p.delete('maxPrice');
    p.set('page', '1');
    setSearchParams(p);
  };

  const clearAllFilters = () => {
    setSearchParams({});
    window.scrollTo({ top: 0, left: 0, behavior: 'smooth' });
  };

  const hasActiveFilters = Boolean(keyword || categoryId || categorySlug || minPrice || maxPrice);

  return (
    <div style={{ background: '#f8fafc', minHeight: '85vh', paddingBottom: '60px' }}>
      {/* Breadcrumbs Navigation */}
      <div style={{ background: '#ffffff', borderBottom: '1px solid #e2e8f0', padding: '12px 0' }}>
        <div className="container" style={{ display: 'flex', alignItems: 'center', gap: '8px', fontSize: '13px', color: '#64748b' }}>
          <Link to="/" style={{ display: 'flex', alignItems: 'center', gap: '4px', color: '#64748b', textDecoration: 'none' }}>
            <HomeIcon size={14} /> Trang chủ
          </Link>
          <BreadcrumbSeparator size={14} color="#cbd5e1" />
          <Link to="/books" style={{ color: activeCategory ? '#64748b' : '#2563eb', fontWeight: activeCategory ? '400' : '600', textDecoration: 'none' }}>
            Tất cả sách
          </Link>
          {activeCategory && (
            <>
              <BreadcrumbSeparator size={14} color="#cbd5e1" />
              <span style={{ color: '#2563eb', fontWeight: '700' }}>
                {activeCategory.name}
              </span>
            </>
          )}
        </div>
      </div>

      <div className="container" style={{ paddingTop: '28px' }}>
        {/* Page Header */}
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '16px', marginBottom: '24px' }}>
          <div>
            <h1 style={{ fontSize: '26px', fontWeight: '800', color: '#0f172a', margin: '0 0 6px 0' }}>
              {activeCategory ? activeCategory.name : 'Tất Cả Sách Chọn Lọc'}
            </h1>
            <p style={{ fontSize: '13.5px', color: '#64748b', margin: 0 }}>
              Tìm thấy <strong style={{ color: '#0f172a' }}>{totalCount}</strong> tác phẩm bản quyền phù hợp
              {keyword && <span> cho từ khóa "<strong style={{ color: '#2563eb' }}>{keyword}</strong>"</span>}
            </p>
          </div>

          {/* Sort Selector */}
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
            <span style={{ fontSize: '13px', fontWeight: '600', color: '#64748b' }}>Sắp xếp theo:</span>
            <select
              className="select"
              value={sort}
              onChange={(e) => updateParam('sort', e.target.value)}
              style={{
                width: '180px',
                padding: '8px 12px',
                fontSize: '13px',
                borderRadius: '8px',
                borderColor: '#cbd5e1',
                backgroundColor: '#ffffff'
              }}
            >
              <option value="new">Mới nhất</option>
              <option value="best_seller">Bán chạy nhất</option>
              <option value="price_asc">Giá: Thấp đến Cao</option>
              <option value="price_desc">Giá: Cao đến Thấp</option>
              <option value="title">Theo tựa đề A-Z</option>
            </select>
          </div>
        </div>

        {/* Active Filter Chips */}
        {hasActiveFilters && (
          <div style={{ display: 'flex', alignItems: 'center', flexWrap: 'wrap', gap: '8px', marginBottom: '20px', padding: '12px 16px', background: '#eff6ff', borderRadius: '10px', border: '1px solid #bfdbfe' }}>
            <span style={{ fontSize: '12.5px', fontWeight: '700', color: '#1e40af' }}>Đang lọc:</span>
            
            {activeCategory && (
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: '6px', background: '#ffffff', color: '#1e3a8a', padding: '4px 10px', borderRadius: '9999px', fontSize: '12px', fontWeight: '600', border: '1px solid #93c5fd' }}>
                Danh mục: {activeCategory.name}
                <X size={14} style={{ cursor: 'pointer' }} onClick={() => updateParam('categoryId', '')} />
              </span>
            )}

            {keyword && (
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: '6px', background: '#ffffff', color: '#1e3a8a', padding: '4px 10px', borderRadius: '9999px', fontSize: '12px', fontWeight: '600', border: '1px solid #93c5fd' }}>
                Từ khóa: "{keyword}"
                <X size={14} style={{ cursor: 'pointer' }} onClick={() => updateParam('keyword', '')} />
              </span>
            )}

            {(minPrice || maxPrice) && (
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: '6px', background: '#ffffff', color: '#1e3a8a', padding: '4px 10px', borderRadius: '9999px', fontSize: '12px', fontWeight: '600', border: '1px solid #93c5fd' }}>
                Khoảng giá
                <X size={14} style={{ cursor: 'pointer' }} onClick={() => handlePriceSelect('', '')} />
              </span>
            )}

            <button
              onClick={clearAllFilters}
              style={{
                marginLeft: 'auto',
                background: 'none',
                border: 'none',
                color: '#dc2626',
                fontSize: '12px',
                fontWeight: '700',
                cursor: 'pointer',
                textDecoration: 'underline'
              }}
            >
              Xóa tất cả
            </button>
          </div>
        )}

        {/* Main Layout: Sidebar & Products Grid */}
        <div style={{ display: 'grid', gridTemplateColumns: '270px 1fr', gap: '28px', alignItems: 'start' }}>
          {/* Sidebar Filter */}
          <aside style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
            {/* Category Card */}
            <div className="card" style={{ padding: '18px', borderRadius: '14px', border: '1px solid #e2e8f0', background: '#ffffff' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '14px', borderBottom: '1px solid #f1f5f9', paddingBottom: '10px' }}>
                <Filter size={17} color="#2563eb" />
                <h3 style={{ fontSize: '15px', fontWeight: '800', color: '#0f172a', margin: 0 }}>Danh Mục Sách</h3>
              </div>

              <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
                <button
                  onClick={() => updateParam('categoryId', '')}
                  style={{
                    textAlign: 'left',
                    background: !categoryId ? '#eff6ff' : 'transparent',
                    color: !categoryId ? '#2563eb' : '#334155',
                    fontWeight: !categoryId ? '700' : '500',
                    border: 'none',
                    padding: '9px 12px',
                    borderRadius: '8px',
                    cursor: 'pointer',
                    fontSize: '13px',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between',
                    transition: 'all 0.15s ease'
                  }}
                >
                  <span>📚 Tất cả danh mục</span>
                  <span style={{ fontSize: '11px', color: '#94a3b8' }}>155</span>
                </button>

                {categories.map((c) => {
                  const icon = CATEGORY_ICONS[c.slug] || '📖';
                  const isSelected = categoryId === c.id;
                  return (
                    <button
                      key={c.id}
                      onClick={() => updateParam('categoryId', c.id)}
                      style={{
                        textAlign: 'left',
                        background: isSelected ? '#eff6ff' : 'transparent',
                        color: isSelected ? '#2563eb' : '#334155',
                        fontWeight: isSelected ? '700' : '500',
                        border: 'none',
                        padding: '9px 12px',
                        borderRadius: '8px',
                        cursor: 'pointer',
                        fontSize: '13px',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'space-between',
                        transition: 'all 0.15s ease'
                      }}
                      onMouseEnter={(e) => {
                        if (!isSelected) e.currentTarget.style.backgroundColor = '#f8fafc';
                      }}
                      onMouseLeave={(e) => {
                        if (!isSelected) e.currentTarget.style.backgroundColor = 'transparent';
                      }}
                    >
                      <span style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                        <span>{icon}</span> {c.name}
                      </span>
                      <span style={{ fontSize: '11px', color: isSelected ? '#2563eb' : '#94a3b8' }}>
                        {c.bookCount || 0}
                      </span>
                    </button>
                  );
                })}
              </div>
            </div>

            {/* Price Range Filter */}
            <div className="card" style={{ padding: '18px', borderRadius: '14px', border: '1px solid #e2e8f0', background: '#ffffff' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '14px', borderBottom: '1px solid #f1f5f9', paddingBottom: '10px' }}>
                <Tag size={17} color="#2563eb" />
                <h3 style={{ fontSize: '15px', fontWeight: '800', color: '#0f172a', margin: 0 }}>Khoảng Giá</h3>
              </div>

              <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                {PRICE_RANGES.map((r, i) => {
                  const isChecked = minPrice === r.min && maxPrice === r.max;
                  return (
                    <label
                      key={i}
                      style={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: '9px',
                        cursor: 'pointer',
                        fontSize: '13px',
                        color: isChecked ? '#2563eb' : '#334155',
                        fontWeight: isChecked ? '700' : '500',
                        padding: '4px 6px',
                        borderRadius: '6px'
                      }}
                    >
                      <input
                        type="radio"
                        name="priceFilter"
                        checked={isChecked}
                        onChange={() => handlePriceSelect(r.min, r.max)}
                        style={{ accentColor: '#2563eb', cursor: 'pointer' }}
                      />
                      <span>{r.label}</span>
                    </label>
                  );
                })}
              </div>
            </div>
          </aside>

          {/* Books Grid & Content */}
          <main>
            {loading ? (
              <LoadingSpinner text="Đang tải danh sách tác phẩm..." />
            ) : books.length === 0 ? (
              <div className="card" style={{ textAlign: 'center', padding: '60px 20px', borderRadius: '16px', background: '#ffffff', border: '1px solid #e2e8f0' }}>
                <p style={{ fontSize: '16px', fontWeight: '700', color: '#475569', marginBottom: '8px' }}>
                  Không tìm thấy cuốn sách nào phù hợp với bộ lọc hiện tại.
                </p>
                <p style={{ fontSize: '13.5px', color: '#94a3b8', marginBottom: '20px' }}>
                  Vui lòng thử tìm kiếm bằng từ khóa khác hoặc xóa bỏ các tiêu chí lọc.
                </p>
                <button onClick={clearAllFilters} className="btn btn-primary btn-sm" style={{ padding: '8px 20px', fontWeight: '700' }}>
                  Xóa tất cả bộ lọc
                </button>
              </div>
            ) : (
              <>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(230px, 1fr))', gap: '20px', marginBottom: '36px' }}>
                  {books.map((b) => (
                    <ProductCard key={b.id} book={b} />
                  ))}
                </div>

                {/* Pagination */}
                {totalPages > 1 && (
                  <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', gap: '10px', paddingTop: '10px' }}>
                    <button
                      disabled={page <= 1}
                      onClick={() => updateParam('page', (page - 1).toString())}
                      className="btn btn-outline btn-sm"
                      style={{ borderRadius: '8px', fontWeight: '600' }}
                    >
                      <ChevronLeft size={16} /> Trang trước
                    </button>

                    <span style={{ fontSize: '13.5px', fontWeight: '700', padding: '0 12px', color: '#334155' }}>
                      Trang {page} / {totalPages}
                    </span>

                    <button
                      disabled={page >= totalPages}
                      onClick={() => updateParam('page', (page + 1).toString())}
                      className="btn btn-outline btn-sm"
                      style={{ borderRadius: '8px', fontWeight: '600' }}
                    >
                      Trang sau <ChevronRight size={16} />
                    </button>
                  </div>
                )}
              </>
            )}
          </main>
        </div>
      </div>
    </div>
  );
};
