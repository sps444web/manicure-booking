# Manicure Booking

Production-oriented MVP for a manicure salon booking service.

## Stack
- PHP 8.1+
- MySQL 8+
- Semantic HTML, CSS and vanilla JavaScript
- n8n webhook integration prepared for notifications

## GitHub Pages preview
The static frontend is published from `docs/`. Open the repository's GitHub Pages URL after enabling Pages with **Deploy from a branch**, branch `main`, folder `/docs`.

The PHP API still requires a PHP/MySQL server; GitHub Pages can serve the HTML/CSS/JS preview but cannot execute PHP or connect to MySQL.

## Run locally
1. Copy `env.example` to `.env` and set database values.
2. Import `database/schema.sql` into MySQL.
3. Configure the web server document root to `docs/`.
4. Ensure PHP can read the project `.env` and enable PDO MySQL.
5. Open `/` and use the registration form.

The project contains no real business identity, credentials, addresses or reviews. Replace neutral copy before launch.
