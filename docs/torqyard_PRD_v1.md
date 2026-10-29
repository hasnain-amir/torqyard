# Automotive Community Platform
## Product Requirements Document (PRD)

| Document | Details |
| --- | --- |
| **Version** | 1.0 |
| **Status** | Approved discovery baseline; implementation subject to feasibility gates |
| **Date** | 28 October 2026 |
| **Working title** | Automotive Community Platform (internal only) |
| **Public brand** | To be chosen and cleared before public beta |
| **Product owner / technical lead** | Founder |
| **Primary market** | United Kingdom |
| **Delivery** | Solo-led development with AI coding assistance, reviewed GitHub pull requests and explicit owner approvals |
| **Interpretation rule** | This PRD records decisions from product discovery. “Must” identifies a required capability in its assigned phase, not necessarily at the first beta. Conditional items must pass their stated feasibility, licensing or legal gate. Named technologies are preferred candidates unless marked confirmed after testing. This document is a product and engineering planning baseline, not a legal opinion or evidence that external integrations are available. |

## 1. Executive summary
Build a premium, UK-wide automotive community for car and motorcycle enthusiasts, including people who do not yet own a vehicle. Traditional chronological forums form the centre of the experience, enriched by individual vehicle garages, build journals, clubs, events, media, messaging and eventually automotive business services. The experience must feel like a modern enthusiast platform rather than a forum theme with a few decorative vehicle cards.

Core proposition: A member can discuss vehicles and technical problems, present an evolving history of their own car or motorcycle, discover relevant builds and local communities, and build relationships around shared interests. Non-owners can participate fully.

Public-beta condition: Complete Phase 1 functionality and pass explicit product, security, privacy, accessibility, performance, operational and founder-approval gates. Founding members test the site privately first. No fixed release date.

Constraints: Target operating spend of £0–£25 per month initially; prefer free/self-managed infrastructure; avoid architecture that demands expensive independent services; no native video at beta; public brand unresolved; UK-facing legal and safeguarding obligations require assessment and review.

## 2. Goals, outcomes and non-goals
### 2.1 Product goals
1. Build a useful, active discussion community with enduring technical content and meaningful replies.
2. Give enthusiasts high-quality, privacy-aware vehicle identity pages and chronological build records.
3. Enable discovery by make, model, generation, year, vehicle type, modification and member interests.
4. Provide safe spaces for members, clubs and eventually approved automotive businesses.
5. Retain the ability to scale and migrate with modular architecture, documented data models and controlled dependencies.
6. Support equitable access across desktop and mobile, light/dark themes, and WCAG 2.2 AA target.
### 2.2 Success measures
Use a privacy-conscious scorecard rather than arbitrary launch quotas: registration-to-first-meaningful-action conversion; weekly active and returning members; substantive discussions, replies, unanswered questions and accepted solutions; vehicle profiles created, build updates and follows; reports, moderation response and qualitative satisfaction. Record baseline values in private beta; set targets only after observing actual behaviour. These are product-health metrics, not substitutes for the separate technical release gates.
### 2.3 Explicit non-goals and exclusions

- No marketplace/classifieds in initial launch scope.
- No native ticket purchasing or payment collection for events initially.
- No default algorithmic feed, XP/streaks, anonymous posting or forum signatures initially.
- No claim that DVLA lookup verifies vehicle ownership.
- No guaranteed interactive 3D coverage or production-quality digital twins.
- No mandatory native short-video hosting during beta.
- No bespoke full-text search cluster unless benchmark evidence warrants one.
- No automatic irreversible AI moderation decisions.
- No fixed date commitments or unreviewed automatic production deployments.

## 3. Audience, roles and journeys
### 3.1 Primary users

- Enthusiasts owning cars and/or motorcycles; restorers, tuners, collectors and commuters.
- Prospective owners and learners, who must receive full forum/community access without registering a vehicle.
- Technically knowledgeable contributors helping diagnose faults and answer questions.
- Organisers and clubs providing structured local or nationwide activities.
- Approved automotive businesses participating through dedicated profiles and enquiries (Phase 3).
### 3.2 Role and permission hierarchy
Platform roles: Guest; Registered Member; Trusted Member; Category Moderator; Site Moderator; Site Administrator. Trust is an explicit, transparent capability gate for club and event creation and higher upload allowances. Privileged accounts must use MFA. Roles are scoped; being a club moderator does not grant site-wide access.

Club roles: Owner, Administrator, Moderator, Event Organiser, Member. A site's authorised staff may intervene with auditable scope. A club can be Public, Private/discoverable with approval, or Invite-only/hidden.

