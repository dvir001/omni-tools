#!/bin/sh
# Generate runtime environment configuration for the React app.
# Variables set here override the build-time defaults baked into the bundle.
# Only "true" and "false" are accepted; any other value falls back to "true".

sanitize() {
  val="$1"
  default="$2"
  case "$val" in
    true|false) echo "$val" ;;
    *) echo "$default" ;;
  esac
}

SHOW_DISCORD=$(sanitize "${VITE_SHOW_DISCORD}" "true")
SHOW_GITHUB_STAR=$(sanitize "${VITE_SHOW_GITHUB_STAR}" "true")
SHOW_HIRE_ME=$(sanitize "${VITE_SHOW_HIRE_ME}" "true")

cat > /usr/share/nginx/html/env-config.js <<EOF
window.__env__ = {
  VITE_SHOW_DISCORD: "${SHOW_DISCORD}",
  VITE_SHOW_GITHUB_STAR: "${SHOW_GITHUB_STAR}",
  VITE_SHOW_HIRE_ME: "${SHOW_HIRE_ME}"
};
EOF

exec nginx -g "daemon off;"
