# API

Все ответы API имеют формат `{ ok, data, error }`. API требует PHP и MySQL на отдельном хостинге.

## Публичные методы
- `GET /api/index.php?action=services` — список услуг.
- `GET /api/index.php?action=masters&service_id=1` — мастера выбранной услуги.
- `GET /api/index.php?action=availability&master_id=1&service_id=1&date=YYYY-MM-DD` — доступные интервалы.
- `POST /api/index.php?action=register` — имя, фамилия, email, пароль.
- `POST /api/index.php?action=login` — email и пароль.
- `POST /api/index.php?action=logout` — завершение сессии.
- `POST /api/index.php?action=booking.create` — услуга, мастер, начало и комментарий.
- `GET /api/index.php?action=bookings.mine` — записи текущего пользователя.
- `POST /api/index.php?action=booking.cancel` — отмена своей записи.

## Администратор
Для административных методов нужен bearer-токен администратора:
- `GET /api/index.php?action=admin.bookings`

Пароли и токены никогда не возвращаются API.