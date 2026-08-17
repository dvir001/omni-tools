declare const __APP_VERSION__: string;
declare const __COMMIT_HASH__: string;

interface Window {
  __env__?: Record<string, string>;
}
