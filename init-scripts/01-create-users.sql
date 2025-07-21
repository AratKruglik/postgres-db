-- Створення користувача
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'davinci_user') THEN
        CREATE ROLE davinci_user WITH LOGIN PASSWORD 'your_secure_password_here';
    END IF;
END
$$;

-- Надання прав
GRANT ALL PRIVILEGES ON DATABASE davinci_projects TO davinci_user;
GRANT ALL ON SCHEMA public TO davinci_user;

-- Створення розширень для статистики
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- Налаштування для кращої роботи
ALTER DATABASE davinci_projects SET timezone TO 'Europe/Kiev';
