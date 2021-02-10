-- <Migration ID="ee059bbd-272b-4899-9640-53049560162c" />
GO

DECLARE @associate bit
SELECT @associate = CASE SERVERPROPERTY('EngineEdition') WHEN 5 THEN 1 ELSE 0 END
IF @associate = 0 EXEC sp_executesql N'SELECT @count = COUNT(*) FROM master.dbo.syslogins WHERE loginname = N''deployment''', N'@count bit OUT', @associate OUT
IF @associate = 1
BEGIN
    PRINT N'Creating user [deployment] and mapping to the login [deployment]'
    CREATE USER [deployment] FOR LOGIN [deployment]
END
ELSE
BEGIN
    PRINT N'Creating user [deployment] without login'
    CREATE USER [deployment] WITHOUT LOGIN
END
GO
PRINT N'Altering members of role db_owner'
GO
ALTER ROLE [db_owner] ADD MEMBER [deployment]
GO
PRINT N'Creating [dbo].[AGENTS]'
GO
CREATE TABLE [dbo].[AGENTS]
(
[AGENT_CODE] [varchar] (6) NOT NULL,
[AGENT_NAME] [varchar] (40) NULL,
[WORKING_AREA] [varchar] (35) NULL,
[COMMISSION] [decimal] (10, 2) NULL,
[PHONE_NO] [varchar] (15) NULL,
[COUNTRY] [varchar] (25) NULL
)
GO
PRINT N'Creating primary key [PK__AGENTS__843A8BBA695E5C0A] on [dbo].[AGENTS]'
GO
ALTER TABLE [dbo].[AGENTS] ADD CONSTRAINT [PK__AGENTS__843A8BBA695E5C0A] PRIMARY KEY CLUSTERED  ([AGENT_CODE])
GO
PRINT N'Creating [dbo].[CUSTOMER]'
GO
CREATE TABLE [dbo].[CUSTOMER]
(
[CUST_CODE] [varchar] (6) NOT NULL,
[CUST_NAME] [varchar] (40) NOT NULL,
[CUST_CITY] [varchar] (35) NULL,
[WORKING_AREA] [varchar] (35) NOT NULL,
[CUST_COUNTRY] [varchar] (20) NOT NULL,
[GRADE] [int] NULL,
[OPENING_AMT] [decimal] (12, 2) NOT NULL,
[RECEIVE_AMT] [decimal] (12, 2) NOT NULL,
[PAYMENT_AMT] [decimal] (12, 2) NOT NULL,
[OUTSTANDING_AMT] [decimal] (12, 2) NOT NULL,
[PHONE_NO] [varchar] (17) NOT NULL,
[AGENT_CODE] [varchar] (6) NOT NULL
)
GO
PRINT N'Creating primary key [PK__CUSTOMER__8393C4A18033BC87] on [dbo].[CUSTOMER]'
GO
ALTER TABLE [dbo].[CUSTOMER] ADD CONSTRAINT [PK__CUSTOMER__8393C4A18033BC87] PRIMARY KEY CLUSTERED  ([CUST_CODE])
GO
PRINT N'Creating [dbo].[ORDERS]'
GO
CREATE TABLE [dbo].[ORDERS]
(
[ORD_NUM] [decimal] (6, 0) NOT NULL,
[ORD_AMOUNT] [decimal] (12, 2) NOT NULL,
[ADVANCE_AMOUNT] [decimal] (12, 2) NOT NULL,
[ORD_DATE] [date] NOT NULL,
[CUST_CODE] [varchar] (6) NOT NULL,
[AGENT_CODE] [varchar] (6) NOT NULL,
[ORD_DESCRIPTION] [varchar] (60) NOT NULL
)
GO
PRINT N'Creating primary key [PK__ORDERS__27AB607C77FFF8BC] on [dbo].[ORDERS]'
GO
ALTER TABLE [dbo].[ORDERS] ADD CONSTRAINT [PK__ORDERS__27AB607C77FFF8BC] PRIMARY KEY CLUSTERED  ([ORD_NUM])
GO
PRINT N'Adding foreign keys to [dbo].[CUSTOMER]'
GO
ALTER TABLE [dbo].[CUSTOMER] ADD CONSTRAINT [FK__CUSTOMER__AGENT___38996AB5] FOREIGN KEY ([AGENT_CODE]) REFERENCES [dbo].[AGENTS] ([AGENT_CODE])
GO
ALTER TABLE [dbo].[CUSTOMER] ADD CONSTRAINT [FK_CUSTOMER_AGENT] FOREIGN KEY ([AGENT_CODE]) REFERENCES [dbo].[AGENTS] ([AGENT_CODE])
GO
PRINT N'Adding foreign keys to [dbo].[ORDERS]'
GO
ALTER TABLE [dbo].[ORDERS] ADD CONSTRAINT [FK_ORDERS_AGENT] FOREIGN KEY ([AGENT_CODE]) REFERENCES [dbo].[AGENTS] ([AGENT_CODE])
GO
ALTER TABLE [dbo].[ORDERS] ADD CONSTRAINT [FK_ORDERS_CUSTOMER] FOREIGN KEY ([CUST_CODE]) REFERENCES [dbo].[CUSTOMER] ([CUST_CODE])
GO
