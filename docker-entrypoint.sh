#!/bin/sh
# Generate runtime environment configuration for the React app.
# Valid runtime variables override build-time defaults baked into the bundle.
# Unset/invalid values are omitted so the app can fall back to build-time values.

sanitize() {
  val="$1"
  case "$val" in
    true|false) echo "\"$val\"" ;;
    *) echo "undefined" ;;
  esac
}

SHOW_DISCORD=$(sanitize "${VITE_SHOW_DISCORD}")
SHOW_GITHUB_STAR=$(sanitize "${VITE_SHOW_GITHUB_STAR}")
SHOW_HIRE_ME=$(sanitize "${VITE_SHOW_HIRE_ME}")

cat > /usr/share/nginx/html/env-config.js <<EOF
window.__env__ = {
  VITE_SHOW_DISCORD: ${SHOW_DISCORD},
  VITE_SHOW_GITHUB_STAR: ${SHOW_GITHUB_STAR},
  VITE_SHOW_HIRE_ME: ${SHOW_HIRE_ME}
};
EOF

exec "$@"
