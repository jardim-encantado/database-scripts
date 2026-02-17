-- Set timezone to UTC-3 (Brasília Time)
SET TIMEZONE TO 'UTC-3';

-- PERSON

CREATE TABLE person_role (
    person_role_id  SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL
);

CREATE TABLE address (
    address_id      SERIAL PRIMARY KEY,
    street          VARCHAR(255) NOT NULL,
    street_number   VARCHAR(20) NOT NULL,
    cep             VARCHAR(20) NOT NULL,
    complement      VARCHAR(100),
    city            VARCHAR(100) NOT NULL,
    state           VARCHAR(100) NOT NULL
);


CREATE TABLE person (
    person_id       SERIAL PRIMARY KEY,
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(255) UNIQUE NOT NULL,
    cpf             VARCHAR(14)  UNIQUE NOT NULL,
    phone_number    VARCHAR(20),
    password_hash   VARCHAR(255) NOT NULL,
    photo_url       VARCHAR(255),

    person_role_id  INTEGER NOT NULL,

    address_id      INTEGER NOT NULL,

    create_date     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (person_role_id) REFERENCES person_role(person_role_id),
    FOREIGN KEY (address_id)     REFERENCES address(address_id)
);


-- Student

INSERT INTO person_role (name) VALUES ('STUDENT');

CREATE TABLE student (
    student_id      SERIAL PRIMARY KEY,
    person_id       INTEGER NOT NULL,

    FOREIGN KEY (person_id) REFERENCES person(person_id)
);


CREATE TABLE enrollment_status(
    enrollment_status_id SERIAL PRIMARY KEY,
    name                VARCHAR(100) NOT NULL
);

CREATE TABLE enrollment (
    enrollment_id        SERIAL PRIMARY KEY,
    enrollment_status_id INTEGER NOT NULL,
    student_id           INTEGER NOT NULL,
    enrollment_date      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    create_date          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (student_id)           REFERENCES student(student_id),
    FOREIGN KEY (enrollment_status_id) REFERENCES enrollment_status(enrollment_status_id)
);

CREATE TABLE enrollment_request(
    enrollment_request_id SERIAL PRIMARY KEY,
    student_id            INTEGER NOT NULL,
    request_date          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date           TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    approved_by           INTEGER,

    FOREIGN KEY (student_id)  REFERENCES student(student_id),
    FOREIGN KEY (approved_by) REFERENCES person(person_id)
);


-- Teacher

INSERT INTO person_role (name) VALUES ('TEACHER');

CREATE TABLE teacher (
    teacher_id      SERIAL PRIMARY KEY,
    person_id       INTEGER NOT NULL,

    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

CREATE TABLE study_subject (
    subject_id      SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL
);


CREATE TABLE teacher_subject (
    teacher_subject_id SERIAL PRIMARY KEY,
    teacher_id         INTEGER NOT NULL,
    subject_id         INTEGER NOT NULL,

    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id),
    FOREIGN KEY (subject_id) REFERENCES study_subject(subject_id)
);

-- Classroom

CREATE TABLE classroom (
    classroom_id   SERIAL PRIMARY KEY,
    identifier     VARCHAR(100) NOT NULL CHECK (identifier ~ '^[A-Z]{3}-\d{3}$')
);

CREATE TABLE classroom_group (
    group_id        SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    series          VARCHAR(50) NOT NULL,
    classroom_id    INTEGER NOT NULL,
    teacher_id      INTEGER NOT NULL,

    FOREIGN KEY (classroom_id) REFERENCES classroom(classroom_id),
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
    
);


-- Grading

CREATE TABLE grading (
    grading_id          SERIAL PRIMARY KEY,
    student_id          INTEGER NOT NULL,
    subject_id          INTEGER NOT NULL,
    grade               DECIMAL(5, 2) NOT NULL CHECK (grade >= 0 AND grade <= 10),
    grading_date        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date         TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    given_by_teacher_id INTEGER NOT NULL,

    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (subject_id) REFERENCES study_subject(subject_id),
    FOREIGN KEY (given_by_teacher_id) REFERENCES teacher(teacher_id)
);

-- Guardian

INSERT INTO person_role (name) VALUES ('GUARDIAN');

CREATE TABLE guardian (
    guardian_id     SERIAL PRIMARY KEY,
    person_id       INTEGER NOT NULL,

    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

CREATE TABLE student_guardian (
    student_guardian_id SERIAL PRIMARY KEY,
    student_id          INTEGER NOT NULL,
    guardian_id         INTEGER NOT NULL,

    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (guardian_id) REFERENCES guardian(guardian_id)
);

-- Administrative Staff

CREATE TABLE admin(
    admin_id        SERIAL PRIMARY KEY,
    person_id       INTEGER NOT NULL,

    FOREIGN KEY (person_id) REFERENCES person(person_id)
);


-- School events

CREATE TABLE school_event_type (
    event_type_id   SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL
);

INSERT INTO school_event_type (name) VALUES ('EXAM'), ('HOLIDAY'), ('CYCLE'), ('OTHER');

CREATE TABLE school_event (
    event_id        SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    description     TEXT,
    event_date      TIMESTAMP NOT NULL,
    created_by      INTEGER NOT NULL,
    create_date     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    event_type_id   INTEGER NOT NULL,

    FOREIGN KEY (created_by) REFERENCES person(person_id),
    FOREIGN KEY (event_type_id) REFERENCES school_event_type(event_type_id)
);