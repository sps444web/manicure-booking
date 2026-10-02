# Database

The schema is designed around interval bookings. A booking stores `starts_at` and `ends_at`; availability is checked for overlapping active bookings inside a transaction.

## Core tables
- `users`: customers and staff roles
- `sessions`: hashed bearer sessions
- `services`: price and duration
- `masters`: staff profiles
- `master_services`: services a master can perform
- `working_hours`: weekly schedule
- `days_off`: exceptions and closures
- `bookings`: appointment intervals and statuses
- `booking_events`: outbound notification event log

Import `schema.sql` for the initial MVP schema.