Business roles: Business submitter; verified/claimed business manager; authorised business inbox users; site staff verifying evidence. Verification proves an account's relationship to a business, not the quality of its services.

Minor handling: Proposed minimum age 16, subject to formal assessment. Members aged 16–17 receive restricted defaults for direct contact, discovery and event/location information, with appropriate safeguards and age assurance based on assessed obligations.
### 3.3 Priority end-to-end user journeys
- **J1** Onboard and engage: User registers, verifies email, selects optional interests, finds a relevant thread, posts/replies and subscribes; no vehicle required.
- **J2** Add a vehicle: Member creates a car or bike manually, optionally requests approved DVLA lookup, corrects imported details, configures visibility and uploads optimised photos. Registration is private by default.
- **J3** Record a build: Owner adds a structured modification linked to a build journal entry, photos and a related forum discussion; followers receive only authorised notifications.
- **J4** Solve a question: Member creates a Question topic; replies remain chronological; author/authorised actors accept a solution; topic can be reopened; unanswered/solved filters update.
- **J5** Moderate restricted content: Report enters scoped case queue; authorised reviewer sees only evidence needed; warning or restriction is applied with an auditable reason; appeal routes to an independent reviewer.
- **J6** Delete an account: Member can export data, request deletion, receive clear explanation of retained eligible public posts, and have deletion re-enforced after backup restoration.

Later-phase journeys: Club sets up restricted space and event; member RSVPs; business receives a quote enquiry referencing a garage vehicle only after explicit consent.

## 4. Product experience and information architecture
### 4.1 Visual identity
Working visual direction: Carbon Amber. Carbon Black #111214; Gunmetal #292B2F; Amber #D98B43; Warm Ivory #F6F1E9; Ash Grey #ACA9A5. Preferred typography direction: Space Grotesk headings and Inter interface/body, subject to licensing and performance validation. Premium automotive photography, clean layout and restraint in accent colour. Brand assets, public-facing name and domain remain replaceable/configurable until clearance.

Theme modes: Light, Dark and System, persist preference between visits and respect system changes in System mode. Both modes must satisfy contrast and focus requirements; colours are design inputs, not automatic evidence of compliance.
### 4.2 Navigation and homepage
Desktop: clean horizontal navigation of major destinations with More for secondary areas, plus search, notifications and profile access. Mobile: bottom navigation for high-frequency destinations, with remaining destinations under More. Exact tabs subject to usability tests and accessibility audit.

Homepage: discussions first (Latest/New/Trending and useful category entry points); garages, highlighted builds, clubs and upcoming events in supporting sections. No default algorithm-driven feed. Public experience must not expose restricted content or private metadata.
### 4.3 Density and accessibility
Compact discussion listings; spacious, image-led garage/build/event cards; comfortable long-form thread typography. Member preference for Compact or Comfortable layout. Mobile responsive; maintain logical reading order and tap targets. WCAG 2.2 Level AA target with keyboard navigation, focus visibility, semantic structure, screen readers, accessible controls, colour contrast, text zoom, reduced motion, alt text and accessible media. Automated checking supplements manual keyboard and assistive-technology testing.

## 5. Functional requirements by phase
### 5.1 Phase 1: Accounts, profiles and onboarding
- **FR-ACC-01** Support verified email/password registration, secure sign-in/sign-out, password recovery and rate-limited anti-bot protections. Email verification required before trust-sensitive actions.
- **FR-ACC-02** Support optional MFA for members and mandatory MFA for privileged staff, with secure recovery procedures, session visibility and revocation.
- **FR-ACC-03** Persist profile visibility, online/last-seen visibility, contact preferences, linked-provider state, session list, account export/deactivation/deletion settings.
- **FR-ACC-04** Support optional, skippable guided onboarding: interests, favourite manufacturers, optional avatar/bio, first vehicle, suggested discussions/clubs/builds/people. Do not require vehicle ownership.
- **FR-ACC-05** Design stable identity/provider linking boundaries for later Google, Apple and passkeys; activate only after supported NodeBB integration and security verification. No public-beta dependency.

