# API

All responses use `{ ok, data, error }`.

## Public
- `GET /api/index.php?action=services`
- `GET /api/index.php?action=masters&service_id=1`
- `GET /api/index.php?action=availability&master_id=1&service_id=1&date=YYYY-MM-DD`
- `POST /api/index.php?action=register` — first name, last name, email, password
- `POST /api/index.php?action=login` — email, password
- `POST /api/index.php?action=logout`
- `POST /api/index.php?action=booking.create` — service_id, master_id, starts_at, note
- `GET /api/index.php?action=bookings.mine`
- `POST /api/index.php?action=booking.cancel` — booking_id

## Admin
Admin bearer token required in `Authorization: Bearer ...`.
- `GET /api/index.php?action=admin.bookings`
- `POST /api/index.php?action=admin.booking.status`

Passwords and tokens are never returned by the API.
