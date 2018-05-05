CREATE DATABASE [CSI];
GO

--Victims
USE CSI;
GO

CREATE TABLE dbo.Victims
(
    Id int IDENTITY(1,1)
    , Name varchar(50)
    , CONSTRAINT PK_Victims PRIMARY KEY CLUSTERED (Id)
);
GO

TRUNCATE TABLE dbo.Victims;
INSERT INTO dbo.Victims (Name)
SELECT 'Frodo'
UNION ALL
SELECT 'Samwise'
UNION ALL
SELECT 'Merry'
UNION ALL
SELECT 'Pippin'
UNION ALL
SELECT 'Bilbo'
GO

SELECT * FROM dbo.Victims;
GO

--Evidence storage
USE CSI;
GO
CREATE SCHEMA [aud];
GO

--DROP TABLE aud.Evidence;
CREATE TABLE aud.Evidence
(
    Id int IDENTITY(1,1)
    , SchemaName sysname
    , TableName sysname
    , ActionType varchar(10)
    , RecordID int
    , DatabaseUser sysname
    , ServerLogin sysname
    , ActionTime datetime2
    , CONSTRAINT PK_Evidence PRIMARY KEY NONCLUSTERED (Id)
);
GO
CREATE CLUSTERED INDEX CX_Evidence ON aud.Evidence
    (ActionTime)
;
CREATE INDEX IX_Evidence_Content ON aud.Evidence
    (RecordID, TableName, SchemaName, DatabaseUser, ServerLogin, ActionType)
;
GO

SELECT * FROM aud.Evidence;
GO

--Logins
USE master;
CREATE LOGIN [DummySuspect] WITH PASSWORD = 'Dummy1!', CHECK_POLICY = OFF;
CREATE LOGIN [SergeantX] WITH PASSWORD = 'MoarP0w3r!', CHECK_POLICY = OFF;
GO

USE CSI;
CREATE USER [DummySuspect] FOR LOGIN [DummySuspect];
GRANT SELECT,INSERT,UPDATE,DELETE ON dbo.Victims TO [DummySuspect];
GO

CREATE USER [SergeantX] FOR LOGIN [SergeantX];
ALTER ROLE [db_owner] ADD MEMBER [SergeantX];
GO

EXEC sys.sp_helprotect 'dbo.Victims';
EXEC sys.sp_helpuser 'DummySuspect';
EXEC sys.sp_helpuser 'SergeantX';
GO

--Trigger
USE CSI;
GO
CREATE OR ALTER TRIGGER dbo.Victims_DEL
    ON dbo.Victims
    AFTER DELETE
AS
BEGIN
    INSERT INTO aud.Evidence (SchemaName, TableName, ActionType, RecordID
        , DatabaseUser, ServerLogin, ActionTime)
    SELECT SchemName = 'dbo', TableName = 'Victims', ActionType = 'delete', RecordID = Deleted.Id
        , DbUser = USER_NAME(), SrvLogin = SUSER_SNAME(), ActionTime = SYSDATETIME()
    FROM Deleted;
END
GO