> **Acceptance:** Register/verify/recover/revoke sessions works on supported devices; unauthenticated access is appropriately denied; staff MFA enforced; onboarding may be skipped end-to-end; deleted/unpublished profile fields do not appear in public views or search.
### 5.2 Phase 1: Forum and discussions
- **FR-FOR-01** Organise discussions into site categories, manufacturer/model taxonomy and topic tags; support both cars and motorcycles without segregating non-owners.
- **FR-FOR-02** Two primary topic types: Discussion and Question. Question states include open/solved/unresolved; accepted solutions, unanswered filter and reopening supported.
- **FR-FOR-03** Chronological replies with reply-to context and quotation, without deeply nested Reddit-style ranking. Support rich editor, attachments, saved drafts, polls, reactions, subscriptions, bookmarks, edit history and direct post URLs.
- **FR-FOR-04** Numbered pagination, first/last/unread navigation, read position, mobile-friendly reading and performant long topics.
- **FR-FOR-05** Latest, New, Trending, Unanswered, Following and Bookmarks views. Reputation/expertise badges based on useful contributions, accepted solutions and feedback, protected against gaming; no XP/streak mechanic.
- **FR-FOR-06** Public discussions can be indexed and appear in site-wide discovery; authorisation governs any club-restricted and private content.

> **Acceptance:** Create/edit/reply/bookmark/subscribe/question-solve/reopen workflows pass tests; chronological order stable; direct links and pagination work; cross-role permission tests pass; private topics never leak in feeds, metadata or notifications.
### 5.3 Phase 1: Garage-first member profiles
- **FR-GAR-01** Member profile prominently displays current vehicles, previous vehicles, builds, forum activity and member information. Non-owners retain fully functional profiles.
- **FR-GAR-02** Each vehicle is an individual detailed page supporting car/bike identity, manufacturer, model, generation, year, variants, technical specifications, photos, externally embedded videos, modifications, build journal, service/maintenance records, performance results, ownership narrative and related discussions. Costs/expenditure tracking excluded.
- **FR-GAR-03** Manual vehicle creation is complete and usable without third-party services. Optional DVLA provider interface may populate permitted fields upon approved access. Member can correct imported values; number plates/registrations remain private by default; lookup never conveys ownership verification.
- **FR-GAR-04** Structured modification records reference parts/area/status and can link bidirectionally to build entries and forum replies without requiring duplicate data entry.
- **FR-GAR-05** Configurable per-vehicle and component-level visibility for photos, modifications, journals, maintenance, results and ownership narrative. Enforce decisions at data-fetch, API, media, notification, search and export boundaries, not only in UI.
- **FR-GAR-06** Separate Current Vehicles and archived Previous Vehicles, with ownership history and build records preserved under their settings.
- **FR-GAR-07** Member/vehicle follows, comments, reactions, bookmarks, shareable authorised pages, build update alerts, ask-owner and featured builds; respect notification and profile privacy preferences.
- **FR-GAR-08** Directory filters: car/bike, manufacturer, model, generation, year, modification category, project status and popularity; sort newest, recently updated and followed.
- **FR-GAR-09** Trusted contributor invitations allow limited editing of build journals, modifications and media; acceptance, revocation, attribution and audit are mandatory. Ownership and privacy control remain with the primary owner.
- **FR-GAR-10** (conditional/post-beta) Interactive generation-matched 3D references with licensed models and hotspots associated with modifications/photos. Model unavailability must not affect ordinary garage use. Accurate digital twins are a future ambition, not Phase 1 delivery.

> **Acceptance:** Two vehicles can coexist on one profile with distinct privacy; revoked contributor loses access immediately; private photos cannot be fetched by guessing URLs; vehicle archive preserves links/privacy; build modifications link consistently; manual creation always works.
### 5.4 Phase 1: Unified discovery and search
- **FR-SRH-01** One global search interface covering every released content type, with adapters for NodeBB and custom data. Phase 1 indexes discussions, members/public garages and builds; expand to clubs, events and businesses as those modules launch.
- **FR-SRH-02** Content-type and automotive filters; relevant facets and sorting. Use supported NodeBB/database search initially; benchmark before deciding on Meilisearch/Typesense or another engine.
- **FR-SRH-03** Permission-aware results, facets, counts, autocomplete, snippets, previews, caches and indexing. Results must not disclose hidden clubs, private garage attributes or excluded content. Visibility changes and deletions propagate to indexes.

> **Acceptance:** Role/visibility matrix tests for direct queries, suggestions and result counts; common search p95 under two seconds under agreed test conditions; no hidden-content leakage.
### 5.5 Phase 1: Media and attachments (essential slice)
- **FR-MED-01** Native photo upload, automatic thumbnail/derivative creation, resizing, compression and metadata sanitation. Original photos up to 10 MB; maximum 10 per post; attachments up to 10 MB; initial per-member quota 500 MB (not pre-reserved storage).
- **FR-MED-02** Validate extension, MIME, decoded format and content; prevent executable uploads; malware scanning or equivalent feasible controls; apply quotas/rate limits and additional restrictions for new/untrusted accounts.
- **FR-MED-03** Use storage-adapter abstraction with economical local storage at beta and a documented migration path to object storage; record ownership/visibility and preserve relationships across migration.
- **FR-MED-04** Embedded external video allowed subject to provider/content/privacy controls. Native videos disabled initially, enable only after capacity and safety testing.

