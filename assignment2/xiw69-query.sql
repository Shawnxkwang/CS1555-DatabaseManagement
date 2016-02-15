---------------------------------------------------
-- CREATED BY Xiaokai Wang

-- xiw69

--------------------------------------------------
-- Question #1:
--------------------------------------------------

-- a)

SELECT	user_ID
FROM	Contacts
WHERE	cell= '412-624-8445';


-- b)

SELECT	fname, lname
FROM	Contacts
WHERE	user_ID IN (SELECT	sender_ID
				   FROM		Messages
				   WHERE	msgID IN ( SELECT	msgID
									  FROM		Recipients
									  WHERE		user_ID = ( SELECT	user_ID
															FROM	Contacts
															WHERE	fname = 'Francis'
																	AND		lname = 'Lefebvre')));


-- c)

SELECT 	COUNT(user_ID) AS ReceivedByUser1
FROM 	Recipients
WHERE	user_ID = 1;

SELECT 	COUNT(user_ID) AS ReceivedByUser2
FROM 	Recipients
WHERE	user_ID = 2;

SELECT 	COUNT(user_ID) AS ReceivedByUser3
FROM 	Recipients
WHERE	user_ID = 3;

SELECT 	COUNT(user_ID) AS ReceivedByUser4
FROM 	Recipients
WHERE	user_ID = 4;

SELECT 	COUNT(user_ID) AS ReceivedByUser5
FROM 	Recipients
WHERE	user_ID = 5;

SELECT 	COUNT(user_ID) AS ReceivedByUser6
FROM 	Recipients
WHERE	user_ID = 6;

--------------------------------------------------------------------
