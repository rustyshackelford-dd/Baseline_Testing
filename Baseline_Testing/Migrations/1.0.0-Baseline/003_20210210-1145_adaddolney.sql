-- <Migration ID="7f68efc9-bb71-425a-b1cb-10281ff2f5c9" />
GO

PRINT N'Creating [dbo].[NOT_LostSeaLimbo]'
GO
CREATE TABLE [dbo].[NOT_LostSeaLimbo]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[CustomerName] [varchar] (250) NULL,
[ServerName] [varchar] (200) NULL,
[dbname] [varchar] (250) NULL,
[Status] [varchar] (25) NULL,
[Transaction_id] [int] NULL,
[OperatorActionDate] [datetime] NULL,
[TransactionStatus_Id] [smallint] NULL,
[Activity] [varchar] (200) NULL,
[LastActivityMessage] [varchar] (100) NULL,
[CreatedDate] [datetime] NOT NULL,
[IsReported] [bit] NOT NULL,
[UnresolvedResendDate] [datetime] NULL
)
GO