> **Acceptance:** Invalid or oversized files blocked; private images use authorised delivery; uploader receives accessible progress/errors; derivative pipeline doesn't expose EXIF/location; off-server backup and restore of media verified; storage quotas enforceable.
### 5.6 Phase 1: Moderation, privacy and administration
- **FR-MOD-01** Reporting across posts, profiles, garages and uploaded media, with predefined reasons, evidence, status updates, prioritisation, duplicate handling and abuse-rate protections.
- **FR-MOD-02** Layered site, category and club moderation permissions; graduated notice, warning, feature restriction, temporary suspension and permanent ban; immediate escalation for severe harm; independent appeals and audited decisions.
- **FR-MOD-03** Spam/rate limits, human review, optionally assisted classification. AI may flag or quarantine but must not issue irreversible sanctions without human approval.
- **FR-MOD-04** Access to reported private messages (when messaging launches) restricted to authorised, audited case workflows; no unrestricted staff browsing.
- **FR-ADM-01** Unified admin experience built through supported NodeBB extension points. Phase 1 essentials: user/role management, moderation queue, content and garage oversight, configuration/feature flags, action audit logs and platform health. Add module-specific tools with later releases.
- **FR-PRV-01** Self-service privacy settings, data export, deactivation and deletion, including genuine anonymisation of eligible retained public contributions. Deletion mechanics follow legal review and retention schedule.

> **Acceptance:** RBAC matrix passes automated denial/allow tests; appeals trace original sanction and decision maker; sensitive access generates audit events; account deletion removes eligible private content and requests downstream cleanup.
### 5.7 Phase 1: Notifications and essential email
- **FR-NOT-01** On-site notification centre for replies, mentions, follows, vehicle/build updates and relevant platform events. Preferences by type, muted topics and read/unread operations.
- **FR-NOT-02** Transactional email provider abstraction for verification, recovery and security notices, with queued delivery, bounded retries, deduplication, rate limits and delivery failure alerts.
- **FR-NOT-03** Expand member-selected instant, daily and weekly community emails progressively. Mandatory security communications handled separately and lawfully.

> **Acceptance:** Only authorised content appears in alert payloads; email failures observable; duplicated events don't flood inboxes; preferences respected except for essential security messages.
### 5.8 Phase 2: Clubs
- **FR-CLB-01** Full club spaces: title, branding, description, membership, announcements, discussions, featured member vehicles, events and scoped moderation.
- **FR-CLB-02** Public, Private discoverable/approval-required and hidden Invite-only modes. Public club threads may appear in main Latest/Trending/search; private and invite-only content must not leak.
- **FR-CLB-03** Club Owner, Administrator, Moderator, Event Organiser and Member roles with documented capabilities; site staff intervention audited.
- **FR-CLB-04** Trusted members can create clubs; new members may request creation rights with transparent eligibility criteria.

> **Acceptance:** Hidden clubs cannot be discovered or inferred; membership/role revocations take effect immediately; public content syndication does not weaken restricted content rules.
### 5.9 Phase 2: Meets and events
- **FR-EVT-01** Trusted members, authorised clubs and approved businesses may submit events; new members can request posting permission.
- **FR-EVT-02** Directory: list, calendar and interactive UK map; location/distance, town/postcode, date and event-type filters. Private locations must remain private.
- **FR-EVT-03** Event page: meeting points, routes, schedules, ground rules, external ticket link, gallery, discussion, recurrence and downloadable calendar invite. No native ticket payment initially.
- **FR-EVT-04** Going/Interested/Not Going RSVP, private attendance settings, capacity/waitlists, automatic promotion, reminders, updates, organiser announcements, optional check-in and registration closure.
- **FR-EVT-05** Lifecycle scheduled/postponed/cancelled/completed, major change notifications, history, withdrawal and reporting.

> **Acceptance:** Attendee/location privacy survives feeds, links and calendar exports; cancelled events notify participants; waitlist logic remains consistent under concurrent requests.
### 5.10 Phase 2: Messaging
- **FR-MSG-01** Real-time 1:1 and group chats, attachments, reply references, reactions, read receipts, typing state, search and notifications.
- **FR-MSG-02** Contact policy Everyone/Following/Mutual Followers/Nobody, separate stranger requests and age-appropriate restrictive defaults.
- **FR-MSG-03** Group invite consent, group administrators, mute, leave, block and report controls, with auditable staff access to explicitly reported conversations only.

