---------------------------------------------------
-- CREATED BY Xiaokai Wang

-- xiw69

--------------------------------------------------
-- Question #1:
--------------------------------------------------

DROP TABLE Messages CASCADE CONSTRAINTS;
DROP TABLE Recipients CASCADE CONSTRAINTS;
DROP TABLE Contacts CASCADE CONSTRAINTS;
DROP TABLE Conversation CASCADE CONSTRAINTS;

 
CREATE TABLE Contacts (
	user_ID number(10) NOT NULL,
	fname varchar2(32),
	lname varchar2(32),
	cell varchar2(16),
	city varchar2(32),
	country varchar2(32),
	CONSTRAINT pk_contacts PRIMARY KEY(user_ID));



CREATE TABLE Conversation (
	convID number(10) NOT NULL,
	duration number(32), 
	CONSTRAINT pk_conv PRIMARY KEY(convID));
	
CREATE TABLE Messages (
	msgID number(10) NOT NULL,
	sender_ID number(10),
	time_sent timestamp,
	time_read timestamp DEFAULT NULL,
	convID number(10),
	msg_text varchar2(1024),
	spam number(1),
	CONSTRAINT pk_message PRIMARY KEY(msgID),
	CONSTRAINT fk_msg_contacts FOREIGN KEY(sender_ID) REFERENCES Contacts(user_ID),
	CONSTRAINT fk_msg_conversation FOREIGN KEY(convID) REFERENCES Conversation(convID));

	
CREATE TABLE Recipients (
	msgID number(10) NOT NULL,
	user_ID number(10) NOT NULL,
	CONSTRAINT pk_recipients PRIMARY KEY(msgID, user_ID),
	CONSTRAINT fk_rec_msg FOREIGN KEY(msgID) REFERENCES Messages(msgID),
	CONSTRAINT fk_rec_contacts FOREIGN KEY(user_ID) REFERENCES Contacts(user_ID));


COMMIT;
PURGE RECYCLEBIN;



---------------------------------------------
-- Question #2:
---------------------------------------------

-- a)
ALTER TABLE Messages DROP COLUMN time_read;
COMMIT;
ALTER TABLE Recipients ADD time_read timestamp;
COMMIT;

-- b)
ALTER TABLE Conversation DROP COLUMN duration;
COMMIT;

-- c)
ALTER TABLE Messages ADD length number(1);
COMMIT;
ALTER TABLE Messages MODIFY length DEFAULT 0;
COMMIT;

-- d)
ALTER TABLE Messages MODIFY spam DEFAULT 1;
COMMIT;

-- e)
ALTER TABLE Conversation ADD user_ID number(10);
COMMIT;
ALTER TABLE Conversation ADD CONSTRAINT fk_conv_contacts FOREIGN KEY(user_ID) REFERENCES Contacts(user_ID);
COMMIT;

-- f)
ALTER TABLE Messages MODIFY spam DEFAULT 0;
COMMIT;

PURGE RECYCLEBIN;

-----------------------------------------------
-- Question #3:
-----------------------------------------------
	
	
	
INSERT INTO Contacts(user_ID, fname, lname, cell, city, country)
	VALUES(1, 'Ada', 'Lovelace', '412-624-4141', 'Pittsburgh', 'US');
INSERT INTO Contacts(user_ID, fname, lname, cell, city, country)
	VALUES(2, 'Na', 'Li', '412-624-8442', 'Pittsburgh', 'US');
INSERT INTO Contacts(user_ID, fname, lname, cell, city, country)
	VALUES(3, 'Francis', 'Lefebvre', '412-624-8443', 'Pittsburgh', 'US');
INSERT INTO Contacts(user_ID, fname, lname, cell, city, country)
	VALUES(4, 'Amanda', 'Carlevaro', '412-624-8444', 'Pittsburgh', 'US');
INSERT INTO Contacts(user_ID, fname, lname, cell, city, country)
	VALUES(5, 'Ethan', 'Lee', '412-624-8445', 'Pittsburgh', 'US');
INSERT INTO Contacts(user_ID, fname, lname, cell, city, country)
	VALUES(6, 'Zina', 'Mkizungo', '412-624-8446', 'Pittsburgh', 'US');
COMMIT;	
	
	
	
	
INSERT INTO Conversation(convID,user_ID)
	VALUES(1,1);
INSERT INTO Conversation(convID,user_ID)
	VALUES(2,2);
INSERT INTO Conversation(convID,user_ID)
	VALUES(3,5);

COMMIT;

INSERT INTO Messages(msgID, sender_ID, time_sent, convID, msg_text, spam, length)
	VALUES(1, 1, TO_TIMESTAMP('2014-12-24 07:15:57', 'YYYY-MM-DD HH24:mi:ss'), 1, 'How are you?', 0, 0);
INSERT INTO Messages(msgID, sender_ID, time_sent, convID, msg_text, spam, length)
	VALUES(2, 1, TO_TIMESTAMP('2014-12-24 07:16:14', 'YYYY-MM-DD HH24:mi:ss'), 1, 'Are you guys ok?', 0, 0);
INSERT INTO Messages(msgID, sender_ID, time_sent, convID, msg_text, spam, length)
	VALUES(3, 2, TO_TIMESTAMP('2015-02-24 15:45:12', 'YYYY-MM-DD HH24:mi:ss'), 2, 'How to solve Problem 1?', 0, 0);
INSERT INTO Messages(msgID, sender_ID, time_sent, convID, msg_text, spam, length)
	VALUES(4, 2, TO_TIMESTAMP('2015-02-24 15:51:24', 'YYYY-MM-DD HH24:mi:ss'), 2, 'I will be out of office tomorrow.', 0, 0);
INSERT INTO Messages(msgID, sender_ID, time_sent, convID, msg_text, spam, length)
	VALUES(5, 2, TO_TIMESTAMP('2015-02-24 15:57:56', 'YYYY-MM-DD HH24:mi:ss'), 2, 'Submit your homework on time!', 0, 0);
INSERT INTO Messages(msgID, sender_ID, time_sent, convID, msg_text, spam, length)
	VALUES(6, 5, TO_TIMESTAMP('2015-07-24 09:39:18', 'YYYY-MM-DD HH24:mi:ss'), 3, 'Buy this great car.', 1, 0);
COMMIT;

	
	
	
INSERT INTO Recipients(msgID, user_ID, time_read)
	VALUES(1,2, TO_TIMESTAMP('2014-12-24 07:16:11', 'YYYY-MM-DD HH24:mi:ss'));
INSERT INTO Recipients(msgID, user_ID, time_read)
	VALUES(1,3, TO_TIMESTAMP('2014-12-24 07:16:21', 'YYYY-MM-DD HH24:mi:ss'));
INSERT INTO Recipients(msgID, user_ID, time_read)
	VALUES(2,2, TO_TIMESTAMP('2014-12-24 07:16:59', 'YYYY-MM-DD HH24:mi:ss'));
INSERT INTO Recipients(msgID, user_ID, time_read)
	VALUES(2,3, TO_TIMESTAMP('2014-12-24 07:20:10', 'YYYY-MM-DD HH24:mi:ss'));
INSERT INTO Recipients(msgID, user_ID, time_read)
	VALUES(3,2, TO_TIMESTAMP('2015-02-24 16:00:15', 'YYYY-MM-DD HH24:mi:ss'));
INSERT INTO Recipients(msgID, user_ID, time_read)
	VALUES(4,2, TO_TIMESTAMP('2015-02-24 15:52:39', 'YYYY-MM-DD HH24:mi:ss'));
COMMIT;	

PURGE RECYCLEBIN;


-----------------------------------------------------
