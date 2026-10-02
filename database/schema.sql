CREATE TABLE users (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(190) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  role ENUM('user','staff','admin') NOT NULL DEFAULT 'user',
  active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sessions (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  token_hash CHAR(64) NOT NULL UNIQUE,
  expires_at DATETIME NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX (user_id), INDEX (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE services (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(190) NOT NULL,
  description TEXT NULL,
  price DECIMAL(10,2) NOT NULL,
  duration_min SMALLINT UNSIGNED NOT NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE masters (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(190) NOT NULL,
  specialty VARCHAR(190) NOT NULL DEFAULT '',
  bio TEXT NULL,
  active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE master_services (
  master_id BIGINT UNSIGNED NOT NULL,
  service_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (master_id, service_id),
  FOREIGN KEY (master_id) REFERENCES masters(id) ON DELETE CASCADE,
  FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE working_hours (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  master_id BIGINT UNSIGNED NOT NULL,
  weekday TINYINT UNSIGNED NOT NULL,
  starts TIME NOT NULL,
  ends TIME NOT NULL,
  UNIQUE KEY uq_master_weekday (master_id, weekday),
  FOREIGN KEY (master_id) REFERENCES masters(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE days_off (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  master_id BIGINT UNSIGNED NOT NULL,
  day DATE NOT NULL,
  reason VARCHAR(190) NULL,
  UNIQUE KEY uq_master_day (master_id, day),
  FOREIGN KEY (master_id) REFERENCES masters(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE bookings (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  master_id BIGINT UNSIGNED NOT NULL,
  service_id BIGINT UNSIGNED NOT NULL,
  starts_at DATETIME NOT NULL,
  ends_at DATETIME NOT NULL,
  status ENUM('pending','confirmed','completed','cancelled') NOT NULL DEFAULT 'pending',
  note TEXT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (master_id) REFERENCES masters(id),
  FOREIGN KEY (service_id) REFERENCES services(id),
  INDEX idx_booking_master_time (master_id, starts_at, ends_at),
  INDEX idx_booking_user (user_id), INDEX idx_booking_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE booking_events (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  booking_id BIGINT UNSIGNED NOT NULL,
  event_type VARCHAR(80) NOT NULL,
  delivered_at DATETIME NULL,
  payload JSON NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO services (name, description, price, duration_min) VALUES
('Маникюр', 'Уход за ногтями и кутикулой.', 0, 60),
('Маникюр с покрытием', 'Маникюр и покрытие выбранным материалом.', 0, 90);
INSERT INTO masters (name, specialty) VALUES ('Мастер салона', 'Маникюр');
INSERT INTO master_services (master_id, service_id) SELECT m.id, s.id FROM masters m CROSS JOIN services s WHERE m.name = 'Мастер салона';
INSERT INTO working_hours (master_id, weekday, starts, ends) SELECT id, 1, '10:00', '19:00' FROM masters WHERE name = 'Мастер салона';
INSERT INTO working_hours (master_id, weekday, starts, ends) SELECT id, 2, '10:00', '19:00' FROM masters WHERE name = 'Мастер салона';
INSERT INTO working_hours (master_id, weekday, starts, ends) SELECT id, 3, '10:00', '19:00' FROM masters WHERE name = 'Мастер салона';
INSERT INTO working_hours (master_id, weekday, starts, ends) SELECT id, 4, '10:00', '19:00' FROM masters WHERE name = 'Мастер салона';
INSERT INTO working_hours (master_id, weekday, starts, ends) SELECT id, 5, '10:00', '19:00' FROM masters WHERE name = 'Мастер салона';
INSERT INTO working_hours (master_id, weekday, starts, ends) SELECT id, 6, '10:00', '19:00' FROM masters WHERE name = 'Мастер салона';
