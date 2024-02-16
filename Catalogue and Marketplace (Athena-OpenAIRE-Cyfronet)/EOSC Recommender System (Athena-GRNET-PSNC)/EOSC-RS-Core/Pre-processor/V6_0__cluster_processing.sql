CREATE SCHEMA IF NOT EXISTS processing;

CREATE TABLE IF NOT EXISTS processing.command (command_id BIGSERIAL PRIMARY KEY, timestamp BIGINT NOT NULL, status VARCHAR(64), type VARCHAR(64), run_manually BOOLEAN,
    java_object BYTEA NOT NULL, command_successor_id BIGSERIAL REFERENCES processing.command(command_id));