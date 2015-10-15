DROP DATABASE IF EXISTS my_app;
REVOKE ALL PRIVILEGES ON my_app.* FROM 'my_app'@'localhost';
DROP USER 'my_app'@'localhost';
FLUSH PRIVILEGES;
