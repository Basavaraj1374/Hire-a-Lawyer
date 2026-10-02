// =============================================
// Hire A Lawyer - Global API Client & Utilities
// =============================================

const API_BASE = '/api';

// ---- Token Management ----
const Auth = {
  getToken: () => localStorage.getItem('hal_token'),
  getUser: () => { try { return JSON.parse(localStorage.getItem('hal_user')); } catch { return null; } },
  setSession: (token, user) => { localStorage.setItem('hal_token', token); localStorage.setItem('hal_user', JSON.stringify(user)); },
  clearSession: () => { localStorage.removeItem('hal_token'); localStorage.removeItem('hal_user'); },
  isLoggedIn: () => !!localStorage.getItem('hal_token'),
  requireAuth: () => { if (!Auth.isLoggedIn()) { window.location.href = '/login'; return false; } return true; },
  requireRole: (roles) => {
    const user = Auth.getUser();
    if (!user || !roles.includes(user.role)) { Toast.error('Access denied.'); setTimeout(() => window.location.href = '/dashboard', 1500); return false; }
    return true;
  }
};

// ---- API Fetch Wrapper ----
const API = {
  async request(method, url, body = null, isFormData = false) {
    const headers = {};
    const token = Auth.getToken();
    if (token) headers['Authorization'] = `Bearer ${token}`;
    if (!isFormData) headers['Content-Type'] = 'application/json';

    const opts = { method, headers };
    if (body) opts.body = isFormData ? body : JSON.stringify(body);

    try {
      const res = await fetch(API_BASE + url, opts);
      const data = await res.json();
      if (res.status === 401) { Auth.clearSession(); window.location.href = '/login'; return null; }
      return { ok: res.ok, status: res.status, data };
    } catch (err) {
      console.error('API Error:', err);
      Toast.error('Network error. Please check your connection.');
      return null;
    }
  },
  get: (url) => API.request('GET', url),
  post: (url, body) => API.request('POST', url, body),
  put: (url, body) => API.request('PUT', url, body),
  delete: (url) => API.request('DELETE', url),
  upload: (url, formData) => API.request('POST', url, formData, true)
};

// ---- Toast Notifications ----
const Toast = {
  container: null,
  init() {
    this.container = document.createElement('div');
    this.container.className = 'toast-container';
    document.body.appendChild(this.container);
  },
  show(message, type = 'info', duration = 4000) {
    if (!this.container) this.init();
    const icons = { success: '✅', error: '❌', info: 'ℹ️' };
    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;
    toast.innerHTML = `<span>${icons[type]}</span><span>${message}</span>`;
    this.container.appendChild(toast);
    setTimeout(() => { toast.style.opacity = '0'; toast.style.transform = 'translateY(10px)'; toast.style.transition = '0.3s'; setTimeout(() => toast.remove(), 300); }, duration);
  },
  success: (msg) => Toast.show(msg, 'success'),
  error: (msg) => Toast.show(msg, 'error'),
  info: (msg) => Toast.show(msg, 'info')
};
Toast.init();

