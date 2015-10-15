-- Create the user and grant privileges
CREATE USER 'my_app'@'localhost' IDENTIFIED BY 'secret';
GRANT
    INSERT, SELECT, UPDATE, DELETE
    , SHOW VIEW
ON
    my_app.*
TO
    'my_app'@'localhost';

FLUSH PRIVILEGES;


CREATE DATABASE my_app;
