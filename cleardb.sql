-- Script to clear all data from the database, in the correct order to avoid foreign key violations
-- Reset sequences as well

TRUNCATE TABLE
    teacher_subject,
    teacher,
    study_subject,
    admin,
    person_role,
    person,
    student_guardian,
    guardian,
    student,
    school_event,
    school_event_type,
	classroom,
	classroom_group
RESTART IDENTITY CASCADE;