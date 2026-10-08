import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext';
import { CartProvider } from './context/CartContext';
import { Navbar, Footer } from './components/NavbarAndFooter';
import { ProtectedRoute, ErrorBoundary } from './components/UIComponents';

import { Home } from './pages/Home';
import { Books } from './pages/Books';
import { BookDetail } from './pages/BookDetail';
import { Cart } from './pages/Cart';
import { Checkout } from './pages/Checkout';
import { Orders } from './pages/Orders';
import { Wishlist } from './pages/Wishlist';
import { Login, Register } from './pages/AuthPages';
import { AdminDashboard, AdminBooks, AdminOrders, AdminCoupons } from './pages/admin/AdminPages';
import { AdminUsers } from './pages/admin/AdminUsers';
import { EmployeeDashboard } from './pages/employee/EmployeePages';

export function App() {
  return (
    <AuthProvider>
      <CartProvider>
        <BrowserRouter>
          <div style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
            <Navbar />
            
            <main style={{ flex: 1 }}>
              <ErrorBoundary>
                <Routes>
                  {/* Customer Routes */}
                  <Route path="/" element={<Home />} />
                  <Route path="/books" element={<Books />} />
                  <Route path="/books/:id" element={<BookDetail />} />
                  <Route path="/cart" element={<Cart />} />
                  <Route path="/wishlist" element={
                    <ProtectedRoute>
                      <Wishlist />
                    </ProtectedRoute>
                  } />
                  <Route path="/checkout" element={
                    <ProtectedRoute>
                      <Checkout />
                    </ProtectedRoute>
                  } />
                  <Route path="/orders" element={
                    <ProtectedRoute>
                      <Orders />
                    </ProtectedRoute>
                  } />

                  {/* Auth Routes */}
                  <Route path="/login" element={<Login />} />
                  <Route path="/register" element={<Register />} />

                  {/* Admin Only Routes */}
                  <Route path="/admin" element={
                    <ProtectedRoute requireAdmin={true}>
                      <AdminDashboard />
                    </ProtectedRoute>
                  } />
                  <Route path="/admin/books" element={
                    <ProtectedRoute requireManager={true}>
                      <AdminBooks />
                    </ProtectedRoute>
                  } />
                  <Route path="/admin/orders" element={
                    <ProtectedRoute requireManager={true}>
                      <AdminOrders />
                    </ProtectedRoute>
                  } />
                  <Route path="/admin/coupons" element={
                    <ProtectedRoute requireManager={true}>
                      <AdminCoupons />
                    </ProtectedRoute>
                  } />
                  <Route path="/admin/users" element={
                    <ProtectedRoute requireAdmin={true}>
                      <AdminUsers />
                    </ProtectedRoute>
                  } />

                  {/* Employee Workspace Routes (requireManager={true}) */}
                  <Route path="/employee" element={
                    <ProtectedRoute requireManager={true}>
                      <EmployeeDashboard />
                    </ProtectedRoute>
                  } />
                  <Route path="/employee/books" element={
                    <ProtectedRoute requireManager={true}>
                      <AdminBooks />
                    </ProtectedRoute>
                  } />
                  <Route path="/employee/orders" element={
                    <ProtectedRoute requireManager={true}>
                      <AdminOrders />
                    </ProtectedRoute>
                  } />
                </Routes>
              </ErrorBoundary>
            </main>

            <Footer />
          </div>
        </BrowserRouter>
      </CartProvider>
    </AuthProvider>
  );
}

export default App;
