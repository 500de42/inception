CREATE DATABASE wordpress;
CREATE USER 'kcharbon'@'localhost' IDENTIFIED BY 'test42';
CREATE USER 'suppleant'@'localhost' IDENTIFIED BY 'suppleanttest42';
GRANT ALL PRIVILEGES ON *.* TO 'kcharbon'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;