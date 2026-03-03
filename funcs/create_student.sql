CREATE OR REPLACE FUNCTION create_student(
    p_first_name VARCHAR,
    p_last_name VARCHAR,
    p_email VARCHAR,
    p_cpf VARCHAR,
    p_phone_number VARCHAR,
    p_password VARCHAR
) RETURNS INTEGER AS $$
DECLARE
    new_person_id INTEGER;
    new_enrollment_id INTEGER;
    new_student_id INTEGER;
BEGIN
    new_person_id := create_person(
        p_first_name,
        p_last_name,
        p_email,
        p_cpf,
        p_phone_number,
        p_password,
        1  -- STUDENT role
    );

    INSERT INTO enrollment (
        enrollment_status
    ) VALUES (
        1
    ) RETURNING enrollment_id INTO new_enrollment_id;

    INSERT INTO student (
        person_id,
        enrollment_id
    ) VALUES (
        new_person_id,
        new_enrollment_id
    ) RETURNING student_id INTO new_student_id;

    RETURN new_student_id;
END;
$$ LANGUAGE plpgsql;