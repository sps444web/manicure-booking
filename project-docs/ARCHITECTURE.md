# Architecture

The MVP uses a small PHP front controller under `docs/api/index.php` and PDO/MySQL. The browser only calls the public API; credentials and n8n configuration remain server-side.

Layers:
- `docs/`: document root, HTML, CSS, JavaScript and API entrypoint
- `database/`: schema and seed data
- `src/`: reserved for extracted domain services as the application grows
- `tests/`: API and domain test fixtures
- `.claude/skills/`: project quality rules inherited from the template

Booking flow: service -> master -> date -> time -> customer -> confirmation. Availability is recalculated from weekly hours, days off, service duration and active bookings. Submission performs the same check in a transaction.
