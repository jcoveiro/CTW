-- Create EngineType table
CREATE TABLE EngineType (
    id SERIAL PRIMARY KEY,
    type VARCHAR(50) UNIQUE NOT NULL
);

-- Populate EngineType table with values
INSERT INTO EngineType (type) VALUES
('PETROL'),
('DIESEL'),
('ELECTRIC'),
('HYBRID');

-- Create T_CAR table
CREATE TABLE T_CAR (
    ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    BRAND VARCHAR(50) NOT NULL,
    MODEL VARCHAR(50) NOT NULL,
    ENGINE_TYPE VARCHAR(50) NOT NULL,  -- This could reference EngineType if desired
    CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CREATED_BY VARCHAR(50)
);

-- Create T_USER table (if you want to track users creating cars)
CREATE TABLE T_USER (
    ID SERIAL PRIMARY KEY,
    USERNAME VARCHAR(50) UNIQUE NOT NULL,
    PASSWORD VARCHAR(100) NOT NULL,
    EMAIL VARCHAR(100) UNIQUE NOT NULL,
    CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Populate T_USER table with sample users
INSERT INTO T_USER (USERNAME, PASSWORD, EMAIL) VALUES
('admin', 'admin_pass', 'admin@example.com'),
('user1', 'user1_pass', 'user1@example.com');

-- Create T_SERVICE_HISTORY table (optional, for tracking service records)
CREATE TABLE T_SERVICE_HISTORY (
    ID SERIAL PRIMARY KEY,
    CAR_ID UUID REFERENCES T_CAR(ID),
    SERVICE_DATE TIMESTAMP NOT NULL,
    DESCRIPTION TEXT,
    COST DECIMAL(10, 2)
);

-- Populate T_CAR table with sample car data
INSERT INTO T_CAR (BRAND, MODEL, ENGINE_TYPE, CREATED_BY) VALUES
('Toyota', 'Camry', 'PETROL', 'admin'),
('Tesla', 'Model S', 'ELECTRIC', 'admin'),
('Ford', 'F-150', 'DIESEL', 'admin'),
('Honda', 'Accord', 'HYBRID', 'admin'),
('Chevrolet', 'Malibu', 'PETROL', 'user1'),
('Nissan', 'Leaf', 'ELECTRIC', 'user1');

-- Populate T_SERVICE_HISTORY table with sample service records
INSERT INTO T_SERVICE_HISTORY (CAR_ID, SERVICE_DATE, DESCRIPTION, COST) VALUES
((SELECT ID FROM T_CAR WHERE MODEL = 'Camry'), '2023-01-15 10:00:00', 'Oil Change', 29.99),
((SELECT ID FROM T_CAR WHERE MODEL = 'Model S'), '2023-02-20 09:30:00', 'Battery Check', 0.00),
((SELECT ID FROM T_CAR WHERE MODEL = 'F-150'), '2023-03-10 11:15:00', 'Tire Rotation', 59.99);
