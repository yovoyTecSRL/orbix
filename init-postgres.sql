-- Inicialización de PostgreSQL para Odoo
-- Este script se ejecuta automáticamente al crear el contenedor

-- Crear la base de datos si no existe
SELECT 'CREATE DATABASE odoo' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'odoo')\gexec

-- Crear usuario si no existe
DO
$do$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_catalog.pg_user WHERE usename = 'odoo') THEN
      CREATE USER odoo WITH PASSWORD 'odoo_password_2025';
   END IF;
END
$do$;

-- Conceder permisos
GRANT ALL PRIVILEGES ON DATABASE odoo TO odoo;
ALTER USER odoo CREATEDB;

-- Configuraciones adicionales para Odoo
ALTER DATABASE odoo SET timezone = 'America/Bogota';
