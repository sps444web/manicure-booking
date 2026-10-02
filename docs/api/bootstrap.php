<?php
declare(strict_types=1);

function env_value(string $key, string $default = ''): string {
    static $env;
    if ($env === null) {
        $env = [];
        $path = dirname(__DIR__, 2) . '/.env';
        if (is_readable($path)) {
            foreach (file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $line) {
                if (str_starts_with(trim($line), '#') || !str_contains($line, '=')) continue;
                [$name, $value] = explode('=', $line, 2);
                $env[trim($name)] = trim($value, " \t\"'");
            }
        }
    }
    return $env[$key] ?? $_ENV[$key] ?? getenv($key) ?: $default;
}

function db(): PDO {
    static $pdo;
    if ($pdo instanceof PDO) return $pdo;
    $pdo = new PDO(
        'mysql:host=' . env_value('DB_HOST', '127.0.0.1') . ';port=' . env_value('DB_PORT', '3306') . ';dbname=' . env_value('DB_NAME') . ';charset=utf8mb4',
        env_value('DB_USER'),
        env_value('DB_PASSWORD'),
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC]
    );
    return $pdo;
}