> **Acceptance:** Blocked senders cannot bypass requests; removed group members cannot fetch history contrary to policy; case-specific staff access logged; reported content visible only to authorised investigators.
### 5.11 Phase 2: Rich media discovery and advanced garage features
- **FR-MDA-01** Dedicated Media discovery plus galleries integrated in garages, discussions, clubs and events: albums, tags, likes, comments, bookmarks and source links.
- **FR-MDA-02** Attribution/photographer credits, uploader control, consent-based requests to tag someone else's vehicle, owner approval before linkage, public/members-only/private album modes, privacy/copyright reporting.
- **FR-MDA-03** Native short-video upload is separately gated by processing, security, storage, backups, moderation and bandwidth tests; initial default remains disabled.
- **FR-MDA-04** Explore optional licensed 3D reference models and hotspots without blocking regular vehicle pages.
### 5.12 Phase 3: Automotive businesses and monetisation
- **FR-BIZ-01** UK business directory/map with services, specialisms, hours, portfolio, contacts and public business profiles.
- **FR-BIZ-02** Submission screening, claim process, evidence-based verified-business badge, staff access controls and audit records. Badge does not endorse service quality.
- **FR-BIZ-03** Quotes/enquiries: choose service, optional explicit-sharing of relevant garage vehicle details/photos, business inbox, lifecycle/status updates and notifications; no implicit private-vehicle disclosure.
- **FR-BIZ-04** Star/written reviews, photos, evidence-based verified-customer indications, business responses, dispute process and protections against fake, retaliatory and paid reviews. Do not sell rating manipulation or legitimate-criticism removal.
- **FR-BIZ-05** Clearly labelled paid promoted listings, sponsored threads, featured profiles and display placements, with relevant controls and commercial policy review. Commercial pricing, billing/provider and exact launch timing remain later decisions.

> **Acceptance:** Business ownership claim verified by evidence; no unconsented personal garage data in enquiries; sponsored content visibly labelled; reports/appeals and fraud controls tested.

## 6. Non-functional requirements
### 6.1 Performance and scalability

- Core Web Vitals targets at p75 on representative user devices/networks: LCP <= 2.5 seconds, INP <= 200 ms, CLS <= 0.1.
- Common search p95 < 2 seconds under defined test data and conditions.
- Initial load-test scenario equivalent to 50 concurrent active users; record latency, errors, server/database resources and bottlenecks.
- Responsive pagination, bounded queries, image derivatives and lazy loading. Targets must be measured on actual candidate hosting before release; failure requires tuning, capacity change or documented release hold.
### 6.2 Security and trust
Secure sessions, least privilege, CSRF/XSS/injection defence, secure content upload, protections for login/reset routes, secret management, dependency scanning, MFA for all privileged users, security review of plugins and integrations. Threat-model private garages, club permissions, DM reports, vehicle registrations and business enquiries. No sensitive data in URLs/logs/analytics when avoidable. Automated permission regression tests required.
### 6.3 Availability, monitoring and incident handling
External uptime/HTTPS certificate monitoring, server CPU/RAM/disk, database and app health, structured redacted error logs, email/worker/backup failures, suspicious actions, incident severity and escalation playbook, status page if justified. Prefer self-hosted/free services within budget; avoid claiming a contractual availability SLA at initial beta.
### 6.4 Backups, recovery and retention
Daily encrypted off-server backups of database, media and essential configuration; retain 7 daily and 4 weekly backups; backup before major migrations; monitor failures; restoration test quarterly and before beta. Maintain secure restore runbooks, validated integrity checks and deletion-replay procedure. Backup retention and live deletion rules need UK legal review. Diagnostic log retention initially approximately 30 days, adjustable after review; security and moderation records use purpose-based schedules.
### 6.5 Privacy, online safety and legal
UK GDPR/privacy-by-design provider inventory, controller/processor allocation, appropriate DPAs and transfer safeguards, lawful-basis and DPIA review where required, ICO registration/fee check, breach/data-subject request procedures. Target minimum member age 16, with enhanced protections for 16–17-year-olds and formal child-access/safety assessments and age assurance as applicable. Safety-by-design assessments, complaint mechanisms, documented content governance and named responsibility. Versioned Terms, Privacy, cookies/consent, Community Guidelines, rights complaints, reporting/appeals, deletion/retention and operational policies require UK legal review before public beta. Commercial policies before Phase 3.
### 6.6 Data ownership and content rights
Members retain copyright in original contributions, granting a limited service-operational licence; external marketing/promotional reuse requires separate permission. Structured evidence-based copyright complaint/review/dispute process, repeat-infringer controls and protections against abusive reports. Manufacturer identifiers permitted for factual use subject to legal review; logos/promotional imagery/spec datasets/3D models require verified permission where applicable, with provenance and licensing records. Never rip assets from games/configurators.
### 6.7 Deletion and portability
Documented schemas, relationships and versioned migrations; structured exports preserving cross-references/media; stable identifiers; avoid undocumented NodeBB internal dependencies. On deletion, remove/anonymise personal account data and eligible garage/private content; retain eligible anonymised public discussion contributions only where lawful and truly de-identified, under Deleted Member. Provide further removal review. Restrict backup access and reapply deletions after restore. Full cross-platform migration tooling deferred until justified.

