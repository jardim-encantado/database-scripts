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
        'admin@jardim.com',
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
    pid := create_person('Raissa', 'Marconato', 'raissa.marconato@jardim.com', '12345678902', '(11) 99999-9997', 'senha', 2);
    INSERT INTO teacher (person_id) VALUES (pid) RETURNING teacher_id INTO tid;
    INSERT INTO teacher_subject (teacher_id, subject_id) VALUES (tid, 1), (tid, 2), (tid, 3), (tid, 4), (tid, 5), (tid, 6);

    -- 2. Carlos Santi (Tecnologia)
    pid := create_person('Carlos', 'Santi', 'carlos.santi@jardim.com', '12345678903', '(11) 99999-9998', 'senha', 2);
    INSERT INTO teacher (person_id) VALUES (pid) RETURNING teacher_id INTO tid;
    INSERT INTO teacher_subject (teacher_id, subject_id) VALUES (tid, 10);

    -- 3. Fernanda Santos (Humanas)
    pid := create_person('Fernanda', 'Yoshimoto', 'fernanda.yoshimoto@jardim.com', '12345678904', '(11) 99999-9996', 'senha', 2);
    INSERT INTO teacher (person_id) VALUES (pid) RETURNING teacher_id INTO tid;
    INSERT INTO teacher_subject (teacher_id, subject_id) VALUES (tid, 4), (tid, 5);

    -- 4. Mariana Gómez (Línguas)
    pid := create_person('Mariana', 'Gómez Arrudão', 'mariana.gomez@jardim.com', '12345678905', '(11) 99999-9995', 'senha', 2);
    INSERT INTO teacher (person_id) VALUES (pid) RETURNING teacher_id INTO tid;
    INSERT INTO teacher_subject (teacher_id, subject_id) VALUES (tid, 7), (tid, 8);

    -- 5. Ricardo Oliveira (Educação Física)
    pid := create_person('Ricardo', 'Oliveira Júnior', 'ricardo.junior@jardim.com', '12345678906', '(11) 99999-9994', 'senha', 2);
    INSERT INTO teacher (person_id) VALUES (pid) RETURNING teacher_id INTO tid;
    INSERT INTO teacher_subject (teacher_id, subject_id) VALUES (tid, 9);

    -- 6. Beatriz Lira (Arte e Música)
    pid := create_person('Beatriz', 'Jacques Telem', 'beatriz.telem@jardim.com', '12345678907', '(11) 99999-9993', 'senha', 2);
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
        'lucas.costa@jardim.com',
        '12345678912',
        '(11) 97777-1111',
        'senha'
    );

    PERFORM create_student(
        'Mariana',
        'Silva Costa',
        'mariana.costa@jardim.com',
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
    ('Rua das Flores', '123', '01010-000', NULL, 'São Paulo', 'SP', 4),
    ('Rua das Flores', '125', '01010-000', NULL, 'São Paulo', 'SP', 5),
    ('Rua das Flores', '127', '01010-000', NULL, 'São Paulo', 'SP', 6),
    ('Rua das Flores', '129', '01010-000', NULL, 'São Paulo', 'SP', 7),
    ('Rua das Flores', '131', '01010-000', NULL, 'São Paulo', 'SP', 8),
    ('Rua das Flores', '133', '01010-000', NULL, 'São Paulo', 'SP', 9),
    ('Rua das Flores', '135', '01010-000', NULL, 'São Paulo', 'SP', 10),
    ('Rua das Flores', '137', '01010-000', NULL, 'São Paulo', 'SP', 11);

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

----------------------------------------------------------------------------------------------
-- School Event Types
INSERT INTO
    school_event_type (name)
VALUES ('OUTROS'),
    ('EXAME'),
    ('FERIADO'),
    ('ANO LETIVO'),
    ('OCORRÊNCIA'),
    ('REUNIÃO'),
    ('ATIVIDADE EXTRACURRICULAR'),
    ('COMUNICADO');

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
VALUES ('Prova de Matemática', 'Avaliação do 1º bimestre', '2026-04-10 09:00:00', 1, 2),
    ('Feriado - Tiradentes', 'Não haverá aula', '2026-04-21 00:00:00', 1, 3),
    ('Reunião de Pais', 'Encontro para discutir o progresso dos alunos', '2026-05-15 18:00:00', 1, 6),
    ('Teatro de Música', 'Oficina de teatro para os alunos interessados', '2026-06-20 14:00:00', 1, 7);

-------------------------------------------------------------------------------------------
-- Photos from unsplash for the first 11 people (admin + 6 teachers + 4 guardians) (cc-by-sa)

UPDATE person
SET photo_url = CASE person_id
    WHEN 1 THEN 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=600&h=800'
    WHEN 2 THEN 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=600&h=800'
    WHEN 3 THEN 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&q=80&w=600&h=800'
    WHEN 4 THEN 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?auto=format&fit=crop&q=80&w=600&h=800'
    WHEN 5 THEN 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=600&h=800'
    WHEN 6 THEN 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=600&h=800'
    WHEN 7 THEN 'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&q=80&w=600&h=800'
    WHEN 8 THEN 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&q=80&w=600&h=800'
    WHEN 9 THEN 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=600&h=800'
    WHEN 10 THEN 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&q=80&w=600&h=800'
    WHEN 11 THEN 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&q=80&w=600&h=800'
    ELSE photo_url
END
WHERE person_id IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11);