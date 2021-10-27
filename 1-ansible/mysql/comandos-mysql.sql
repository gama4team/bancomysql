ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';

# liberando user root para conectar no localhost(127.0.0.1)
CREATE USER 'root'@'127.0.0.1' IDENTIFIED WITH mysql_native_password BY 'mudando';
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'mudando'; 
GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1';

# liberando user root para conectar com qualquer IP
CREATE USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'mudando';
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'mudando'; 
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';


FLUSH PRIVILEGES;