## 7. Architecture and technical decision records
### 7.1 Preferred approach, not unverified certainty
NodeBB: Preferred forum/community engine, not yet formally selected. A feasibility spike must demonstrate supported extension points, modern theme/navigation integration, scope-enforced authorisation, custom garage workflows, compatibility with chosen storage, operational footprint and maintainable upgrades. A failed spike triggers an evidence-based alternatives review rather than forcing extensive unsupported patches.

Database: Prefer PostgreSQL, but do not assume production compatibility with the selected NodeBB release or extension ecosystem. Verify official support for that exact version, migrations, transactions, plugins and backups. If unsupported or materially fragile, choose a well-supported engine, documenting trade-offs; avoid dual databases unless clearly justified.

Modules: Forum core plus modular, independently tested features; explicit APIs and boundaries for garage, build, club, event, media, notification, search and business domains. Prefer one economical deployment initially. Separate services only when profiling or architectural necessity warrants them.

Search: Unified query API and adapter contracts; use official/maintained NodeBB search plus database query capabilities first, filtered at permission boundary and indexing layer. Add dedicated search infrastructure only when measured relevance/performance constraints warrant it.

Files: Storage adapter (local first, object-storage migration later); signed or authenticated media access consistent with privacy settings; derivative processing and backups.

Email: Provider-agnostic transactional delivery, queue with bounded retries, idempotent events, observability; optional digests progressively.

Hosting: Oracle Cloud Always Free is a candidate, not guaranteed capacity/eligibility. Benchmark on real deployment; documented self-managed VPS fallback within monthly cap. Hosting plan must include off-server backups and account-level cost monitoring. Staging may be temporary/local; production isolated from development.
### 7.2 Mandatory technical feasibility spikes
**Spike — pass evidence — fallback**
- **SPIKE-01** NodeBB version and extension boundaries Prototype forum + custom garage route, roles, theme extension and documented upgrade Alternative supported NodeBB design or re-evaluate foundation
- **SPIKE-02** PostgreSQL support and plugins Install exact version, run integration flows and migration/restore/upgrade tests Use best-supported NodeBB database
- **SPIKE-03** Permission-isolated garages/search Matrix tests across private components, suggestions, metadata and direct media links Reduce scope until isolation is provable
- **SPIKE-04** Low-cost hosting Reproducible deployment, 50-user load test, backup/restore, monitoring, cost estimate Paid VPS within budget or revisit scope
- **SPIKE-05** Media pipeline Compression, EXIF sanitisation, quotas, secure delivery and restoration Restrict file limits/format or delay nonessential uploads
- **SPIKE-06** DVLA provider Approved access, terms, allowed fields, privacy review and failure-mode tests Complete manual entry only
- **SPIKE-07** 3D asset coverage Rights and attribution verified, reference match, acceptable performance Standard photo-based garage; future experiment
- **SPIKE-08** Messaging/club permissions Supported real-time primitives, staff report access control, minor safeguards Defer module or use supported bounded extension

Each spike produces a short ADR: objective, environment/version, tests and measurements, options considered, outcome, risks and founder sign-off.

## 8. Data model and permission blueprint
Key entities: Member, IdentityProvider, RoleAssignment, MemberTrust, MemberPreference, Vehicle, VehicleSpecification, VehicleMedia, VehiclePrivacyPolicy, Modification, BuildJournal, MaintenanceEntry, PerformanceRecord, VehicleContributorGrant, VehicleFollow, ForumCategory, Topic, Post, AcceptedSolution, Poll, Reaction, Bookmark, Notification, NotificationPreference, ModerationReport, ModerationCase, Appeal, AuditEvent, SearchDocument, MediaAsset, StorageObject, BackupRecord; later Club, ClubMembership, Event, EventRSVP, EventWaitlist, MessageConversation, Message, Business, BusinessClaim, BusinessEnquiry, Review, Sponsorship.

