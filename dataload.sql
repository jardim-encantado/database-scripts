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
    ('OCCURRENCE'),
    ('OTHER');

-------------------------------------------------------------------------------------------
-- Classroom Groups

INSERT INTO
    classroom_group (name, series, classroom_id, teacher_id)
VALUES ('Turma A', '1º Ano', 1, 1),
    ('Turma B', '2º Ano', 2, 1),
    ('Turma C', '3º Ano', 3, 3),
    ('Turma D', '4º Ano', 4, 4);

-------------------------------------------------------------------------------------------
-- Guardians

DO $$
DECLARE
    pid INTEGER;
BEGIN
    pid := create_person(
        'Ana',
        'Silva Costa',
        'ana.costa@gmail.com',
        '12345678910',
        '(11) 98888-1111',
        'senha',
        3
    );
    INSERT INTO guardian (person_id) VALUES (pid);

    pid := create_person(
        'Marcos',
        'Silva Costa',
        'marcos.costa@gmail.com',
        '12345678911',
        '(11) 98888-2222',
        'senha',
        3
    );
    INSERT INTO guardian (person_id) VALUES (pid);
END $$;

-------------------------------------------------------------------------------------------
-- Students

DO $$
BEGIN
    PERFORM create_student(
        'Lucas',
        'Silva Costa',
        'lucas.costa@jardimencantado.com',
        '12345678912',
        '(11) 97777-1111',
        'senha'
    );

    PERFORM create_student(
        'Mariana',
        'Silva Costa',
        'mariana.costa@jardimencantado.com',
        '12345678913',
        '(11) 97777-2222',
        'senha'
    );
END $$;

-------------------------------------------------------------------------------------------
-- Student Guardian

INSERT INTO
    student_guardian (student_id, guardian_id)
VALUES (1, 1),
    (1, 2),
    (2, 1),
    (2, 2);

-------------------------------------------------------------------------------------------
-- Address

INSERT INTO
    address (street, street_number, cep, complement, city, state, person_id)
VALUES ('Rua das Flores', '123', '01010-000', 'Apto 12', 'São Paulo', 'SP', 1),
    ('Rua das Flores', '123', '01010-000', NULL, 'São Paulo', 'SP', 2),
    ('Rua das Flores', '123', '01010-000', NULL, 'São Paulo', 'SP', 3),
    ('Rua das Flores', '123', '01010-000', NULL, 'São Paulo', 'SP', 4);

-------------------------------------------------------------------------------------------
-- Enrollments

UPDATE enrollment AS e
SET enrollment_status = 2, -- enrolled
    enrollment_date = CURRENT_TIMESTAMP
FROM student AS s
WHERE s.enrollment_id = e.enrollment_id
    AND s.student_id = 1;

UPDATE enrollment AS e
SET enrollment_status = 1 -- not yet enrolled no enrollment date
FROM student AS s
WHERE s.enrollment_id = e.enrollment_id
    AND s.student_id = 2;

-------------------------------------------------------------------------------------------
-- Grading

INSERT INTO
    grading (student_id, subject_id, grade, observations, given_by_teacher_id)
VALUES (1, 1, 8.5, 'Aluno demonstrou bom desempenho', 1),
    (1, 2, 7.0, 'Aluno precisa melhorar na compreensão', 1),
    (2, 1, 9.2, 'Aluno se destacou em todas as atividades', 1),
    (2, 4, 8.0, 'Aluno apresentou desempenho satisfatório', 3);

-------------------------------------------------------------------------------------------
-- School Events

INSERT INTO
    school_event (
    name,
    description,
    event_date,
    created_by,
    event_type_id
)
VALUES ('Prova de Matemática', 'Avaliação do 1º bimestre', '2026-04-10 09:00:00', 1, 1),
    ('Feriado - Tiradentes', 'Não haverá aula', '2026-04-21 00:00:00', 1, 2);

