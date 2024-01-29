CREATE DATABASE IF NOT EXISTS app;
USE app;
CREATE TABLE IF NOT EXISTS my_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);
INSERT INTO my_table (name, email) VALUES ('John Doe', 'john@example.com');
INSERT INTO my_table (name, email) VALUES ('Jane Smith', 'jane@example.com');
CREATE DATABASE IF NOT EXISTS my_database;
CREATE USER 'alex'@'0.0.0.0' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON app.* TO 'alex'@'%';
FLUSH PRIVILEGES;