Required cross-cutting fields: stable IDs; creator/owner IDs; created/updated timestamps; visibility/permission scope; deletion/anonymisation state; audit attribution; schema version and relevant provenance/licence. Sensitive registrations and owner claims remain separately controlled and never exposed via public identifiers.

Authorisation principle: deny by default; policy enforcement in query/services/storage delivery and preview/index subsystems. Cached pages, feeds and notifications cannot bypass access checks. Every role/visibility change invalidates affected cached/indexed content. Cross-module references may resolve to an unavailable placeholder without disclosing hidden records.

## 9. Delivery roadmap and dependencies
### 9.1 Phase 0: Foundation and proof
Repository setup, engineering conventions, CI, issue/PR templates, threat model, ADR structure, NodeBB/database/hosting spikes, baseline design tokens, deployment skeleton, backup prototype, permission test harness. Phase 0 precedes heavy feature development.
### 9.2 Phase 1: Community foundation and private beta
- **Milestone M1:** secure accounts, roles, moderation base, staff MFA and email.
- **Milestone M2:** forum categories/discussions/questions, responsive theme, navigation and accessibility.
- **Milestone M3:** manual garages, vehicle data, per-component privacy and media handling.
- **Milestone M4:** build journals, modifications, cross-links, social interactions and search.
- **Milestone M5:** notifications, administration, monitoring, backups, privacy/export/deletion and SEO.
- **Milestone M6:** private founding-member testing, security/accessibility/performance fixes, validated recovery and founder-approved public beta.

Milestones are dependency-aware and flexible, not calendar promises. Implementation may be reordered where supported interfaces permit it. Some selected social or advanced garage functionality may need slicing into minimal beta behaviour and subsequent Phase 2 refinement; any deferral must be explicit and approved, not silently omitted.
### 9.3 Phase 2: Community expansion
Club membership and permissions; public/private/invite-only forums; organiser-controlled events, map/calendar and RSVP lifecycle; safe real-time messaging; integrated media discovery; photographer tagging; optional licensed 3D and capacity-tested native short-video features.
### 9.4 Phase 3: Business ecosystem
Business profiles and directory; listing claim and verification; quotes/enquiries; reviews and disputes; clearly labelled promotions/advertising; commercial policies, payment integration if later approved, anti-fraud controls and commercial metrics.

## 10. Engineering workflow and definition of done
Ownership: Founder is product owner and technical lead. AI-assisted coding is permitted, but every change receives human-controlled review and approval. No direct production changes from unreviewed generated code.

Issue structure: Epic > Feature > small, independently testable task. Every issue identifies problem/context, scope and exclusions, dependencies, acceptance criteria, security/privacy/accessibility impacts and relevant tests. Work uses feature branches and focused GitHub PRs.

Pull request minimum: linked issue; description and screenshots where UI changes; tests and results; data migrations; risk/rollback; updated documentation; notable privacy/permission effects; no unrelated file churn. CI must run type checks, lint, unit/integration tests and relevant e2e/security/accessibility tests. Approval required before merge; production deployment approval separate.

Upgrade governance: Pin NodeBB/plugin versions. Monitor upstream security advisories. Validate updates in staging with regression and permission tests, backups and rollback rehearsal; expedited but tested handling of urgent security fixes. No automatic production upgrades.

Definition of done: Implementation meets issue acceptance criteria; automated tests pass; accessibility and privacy/security relevant checks pass; observability/error handling adequate; no secrets in commits; documentation/data contracts updated; reviewed PR approved; deployment status recorded. A delivered feature is not “done” simply because its happy-path screen renders.

## 11. Public-beta release gates
All gates are mandatory unless a specific exception is documented as noncritical and explicitly approved by the founder. No unresolved critical/high-risk vulnerabilities, uncontrolled privacy exposures or possible data-loss defects.
**Gate — required evidence**
- **G1** Feature coverage Phase 1 user journeys and acceptance suites pass, including non-owner path and manual vehicle creation
- **G2** Security Threat review, RBAC/IDOR regressions, privileged MFA, upload hardening, critical/high findings resolved
- **G3** Privacy/safety Minor protections, privacy settings, reports/appeals, deletion/retention, required assessments and UK legal review
- **G4** Accessibility WCAG 2.2 AA target validated with automated and manual checks across both themes and mobile
- **G5** Performance CWV/search targets and 50-concurrent-user scenario measured on candidate production hosting
- **G6** Resilience Encrypted off-server backups, successful restoration, monitored failures and rehearsed rollback
- **G7** Operations Uptime/error/certificate/resource/security monitoring, incident runbook, email delivery tests
- **G8** Community validation Founding members publish real discussions/builds; severe usability findings addressed
- **G9** Identity and launch Public name/domain clearance and configuration, published policies and member support routes
- **G10** Founder approval Final release decision and approved exceptions recorded

