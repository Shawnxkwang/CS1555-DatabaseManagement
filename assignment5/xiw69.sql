-----------------------------------------------------------
-- Question #1:


--1)
ALTER TABLE Messages ADD CONSTRAINT CHECK_TIME_msg
  CHECK (time_sent >= (TIMESTAMP '2015-01-01 00:00:01') );

--Test Cases:
INSERT INTO Messages(msgID, time_sent) VALUES(99, TIMESTAMP '2015-01-02 00:00:01');
INSERT INTO Messages(msgID, time_sent) VALUES(999, TIMESTAMP '2015-01-01 00:00:20');


--2)
ALTER TABLE Contacts ADD CONSTRAINT CHECK_USER
  CHECK (fname <> NULL AND lname <> NULL AND country = 'US');

--Test Cases:
INSERT INTO Contacts(user_ID, fname,lname,country) VALUES(99, 'jack', 'jackson', 'US');
INSERT INTO Contacts(user_ID, fname,lname,country) VALUES(999, 'john', 'johnson', 'US');


-----------------------------------------------------------
-- Question #2:

--1)

CREATE OR REPLACE TRIGGER ChangeSpam
  AFTER INSERT OR UPDATE ON Recipients
FOR EACH ROW
  WHEN (new.time_read IS NOT NULL)
BEGIN
  UPDATE Messages
  SET spam = 0
  WHERE Messages.msgID = :new.msgID;
END;
/
INSERT INTO Messages(msgID, spam) VALUES(11, 1);
INSERT INTO Recipients(msgID, user_ID, time_read) VALUES(11,99, TIMESTAMP '2015-12-24 07:15:57');
SELECT msgID,spam
FROM Messages;

--2)
CREATE OR REPLACE TRIGGER Length
  BEFORE INSERT ON Messages
FOR EACH ROW
BEGIN
  CASE
    WHEN LENGTH(:new.msg_text) < 20 THEN
    :new.length := 0;
    WHEN LENGTH(:new.msg_text) >= 20 THEN
    :new.length := 1;
  END CASE;
END;
/

--3)
CREATE OR REPLACE TRIGGER CreateConversation
    BEFORE INSERT OR UPDATE ON Messages
FOR EACH ROW
DECLARE cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO cnt
    FROM Conversation
    WHERE convID = :new.convID;
    IF cnt =0 THEN
      INSERT INTO Conversation VALUES (:new.convID, :new.sender_ID);
    END IF;
END;
/
