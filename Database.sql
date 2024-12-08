CREATE DATABASE IF NOT EXISTS DB_Journal;

USE DB_Journal;

-- DROP DATABASE DB_Journal;

-- SELECT * FROM T_User;

-- SELECT * FROM T_Message;

CREATE TABLE IF NOT EXISTS T_User (
	id			 	VARCHAR(17)		PRIMARY KEY, 
    full_name		VARCHAR(100)	NOT NULL,
	authority		VARCHAR(50)		NOT NULL,
    password		VARCHAR(30)		NOT NULL
);

CREATE TABLE IF NOT EXISTS T_Message (
	message_id				INT				PRIMARY KEY AUTO_INCREMENT,
    thread_id				int				NOT NULL, 
	title 					VARCHAR(50)		NOT NULL,
    body					LONGTEXT		NOT NULL,
    date					DATETIME(6)		NOT NULL,
	sender					VARCHAR(17)		NOT NULL,
    receiver				VARCHAR(17)		NOT NULL,
    is_read					BOOLEAN			NOT NULL, 
    CONSTRAINT T_Message_fk FOREIGN KEY (sender) REFERENCES T_User(id),
	CONSTRAINT T_Message_fk_2 FOREIGN KEY (receiver) REFERENCES T_User(id)
);
	
GRANT CREATE USER ON *.* TO 'root'@'localhost';

-- CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'admin';
-- GRANT ALL PRIVILEGES on DB_Webbshop.* TO 'admin'@'localhost';

CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON DB_Journal.* TO 'admin'@'%';
FLUSH PRIVILEGES;

/*
INSERT INTO T_User (ssn, authority, password, full_name)  
VALUES("200302271234", "Patient", "123", "Beatrcie Poriazov");

INSERT INTO T_User (ssn, authority, password, full_name)  
VALUES("200212261234", "Patient", "123", "Olivia Hultman");

INSERT INTO T_Message (thread_id, title, body, date, sender, receiver_user, receiver_organization , answered)  
VALUES("1", "Testmessage", "Hello.", "2024-11-09 11:30:00", "200302271234", "200212261234", null, false);

INSERT INTO T_Message (thread_id, title, body, date, sender, receiver_user, receiver_organization , answered)  
VALUES("1", "Testmessage answer", "Hi.", "2024-11-10 11:30:00", "200212261234", "200302271234", null, false);

INSERT INTO T_Message (thread_id, title, body, date, sender, receiver_user, receiver_organization , answered)  
VALUES("1", "Testmessage answer to answer", "How are you?", "2024-11-12 11:30:00", "200302271234", "200212261234", null, false);

INSERT INTO T_Message (thread_id, title, body, date, sender, receiver_user, receiver_organization , answered)  
VALUES("2", "Message", "Yohoo.", "2024-11-11 11:30:00", "200212261234", "200302271234", null, false);


CREATE TABLE T_Location (
	address				VARCHAR(100)		PRIMARY KEY
);

CREATE TABLE T_Organization (
	organization_number	VARCHAR(30)		PRIMARY KEY,
    name				VARCHAR(100)	NOT NULL,
    location 			VARCHAR(100)	NOT NULL,
    CONSTRAINT T_Organization_fk FOREIGN KEY (location) REFERENCES T_Location(address)
);

CREATE TABLE T_Practitioner (
	user				VARCHAR(12)		PRIMARY KEY,
    professional_title	VARCHAR(100)	NOT NULL,
    organization 		VARCHAR(30)		NOT NULL,
    CONSTRAINT T_Practitioner_fk FOREIGN KEY (user) REFERENCES T_User(ssn),
	CONSTRAINT T_Practitioner_fk_2 FOREIGN KEY (organization) REFERENCES T_Organization(organization_number)
);

CREATE TABLE T_Patient (
	user			VARCHAR(12)		PRIMARY KEY,
	organization 	VARCHAR(30)		NOT NULL,
    CONSTRAINT T_Patient_fk FOREIGN KEY (user) REFERENCES T_User(ssn),
	CONSTRAINT T_Patient_fk_2 FOREIGN KEY (organization) REFERENCES T_Organization(organization_number)
);

CREATE TABLE T_Encounter (
	practitioner	VARCHAR(12)		NOT NULL,
	patient			VARCHAR(12)		NOT NULL,
    date			DATETIME(6)		NOT NULL,
	organization 	VARCHAR(30)		NOT NULL,
    CONSTRAINT T_Encounter_pk PRIMARY KEY (patient, date),
    CONSTRAINT T_Encounter_fk FOREIGN KEY (practitioner) REFERENCES T_Practitioner(user),
	CONSTRAINT T_Encounter_fk_2 FOREIGN KEY (patient) REFERENCES T_Patient(user),
	CONSTRAINT T_Encounter_fk_3 FOREIGN KEY (organization) REFERENCES T_Organization(organization_number)
);

CREATE TABLE T_Observation (
	practitioner		VARCHAR(12)		NOT NULL,
	patient				VARCHAR(12)		NOT NULL,
    date				DATETIME(6)		NOT NULL,
	background 			LONGTEXT,
	current_problem 	LONGTEXT,
	status 				LONGTEXT,
	examination_results LONGTEXT,
    assessment 			LONGTEXT,
	measure 			LONGTEXT,
    CONSTRAINT T_Observation_pk PRIMARY KEY (patient, date),
    CONSTRAINT T_Observation_fk FOREIGN KEY (practitioner) REFERENCES T_Practitioner(user),
	CONSTRAINT T_Observation_fk_2 FOREIGN KEY (patient) REFERENCES T_Patient(user)
);

CREATE TABLE T_Condition (
	practitioner	VARCHAR(12)		NOT NULL,
	patient			VARCHAR(12)		NOT NULL,
    diagnosis		VARCHAR(100)	NOT NULL,
	organization 	VARCHAR(30)		NOT NULL,
    CONSTRAINT T_Condition_pk PRIMARY KEY (patient, diagnosis),
    CONSTRAINT T_Condition_fk FOREIGN KEY (practitioner) REFERENCES T_Practitioner(user),
	CONSTRAINT T_Condition_fk_2 FOREIGN KEY (patient) REFERENCES T_Patient(user),
	CONSTRAINT T_Condition_fk_3 FOREIGN KEY (organization) REFERENCES T_Organization(organization_number)
);

INSERT INTO T_Location (address)  
VALUES("Ringvägen 16");

INSERT INTO T_Organization (organization_number, name, location)  
VALUES("1234", "GulaHuset", "Ringvägen 16");

INSERT INTO T_Practitioner (user, professional_title, organization)  
VALUES("200302271234", "Eyedoctor", "1234");

INSERT INTO T_Patient (user, organization)  
VALUES("200302271234", "1234");

INSERT INTO T_Encounter (practitioner, patient, date, organization)  
VALUES("200302271234", "200302271234", "2024-11-09 11:30:00", "1234");
*/