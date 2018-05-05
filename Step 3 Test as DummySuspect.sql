/*
Log in to your test-server AS the [DummySuspect] SQL login you created in step 1.
*/

--> who am I?
USE CSI;
SELECT CURRENT_USER, USER_NAME(), SUSER_SNAME(), SUSER_NAME(), SYSTEM_USER, ORIGINAL_LOGIN()

SELECT * FROM dbo.Victims

DELETE FROM dbo.Victims
WHERE Name = 'Bilbo';

SELECT * FROM dbo.Victims

--> just to prove i can't see my own evidence
SELECT * FROM aud.Evidence
WHERE TableName = 'Victims'
