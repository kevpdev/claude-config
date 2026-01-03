# Code Quality Rules

## Architecture
**SOLID:** Single responsibility, Open/Closed, Liskov substitution, Interface segregation, Dependency inversion
**Patterns:** Composition > inheritance, Factory, Observer, Adapter, Strategy
**DDD:** When domain complex - ubiquitous language, bounded contexts, aggregates
**Clean/Hexagonal:** Business logic independent of frameworks, dependencies point inward

## TypeScript
**Strict mode always:** `strict: true`, no implicit any, null checks
**Types:** No `any` (use `unknown`), explicit return types on public functions, generics for reusability
**Organization:** Interfaces for contracts, types for internals, avoid assertions

## Testing Essentials
**TDD:** For complex logic, Red→Green→Refactor, tests as spec
**Coverage:** 80% critical paths, 100% business logic
**Types:** Unit (fast, isolated), Integration (DB, external), E2E (user journeys), Contract (API)
**Practices:** Arrange-Act-Assert, one assertion/test, descriptive names, test behavior not implementation

**Detailed testing strategy:** See `rules/testing.md`

## Performance
**Frontend:** Code split by route, lazy load heavy components, optimize images (WebP, srcset)
**Core Web Vitals:** LCP <2.5s, FID <100ms, CLS <0.1
**General:** Profile before optimizing, caching (Redis, CDN), DB indexes + EXPLAIN

## Domain Principles

### Backend
**Focus:** Explain _why_ not just _how_
**Approach:** Expose trade-offs (monolith vs micro, SQL vs NoSQL), real examples (Uber/Netflix/Airbnb), scalability (horizontal/vertical, sharding, caching)
**Constraints:** Max 300w, code on demand, analogies required

### Frontend
**Focus:** UX + accessibility + performance (no sacrifices)
**Approach:** Framework trade-offs (React/Vue/Svelte - bundle/DX/runtime), Core Web Vitals non-negotiable, a11y always mentioned, state management by complexity
**Constraints:** Max 300w, visual examples (demos/gists), a11y always

### DevOps
**Focus:** Observability > perfection
**Approach:** Automation first (CI/CD, IaC, GitOps), observability (logs/metrics/traces/alerts), resilience (auto-scale, circuit breakers, graceful degradation), cost optimization
**Constraints:** Max 280w, config snippets 5 lines (full on request), checklists, reference docs

### Data
**Focus:** Measurable performance > theory
**Approach:** SQL vs NoSQL context (ACID→SQL, flexible→NoSQL, time-series→InfluxDB, cache→Redis), EXPLAIN ANALYZE, indexing strategies, avoid N+1, ETL vs ELT
**Constraints:** Max 320w, pseudo-SQL first (full on request), ASCII diagrams, metrics when available
