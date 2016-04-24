DROP TABLE Recipients CASCADE CONSTRAINTS;
DROP TABLE Conversation CASCADE CONSTRAINTS;
DROP TABLE Messages CASCADE CONSTRAINTS;
DROP TABLE Contacts CASCADE CONSTRAINTS;

CREATE TABLE Contacts
(   user_ID number(10) PRIMARY KEY,
    fname   varchar2(32),
    lname   varchar2(32),
    cell    varchar2(16),
    city    varchar2(32),
    country varchar2(32)
);

CREATE TABLE Conversation
(   convID  number(10) PRIMARY KEY,
    duration    INTERVAL DAY(2) TO SECOND
);

CREATE TABLE Messages
(   msgID   number(10) PRIMARY KEY,
    sender_ID   number(10),
    time_sent   TIMESTAMP,
    time_read   TIMESTAMP,
    convID  number(10),
    msg_text    varchar2(1024),
    spam    number(1),
    CONSTRAINT Messages_FK_Contacts FOREIGN KEY (sender_ID) REFERENCES Contacts(user_ID),
    CONSTRAINT Messages_FK_Conversation FOREIGN KEY (convID) REFERENCES Conversation(convID)
);

CREATE TABLE Recipients
(   msgID   number(10),
    user_ID number(10),
    CONSTRAINT Recipients_PK PRIMARY KEY (msgID, user_ID),
    CONSTRAINT Recipients_FK_Contacts FOREIGN KEY (user_ID) REFERENCES Contacts(user_ID),
    CONSTRAINT Recipients_FK_Messages FOREIGN KEY (msgID) REFERENCES Messages(msgID)
);

ALTER TABLE Messages DROP COLUMN time_read;
ALTER TABLE Recipients ADD time_read date;

ALTER TABLE Conversation DROP COLUMN duration;

ALTER TABLE Messages ADD length number(1);
ALTER TABLE Messages MODIFY length DEFAULT 0;

ALTER TABLE Messages ADD CONSTRAINT Messages_spam_check CHECK (spam BETWEEN 0 and 1);

ALTER TABLE Conversation ADD user_ID number(10);
ALTER TABLE Conversation ADD CONSTRAINT Conversation_FK_Contacts FOREIGN KEY (user_ID) REFERENCES Contacts(user_ID);

ALTER TABLE Messages MODIFY spam DEFAULT 0;

/*
INSERT INTO Contacts VALUES(1, 'Ada', 'Lovelace', '412-624-4141', 'Pittsburgh', 'US');
INSERT INTO Contacts VALUES(2, 'Na', 'Li','412-624-8442', 'Pittsburgh', 'US');
INSERT INTO Contacts VALUES(3, 'Francis', 'Lefebvre', '412-624-8443', 'Pittsburgh', 'US');
INSERT INTO Contacts VALUES(4, 'Amanda', 'Carlevaro', '412-624-8444', 'Pittsburgh', 'US');
INSERT INTO Contacts VALUES(5, 'Ethan', 'Lee', '412-624-8445', 'Pittsburgh', 'US');
INSERT INTO Contacts VALUES(6, 'Zina', 'Mkizungo', '412-624-8446', 'Pittsburgh', 'US');

INSERT INTO Conversation VALUES(1, 1);
INSERT INTO Conversation VALUES(2, 2);
INSERT INTO Conversation VALUES(3, 5);

--INSERT INTO Messages VALUES(1, 1, TIMESTAMP '2014-12-24 07:15:57', 1, 'How are you?', 0, 0);
--INSERT INTO Messages VALUES(2, 1, TIMESTAMP '2014-12-24 07:16:14', 1, 'Are you guys ok?', 0, 0);
INSERT INTO Messages VALUES(3, 2, TIMESTAMP '2015-02-24 15:45:12', 2, 'How to solve Problem 1?', 0, 0);
INSERT INTO Messages VALUES(4, 2, TIMESTAMP '2015-02-24 15:51:24', 2, 'I will be out of office tomorrow.', 0, 0);
INSERT INTO Messages VALUES(5, 2, TIMESTAMP '2015-02-24 15:57:56', 2, 'Submit your homework on time!', 0, 0);
INSERT INTO Messages VALUES(6, 5, TIMESTAMP '2015-07-24 09:39:18', 3, 'Buy this great car.', 1, 0);

--INSERT INTO Recipients VALUES(1, 2, TIMESTAMP '2014-12-24 07:16:11');
--INSERT INTO Recipients VALUES(1, 3, TIMESTAMP '2014-12-24 07:16:21');
INSERT INTO Recipients VALUES(2, 2, TIMESTAMP '2014-12-24 07:16:59');
INSERT INTO Recipients VALUES(2, 3, TIMESTAMP '2014-12-24 07:20:10');
INSERT INTO Recipients VALUES(3, 2, TIMESTAMP '2015-02-24 16:00:15');
INSERT INTO Recipients VALUES(4, 2, TIMESTAMP '2015-02-24 15:52:39');
*/