## 12. Recruitment, content seeding and growth
Recruit a founding group of active car and motorcycle enthusiasts, build-journal contributors and technically useful answerers; develop partnerships with suitable automotive creators and clubs. Grow invitations gradually; do not optimise for empty registrations. Promote useful content through channels that permit it, with respectful rules-based community participation. Public organic discovery relies on accessible, indexable public threads, garages, builds and category pages; no restricted content in SEO metadata, sitemap, social previews or media URLs.
## 13. Risk register and decision log
**Risk Exposure Mitigation / owner decision**
- **NodeBB cannot meet custom model/permission needs** — `High` — Mandatory SPIKE-01 and SPIKE-03; alternative foundation review if fail
- **PostgreSQL incompatibility** — `High` — SPIKE-02, version-specific verification; supported database fallback
- **Free compute unavailable/reclaimed or insufficient** — `High` — SPIKE-04; paid VPS fallback within £25/month; restore-ready off-server backup
- **Storage and media growth** — `High` — Strict beta limits, optimised images, quotas, capacity alerts, storage adapter
- **Member/child privacy leak** — `Critical` — Deny-by-default RBAC, testing across search/media/previews, minor defaults, legal assessment
- **Unlicensed manufacturer/3D assets** — `High` — Provenance register, permission gate, photo fallback
- **DVLA API not approved** — `Medium` — Manual entry must be complete; external lookup optional
- **AI-assisted code harms maintainability** — `High` — Small PRs, tests, review, ADRs and pinned versions
- **Complex scope delays launch** — `High` — Phased milestones, feature flags, release-gate focus, approved deferrals
- **Email deliverability/third-party outages** — `Medium` — Replaceable provider, monitoring and retry/recovery plan
- **User-generated harm, complaints and illegal content** — `High` — Safety-by-design, moderation cases, child safety assessment, lawful processes
- **Data erasure conflicts with backups and threads** — `High` — Legal review, genuine anonymisation, deletion replay, retention controls
- **Brand conflict** — `Medium` — Neutral internal name, clearance before public beta

## 14. Open decisions requiring later evidence or approval
- **15.** Final public brand/domain/trademark clearance: explicitly deferred until before public beta.
- **16.** Selected NodeBB version, exact database and plugin/extension path: feasibility spikes required; no assumption of compatibility.
- **17.** Production hosting provider and live monthly bill: candidate Oracle Always Free with self-managed VPS fallback; benchmark and price-check before purchase.
- **18.** Official DVLA access, permitted fields and legal terms: optional feature; manual entry always required.
- **19.** Licensed reference 3D coverage and performance: no release dependency; later experiment.
- **20.** Native short-video limits and processing stack: disabled until capacity and legal/safety testing.
- **21.** Exact provider choices for email, monitoring, storage and analytics: prefer cheap/free and replaceable; review DPAs and transfer risks.
- **22.** Exact legal retention periods, age-assurance technique, risk assessments and policies: require UK legal/safety review.
- **23.** Final mobile bottom-nav tabs and detailed responsive designs: usability testing within approved IA.
- **24.** Phase 3 commercial pricing, billing processor, commercial release criteria: defer until business module discovery/implementation.
- **25.** Benchmark-based capacity and quota revisions: amend with evidence and founder approval.

### 14.1 Traceability and next implementation artefacts
Produce the following from this PRD, without redefining approved product scope: (1) architecture decision record template and spike backlog; (2) roles/permissions matrix; (3) entity relationship/data contract diagrams; (4) phase-based epic/feature/issue backlog; (5) acceptance and end-to-end test matrix; (6) threat and privacy impact assessments; (7) operations/runbooks and release checklist; (8) UI component library and responsive page specifications; (9) legal policy review checklist.

All requirements prefixed FR-_ and all gate IDs G_ must be traceable to issues and tests. Any material change in scope, permission model, platform selection, legal risk or monthly cost needs a documented decision and founder approval. Superseded assumptions should be preserved in the change log rather than silently rewritten.

## Document control
v1.0 — 28 October 2026: Consolidated product discovery. Proposed product scope and engineering requirements; conditional technologies and legal matters explicitly noted. No external provider availability, regulatory compliance or feasibility result is asserted as verified.
