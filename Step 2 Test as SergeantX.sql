/*
Log in to your test-server AS 'SergeantX', the db_owner SQL login you created in step 1.
*/

--> who am I?
USE CSI;
SELECT CURRENT_USER, USER_NAME(), SUSER_SNAME(), SUSER_NAME(), SYSTEM_USER, ORIGINAL_LOGIN()

--Now impersonate DummySuspect
EXECUTE AS USER = 'DummySuspect';

SELECT * FROM dbo.Victims

DELETE FROM dbo.Victims
WHERE Name = 'Pippin';

SELECT * FROM dbo.Victims

--Make sure to revert your security-context back to "self", otherwise you're still impersonating!
REVERT;
