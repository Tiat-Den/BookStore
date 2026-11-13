import React, { useState, useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import { Filter, SlidersHorizontal, ChevronLeft, ChevronRight } from 'lucide-react';
import { bookService, categoryService } from '../services/catalogAndOrderServices';
import { ProductCard, LoadingSpinner } from '../components/UIComponents';

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

  useEffect(() => {
    categoryService.getCategories(true).then((res) => {
      if (res.success) setCategories(res.data);
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
          setBooks(res.data.items);
          setTotalCount(res.data.totalCount);
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

  return (
    <div className="container" style={{ padding: '32px 20px' }}>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div>
          <h1 style={{ fontSize: '28px', fontWeight: '800' }}>Tất Cả Sách</h1>
          <p style={{ fontSize: '14px', color: 'var(--text-muted)' }}>
            Tìm thấy <strong>{totalCount}</strong> tác phẩm phù hợp
            {keyword && <span> cho từ khóa "{keyword}"</span>}
          </p>
        </div>

        {/* Sort Selector */}
        <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
          <SlidersHorizontal size={18} color="var(--text-muted)" />
          <select
            className="select"
            value={sort}
            onChange={(e) => updateParam('sort', e.target.value)}
            style={{ width: '180px', padding: '8px 12px' }}
          >
            <option value="new">Mới nhất</option>
            <option value="price_asc">Giá: Thấp đến Cao</option>
            <option value="price_desc">Giá: Cao đến Thấp</option>
            <option value="best_seller">Bán chạy nhất</option>
            <option value="title">Theo tên A-Z</option>
          </select>
        </div>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '260px 1fr', gap: '32px', alignItems: 'start' }}>
        {/* Sidebar Filter */}
        <aside className="card" style={{ padding: '20px' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '20px', borderBottom: '1px solid var(--border)', paddingBottom: '12px' }}>
            <Filter size={18} color="var(--primary)" />
            <h3 style={{ fontSize: '16px', fontWeight: '700' }}>Bộ Lọc</h3>
          </div>

          {/* Categories */}
          <div style={{ marginBottom: '24px' }}>
            <h4 style={{ fontSize: '14px', fontWeight: '700', marginBottom: '12px' }}>Danh Mục</h4>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
              <button
                onClick={() => updateParam('categoryId', '')}
                style={{
                  textAlign: 'left',
                  background: !categoryId ? 'var(--primary-light)' : 'none',
                  color: !categoryId ? 'var(--primary)' : 'var(--text-main)',
                  fontWeight: !categoryId ? '700' : '500',
                  border: 'none',
                  padding: '8px 12px',
                  borderRadius: 'var(--radius-sm)',
                  cursor: 'pointer'
                }}
              >
                Tất cả thể loại
              </button>
              {categories.map((c) => (
                <button
                  key={c.id}
                  onClick={() => updateParam('categoryId', c.id)}
                  style={{
                    textAlign: 'left',
                    background: categoryId === c.id ? 'var(--primary-light)' : 'none',
                    color: categoryId === c.id ? 'var(--primary)' : 'var(--text-main)',
                    fontWeight: categoryId === c.id ? '700' : '500',
                    border: 'none',
                    padding: '8px 12px',
                    borderRadius: 'var(--radius-sm)',
                    cursor: 'pointer'
                  }}
                >
                  {c.name} ({c.bookCount || 0})
                </button>
              ))}
            </div>
          </div>

          {/* Price Range */}
          <div>
            <h4 style={{ fontSize: '14px', fontWeight: '700', marginBottom: '12px' }}>Khoảng Giá</h4>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '8px', fontSize: '13px' }}>
              <label style={{ display: 'flex', alignItems: 'center', gap: '8px', cursor: 'pointer' }}>
                <input
                  type="radio"
                  name="priceRange"
                  checked={!minPrice && !maxPrice}
                  onChange={() => {
                    const p = new URLSearchParams(searchParams);
                    p.delete('minPrice');
                    p.delete('maxPrice');
                    setSearchParams(p);
                  }}
                />
                Tất cả mức giá
              </label>

              <label style={{ display: 'flex', alignItems: 'center', gap: '8px', cursor: 'pointer' }}>
                <input
                  type="radio"
                  name="priceRange"
                  checked={maxPrice === '100000'}
                  onChange={() => {
                    const p = new URLSearchParams(searchParams);
                    p.delete('minPrice');
                    p.set('maxPrice', '100000');
                    setSearchParams(p);
                  }}
                />
                Dưới 100.000đ
              </label>

              <label style={{ display: 'flex', alignItems: 'center', gap: '8px', cursor: 'pointer' }}>
                <input
                  type="radio"
                  name="priceRange"
                  checked={minPrice === '100000' && maxPrice === '250000'}
                  onChange={() => {
                    const p = new URLSearchParams(searchParams);
                    p.set('minPrice', '100000');
                    p.set('maxPrice', '250000');
                    setSearchParams(p);
                  }}
                />
                100.000đ - 250.000đ
              </label>

              <label style={{ display: 'flex', alignItems: 'center', gap: '8px', cursor: 'pointer' }}>
                <input
                  type="radio"
                  name="priceRange"
                  checked={minPrice === '250000'}
                  onChange={() => {
                    const p = new URLSearchParams(searchParams);
                    p.set('minPrice', '250000');
                    p.delete('maxPrice');
                    setSearchParams(p);
                  }}
                />
                Trên 250.000đ
              </label>
            </div>
          </div>
        </aside>

        {/* Books Grid */}
        <main>
          {loading ? (
            <LoadingSpinner text="Đang tìm kiếm sách..." />
          ) : books.length === 0 ? (
            <div className="card" style={{ textAlign: 'center', padding: '60px 20px' }}>
              <p style={{ fontSize: '16px', fontWeight: '600', color: 'var(--text-muted)', marginBottom: '16px' }}>
                Không tìm thấy cuốn sách nào phù hợp với bộ lọc hiện tại.
              </p>
              <button onClick={() => setSearchParams({})} className="btn btn-primary btn-sm">
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
                <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', gap: '10px' }}>
                  <button
                    disabled={page <= 1}
                    onClick={() => updateParam('page', (page - 1).toString())}
                    className="btn btn-outline btn-sm"
                  >
                    <ChevronLeft size={16} /> Trang trước
                  </button>

                  <span style={{ fontSize: '14px', fontWeight: '600', padding: '0 12px' }}>
                    Trang {page} / {totalPages}
                  </span>

                  <button
                    disabled={page >= totalPages}
                    onClick={() => updateParam('page', (page + 1).toString())}
                    className="btn btn-outline btn-sm"
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
  );
};
