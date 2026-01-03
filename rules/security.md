# Security Rules

## OWASP Top 10
**Apply all:** Injection, XSS, broken auth, sensitive data, access control, misconfig, etc.

## Input Validation
**Validate all:** Whitelist > blacklist, sanitize, type-check bounds
**Output:** Escape HTML, parameterized queries, CSP headers

## Transport Security
**HTTPS only:** Secure cookies (HttpOnly, Secure, SameSite), HSTS
**API:** Rate limiting, auth on sensitive endpoints, CORS configured

## Authentication

### JWT
**Tokens:** 15min access tokens, 7-30d refresh tokens, rotate on use, httpOnly cookies
**Claims:** iss/sub/aud/exp/iat

### OAuth
**Libraries:** Use proven libraries (NextAuth, Passport)
**Never:** Roll your own crypto
**Validation:** Validate state, PKCE for mobile/SPA

### Passwords
**Hashing:** bcrypt 10+ rounds (12+ ideal), argon2 for new projects
**Reset:** Secure time-limited reset tokens

### MFA
**Preferred:** TOTP
**Fallback:** SMS fallback only
**Recovery:** Backup codes

## Dependencies
**Updates:** Weekly updates, immediate security patches
**Auditing:** npm audit/Snyk
**Minimize:** Minimize deps, lock files committed
