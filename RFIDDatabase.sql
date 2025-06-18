CREATE DATABASE RFID
GO

USE [RFID]
GO
/****** Object:  Table [dbo].[RFIDUSER]    Script Date: 05.11.2023 17:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RFIDUSER](
	[RfidId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [varchar](50) NULL,
	[ChipId] [varchar](50) NULL,
 CONSTRAINT [PK_RfidUser] PRIMARY KEY CLUSTERED 
(
	[RfidId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Employee_RFIDUser_View]    Script Date: 05.11.2023 17:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Employee_RFIDUser_View] AS
SELECT
    R.EmployeeId,
    R.RfidID,
	R.ChipId
FROM
    RFIDUSER AS R;

GO
/****** Object:  Table [dbo].[EMPLOYEE]    Script Date: 05.11.2023 17:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EMPLOYEE](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Position] [varchar](50) NULL,
 CONSTRAINT [PK_EmployeeId] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOGGING]    Script Date: 05.11.2023 17:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOGGING](
	[RfidId] [varchar](50) NULL,
	[ScannedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UNAUTHORIZED]    Script Date: 05.11.2023 17:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UNAUTHORIZED](
	[RfidId] [varchar](50) NULL,
	[scanneddate] [datetime] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[EMPLOYEE] ON 
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeId], [FirstName], [LastName], [Position]) VALUES (1, N'Petter', N'Smart', N'Ingeniør')
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeId], [FirstName], [LastName], [Position]) VALUES (2, N'Onkel', N'Skrue', N'Investor')
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeId], [FirstName], [LastName], [Position]) VALUES (3, N'Snurre', N'Sprett', N'Medarbeider')
GO
SET IDENTITY_INSERT [dbo].[EMPLOYEE] OFF
GO
INSERT [dbo].[LOGGING] ([RfidId], [ScannedDate]) VALUES (N'74473485', CAST(N'2023-11-04T20:16:46.773' AS DateTime))
GO
INSERT [dbo].[LOGGING] ([RfidId], [ScannedDate]) VALUES (N'E417C066', CAST(N'2023-11-04T20:49:00.953' AS DateTime))
GO
INSERT [dbo].[LOGGING] ([RfidId], [ScannedDate]) VALUES (N'74473485', CAST(N'2023-11-05T16:58:08.723' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[RFIDUSER] ON 
GO
INSERT [dbo].[RFIDUSER] ([RfidId], [EmployeeId], [ChipId]) VALUES (4, N'1', N'74473485')
GO
INSERT [dbo].[RFIDUSER] ([RfidId], [EmployeeId], [ChipId]) VALUES (5, N'2', N'E417C066')
GO
INSERT [dbo].[RFIDUSER] ([RfidId], [EmployeeId], [ChipId]) VALUES (6, N'3', N'0430AD004E1C03')
GO
INSERT [dbo].[RFIDUSER] ([RfidId], [EmployeeId], [ChipId]) VALUES (10, N'3', N'E417C066')
GO
SET IDENTITY_INSERT [dbo].[RFIDUSER] OFF
GO
INSERT [dbo].[UNAUTHORIZED] ([RfidId], [scanneddate]) VALUES (N'74F22F6A', CAST(N'2023-11-05T13:33:29.663' AS DateTime))
GO
INSERT [dbo].[UNAUTHORIZED] ([RfidId], [scanneddate]) VALUES (N'417C066', CAST(N'2023-11-05T16:57:55.867' AS DateTime))
GO
INSERT [dbo].[UNAUTHORIZED] ([RfidId], [scanneddate]) VALUES (N'74F22F6A', CAST(N'2023-11-05T16:57:59.760' AS DateTime))
GO
INSERT [dbo].[UNAUTHORIZED] ([RfidId], [scanneddate]) VALUES (N'F428B557', CAST(N'2023-11-05T16:58:05.150' AS DateTime))
GO
ALTER TABLE [dbo].[LOGGING] ADD  DEFAULT (getdate()) FOR [ScannedDate]
GO
ALTER TABLE [dbo].[UNAUTHORIZED] ADD  DEFAULT (getdate()) FOR [scanneddate]
GO
/****** Object:  StoredProcedure [dbo].[uspAddLoggingData]    Script Date: 05.11.2023 17:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspAddLoggingData]
    @RfidValue VARCHAR(50)
AS
BEGIN
    INSERT INTO LOGGING (RfidId, ScannedDate)
    VALUES (@RfidValue, GETDATE());
END;
GO
/****** Object:  StoredProcedure [dbo].[uspAddNewRfidUser]    Script Date: 05.11.2023 17:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[uspAddNewRfidUser]
@employeeId int, @chipId varchar(50)
AS
INSERT INTO RFIDUSER (EmployeeId, ChipId)
VALUES (@employeeId, @chipId)
GO
/****** Object:  StoredProcedure [dbo].[uspAddUnauthorized]    Script Date: 05.11.2023 17:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspAddUnauthorized]
    @RFIDValue varchar(50)
AS
BEGIN
    INSERT INTO UNAUTHORIZED (RfidId) VALUES (@RFIDValue);
END;
GO
/****** Object:  StoredProcedure [dbo].[uspRemoveRfidUser]    Script Date: 05.11.2023 17:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspRemoveRfidUser]
@employeeId int, @chipId varchar(50)
AS
DELETE FROM RFIDUSER
WHERE EmployeeId = @employeeId AND ChipId = @chipId
GO
