// This file is overwritten at container startup by docker-entrypoint.sh.
// During local development it provides an empty stub so the app falls back
// to import.meta.env values supplied by Vite.
window.__env__ = {};