// ---- UI Helpers ----
const UI = {
  loading(selector, show, text = 'Loading...') {
    const el = document.querySelector(selector);
    if (!el) return;
    if (show) {
      el.setAttribute('data-original-text', el.innerHTML);
      el.innerHTML = `<span class="spinner" style="width:18px;height:18px;border-width:2px;display:inline-block;vertical-align:middle;margin-right:6px"></span>${text}`;
      el.disabled = true;
    } else {
      el.innerHTML = el.getAttribute('data-original-text') || text;
      el.disabled = false;
    }
  },
  showError(selector, message) {
    const el = document.querySelector(selector);
    if (el) { el.textContent = message; el.style.display = 'block'; }
  },
  hideError(selector) {
    const el = document.querySelector(selector);
    if (el) { el.style.display = 'none'; }
  },
  openModal(id) { document.getElementById(id).classList.add('active'); },
  closeModal(id) { document.getElementById(id).classList.remove('active'); },
  formatDate(dateStr) {
    if (!dateStr) return '—';
    return new Date(dateStr).toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' });
  },
  formatDateTime(dateStr) {
    if (!dateStr) return '—';
    return new Date(dateStr).toLocaleString('en-IN', { day: '2-digit', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit' });
  },
  statusBadge(status) {
    return `<span class="badge badge-${status}">${status.replace('_', ' ')}</span>`;
  },
  priorityBadge(priority) {
    const colors = { low: 'active', medium: 'pending', high: 'open', urgent: 'rejected' };
    return `<span class="badge badge-${colors[priority] || 'open'}">${priority}</span>`;
  },
  stars(rating) {
    const full = Math.round(rating || 0);
    return '★'.repeat(full) + '☆'.repeat(5 - full);
  },
  avatarInitials(name) {
    if (!name) return '?';
    return name.split(' ').map(w => w[0]).join('').toUpperCase().slice(0, 2);
  },
  emptyState(message = 'No records found', icon = '📋') {
    return `<div class="empty-state"><div class="empty-icon">${icon}</div><p>${message}</p></div>`;
  }
};

// ---- Notification Manager ----
const Notifs = {
  async load() {
    const res = await API.get('/notifications');
    if (!res || !res.ok) return;
    const { data, unread_count } = res.data;
    const badge = document.querySelector('.notif-badge');
    if (badge) { badge.textContent = unread_count > 0 ? unread_count : ''; badge.style.display = unread_count > 0 ? 'inline' : 'none'; }
    const list = document.getElementById('notif-list');
    if (list) {
      if (data.length === 0) { list.innerHTML = '<div class="notif-item"><p style="color:var(--text-muted);font-size:0.85rem">No notifications</p></div>'; return; }
      list.innerHTML = data.slice(0, 8).map(n => `
        <div class="notif-item ${n.is_read ? '' : 'unread'}" onclick="Notifs.markRead(${n.id}, this)">
          ${!n.is_read ? '<div class="notif-dot"></div>' : '<div style="width:8px"></div>'}
          <div class="notif-text">
            <p><strong>${n.title}</strong></p>
            <p>${n.message}</p>
            <span>${UI.formatDateTime(n.created_at)}</span>
          </div>
        </div>`).join('');
    }
  },
  async markRead(id, el) {
    await API.put(`/notifications/${id}/read`);
    el.classList.remove('unread');
    const dot = el.querySelector('.notif-dot');
    if (dot) dot.style.background = 'transparent';
    this.load();
  },
  async markAllRead() {
    await API.put('/notifications/read-all');
    Toast.success('All notifications marked as read.');
    this.load();
  }
};

// ---- Sidebar Active State ----
function initSidebar() {
  const path = window.location.pathname;
  document.querySelectorAll('.sidebar-item').forEach(item => {
    const href = item.getAttribute('href');
    if (href && path.startsWith(href)) item.classList.add('active');
  });
}

// ---- Navbar User Info ----
function initNavbar() {
  const user = Auth.getUser();
  if (!user) return;
  const avatar = document.querySelector('.navbar-user .user-avatar');
  if (avatar) { avatar.textContent = UI.avatarInitials(user.name); avatar.title = user.name; }
  const userNameEl = document.getElementById('nav-user-name');
  if (userNameEl) userNameEl.textContent = user.name;
  const roleEl = document.getElementById('nav-user-role');
  if (roleEl) roleEl.textContent = user.role;
}

// ---- Tabs ----
function initTabs() {
  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const target = btn.dataset.tab;
      const container = btn.closest('[data-tabs]') || document;
      container.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
      container.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
      btn.classList.add('active');
      const pane = container.querySelector(`#${target}`);
      if (pane) pane.classList.add('active');
    });
  });
}

// ---- Logout ----
function logout() {
  Auth.clearSession();
  Toast.info('Logged out successfully.');
  setTimeout(() => window.location.href = '/', 1000);
}

// ---- Notification Toggle ----
function toggleNotifPanel() {
  const panel = document.getElementById('notif-panel');
  if (panel) {
    panel.classList.toggle('open');
    if (panel.classList.contains('open')) Notifs.load();
  }
}

// ---- On DOM Ready ----
document.addEventListener('DOMContentLoaded', () => {
  initSidebar();
  initNavbar();
  initTabs();
  if (Auth.isLoggedIn()) Notifs.load();

  // Close modal on overlay click
  document.querySelectorAll('.modal-overlay').forEach(overlay => {
    overlay.addEventListener('click', (e) => {
      if (e.target === overlay) overlay.classList.remove('active');
    });
  });

  // Close notif panel on outside click
  document.addEventListener('click', (e) => {
    const panel = document.getElementById('notif-panel');
    const bell = document.getElementById('notif-bell');
    if (panel && !panel.contains(e.target) && bell && !bell.contains(e.target)) {
      panel.classList.remove('open');
    }
  });
});
