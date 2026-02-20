-- Insert a new person with a hashed password
CREATE OR REPLACE FUNCTION create_person(
    p_first_name VARCHAR,
    p_last_name VARCHAR,
    p_email VARCHAR,
    p_cpf VARCHAR,
    p_phone_number VARCHAR,
    p_password VARCHAR,
    p_person_role_id INTEGER
) RETURNS INTEGER AS $$
DECLARE
    new_person_id INTEGER;
BEGIN
    INSERT INTO person (
        first_name,
        last_name,
        email,
        cpf,
        phone_number,
        password_hash,
        person_role_id
    ) VALUES (
        p_first_name,
        p_last_name,
        p_email,
        p_cpf,
        p_phone_number,
        crypt(p_password, gen_salt('bf')), -- using bcrypt for hashing
        p_person_role_id
    ) RETURNING person_id INTO new_person_id;
    RETURN new_person_id;
END;
$$ LANGUAGE plpgsql;