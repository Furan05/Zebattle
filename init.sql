-- Configuration initiale pour MySQL/MariaDB
CREATE DATABASE IF NOT EXISTS groudonbattle_development;
CREATE DATABASE IF NOT EXISTS groudonbattle_test;
CREATE DATABASE IF NOT EXISTS groudonbattle_production;

-- Accorder tous les privilèges à l'utilisateur rails_user
GRANT ALL PRIVILEGES ON groudonbattle_development.* TO 'rails_user'@'%';
GRANT ALL PRIVILEGES ON groudonbattle_test.* TO 'rails_user'@'%';
GRANT ALL PRIVILEGES ON groudonbattle_production.* TO 'rails_user'@'%';

-- Appliquer les changements
FLUSH PRIVILEGES;
