-- Data loading script for Jardim Encantado database

-- Roles
INSERT INTO
    person_role (name)
VALUES ('STUDENT'),
    ('TEACHER'),
    ('GUARDIAN'),
    ('ADMIN');

-------------------------------------------------------------------------------------------
-- Administrator

DO $$
DECLARE
    pid INTEGER;
BEGIN
    -- Create admin person
    pid := create_person(
        'Root',
        'Eterno da Conceição Jardim',
        'admin@jardimencantado.com',
        '12345678900',
        '(11) 99999-9999',
        'senha',
        4
    );

    INSERT INTO admin (person_id) VALUES (pid);
END $$;

-------------------------------------------------------------------------------------------
-- Subjects

INSERT INTO
    study_subject (name)
VALUES ('Português'), -- 1
    ('Matemática'), -- 2
    ('Ciências'), -- 3
    ('História'), -- 4
    ('Geografia'), -- 5
    ('Artes'), -- 6
    ('Inglês'), -- 7
    ('Espanhol'), -- 8
    ('Educação Física'), -- 9
    ('Informática'), -- 10
    ('Música') -- 11
;

-------------------------------------------------------------------------------------------
-- Teachers

DO $$
DECLARE
    pid INTEGER; -- Person ID
    tid INTEGER; -- Teacher ID
BEGIN
    -- 1. Raissa Marconato (Early Elementary / Polivalente)
    pid := create_person('Raissa', 'Marconato', 'raissa.marconato@jardimencantado.com', '12345678902', '(11) 99999-9997', 'senha', 2);
    INSERT INTO teacher (person_id) VALUES (pid) RETURNING teacher_id INTO tid;
    INSERT INTO teacher_subject (teacher_id, subject_id) VALUES (tid, 1), (tid, 2), (tid, 3), (tid, 4), (tid, 5), (tid, 6);

    -- 2. Carlos Santi (Tecnologia)
    pid := create_person('Carlos', 'Eduardo Santi', 'carlos.santi@jardimencantado.com', '12345678903', '(11) 99999-9998', 'senha', 2);
    INSERT INTO teacher (person_id) VALUES (pid) RETURNING teacher_id INTO tid;
    INSERT INTO teacher_subject (teacher_id, subject_id) VALUES (tid, 10);

    -- 3. Fernanda Santos (Humanas)
    pid := create_person('Fernanda', 'Yoshimoto Santos Dias', 'fernanda.yoshimoto@jardimencantado.com', '12345678904', '(11) 99999-9996', 'senha', 2);
    INSERT INTO teacher (person_id) VALUES (pid) RETURNING teacher_id INTO tid;
    INSERT INTO teacher_subject (teacher_id, subject_id) VALUES (tid, 4), (tid, 5);

    -- 4. Mariana Gómez (Línguas)
    pid := create_person('Mariana', 'Gómez Morais Arrudão', 'mariana.gomez@jardimencantado.com', '12345678905', '(11) 99999-9995', 'senha', 2);
    INSERT INTO teacher (person_id) VALUES (pid) RETURNING teacher_id INTO tid;
    INSERT INTO teacher_subject (teacher_id, subject_id) VALUES (tid, 7), (tid, 8);

    -- 5. Ricardo Oliveira (Educação Física)
    pid := create_person('Ricardo', 'Oliveira Prado Júnior', 'ricardo.junior@jardimencantado.com', '12345678906', '(11) 99999-9994', 'senha', 2);
    INSERT INTO teacher (person_id) VALUES (pid) RETURNING teacher_id INTO tid;
    INSERT INTO teacher_subject (teacher_id, subject_id) VALUES (tid, 9);

    -- 6. Beatriz Lira (Arte e Música)
    pid := create_person('Beatriz', 'Jacques Barbosa Telem', 'beatriz.telem@jardimencantado.com', '12345678907', '(11) 99999-9993', 'senha', 2);
    INSERT INTO teacher (person_id) VALUES (pid) RETURNING teacher_id INTO tid;
    INSERT INTO teacher_subject (teacher_id, subject_id) VALUES (tid, 6), (tid, 11);

END $$;
-------------------------------------------------------------------------------------------
-- Classrooms

INSERT INTO
    classroom (identifier)
VALUES ('TER-001'),
    ('TER-002'),
    ('TER-003'),
    ('TER-004'),
    ('TER-005'),
    ('TER-006'),
    ('PRI-001'),
    ('PRI-002'),
    ('PRI-003'),
    ('PRI-004'),
    ('PRI-005'),
    ('PRI-006'),
    ('SEG-001'),
    ('SEG-002'),
    ('SEG-003'),
    ('SEG-004'),
    ('SEG-005'),
    ('SEG-006');

----------------------------------------------------------------------------------------------
-- School Event Types
INSERT INTO
    school_event_type (name)
VALUES ('EXAM'),
    ('HOLIDAY'),
    ('STUDENT CYCLE'),
    ('OTHER');