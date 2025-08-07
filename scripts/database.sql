-- Connect to the default postgres database first
-- You cannot drop the database you're currently connected to

-- Step 1: Drop and recreate the database
DO
$$
BEGIN
    IF EXISTS (
        SELECT FROM pg_database WHERE datname = 'Data Warehouse'
    ) THEN
        -- Force disconnect all users before dropping
        REVOKE CONNECT ON DATABASE Data Warehouse FROM PUBLIC;
        PERFORM pg_terminate_backend(pid)
        FROM pg_stat_activity
        WHERE datname = 'Data Warehouse';
        
        EXECUTE 'DROP DATABASE Data Warehouse';
    END IF;
END
$$;

-- Step 2: Create the database
CREATE DATABASE Data Warehouse;

-- Step 3: After this, you must connect to `Data Warehouse` before running the next part
-- For example in psql:
-- \c Data Warehouse

-- Step 4: Create schemas
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
