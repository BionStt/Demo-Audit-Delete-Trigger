# Demo-Audit-Delete-Trigger
See corresponding blog post @natethedba:
https://natethedba.wordpress.com/a-sql-whodunnit-trigger/

Create a sample database `CSI`, a table `Victims`, a trigger that captures `delete`s against it, and an `Evidence` table to which said trigger writes.  Also includes user and sample data to test with.  Enjoy!

Requirements: SQL Server 2008R2 or higher.  Tested on SQL 2016 Developer Edition.

`CREATE OR ALTER` syntax for trigger is only supported on *SQL 2016 SP1 or higher*.
(For older versions, just remove the `OR ALTER` part.)
