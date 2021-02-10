-- <Migration ID="ac93bed8-3a1c-409d-80e1-fae40dd119b0" />
GO

PRINT N'Creating [dbo].[LostSeaLimbo]'
GO
CREATE TABLE [dbo].[LostSeaLimbo]
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
[CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__LostSeaLi__Creat__44FF419A] DEFAULT (getdate()),
[IsReported] [bit] NOT NULL CONSTRAINT [DF__LostSeaLi__IsRep__45F365D3] DEFAULT ((0)),
[UnresolvedResendDate] [datetime] NULL
)
GO
