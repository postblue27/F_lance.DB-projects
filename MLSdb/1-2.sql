SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

USE [master];
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'MLSdb')
	DROP DATABASE MLSdb;
GO

-- Create the MLSdb database.
CREATE DATABASE MLSdb;
GO

-- Specify a simple recovery model 
-- to keep the log growth to a minimum.
ALTER DATABASE MLSdb 
	SET RECOVERY SIMPLE;
GO

USE MLSdb;
GO

-- Create the Game table.
IF NOT EXISTS (SELECT * FROM sys.objects 
		WHERE object_id = OBJECT_ID(N'[dbo].[Game]') 
		AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Game](
	[GAME_ID] [nvarchar](50) NOT NULL,
	[SEA_ID] [int] NOT NULL,
	[GAME_Location] [nvarchar](MAX) NOT NULL,
	[GAME_Date] [datetime] NOT NULL,
	[GAME_Conference] [nvarchar](MAX) NOT NULL,
 CONSTRAINT [PK_Game] PRIMARY KEY CLUSTERED 
(
	[GAME_ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- Create the Season table.
IF NOT EXISTS (SELECT * FROM sys.objects 
		WHERE object_id = OBJECT_ID(N'[dbo].[Season]') 
		AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Season](
	[SEA_ID] [int] NOT NULL,
	[SEA_Year] [int] NOT NULL,
 CONSTRAINT [PK_Season] PRIMARY KEY CLUSTERED 
(
	[SEA_ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- Create the VideoDataView table.
IF NOT EXISTS (SELECT * FROM sys.objects 
		WHERE object_id = OBJECT_ID(N'[dbo].[VideoDataView]') 
		AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[VideoDataView](
	[VID_ID] [int] NOT NULL,
	[GAME_ID] [nvarchar](50) NOT NULL,
	[VID_FirstHalf] [nvarchar](MAX) NOT NULL,
	[VID_SecondHalf] [nvarchar](MAX) NOT NULL,
 CONSTRAINT [PK_VideoDataView] PRIMARY KEY CLUSTERED 
(
	[VID_ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- Create the Referee table.
IF NOT EXISTS (SELECT * FROM sys.objects 
		WHERE object_id = OBJECT_ID(N'[dbo].[Referee]') 
		AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Referee](
	[REF_ID] [nvarchar](50) NOT NULL,
	[REF_Name] [nvarchar](MAX) NOT NULL,
	[REF_DateOfBirth] [datetime] NOT NULL,
 CONSTRAINT [PK_Referee] PRIMARY KEY CLUSTERED 
(
	[REF_ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

--Create the Team table.
IF NOT EXISTS (SELECT * FROM sys.objects 
		WHERE object_id = OBJECT_ID(N'[dbo].[Team]') 
		AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Team](
	[TEAM_ID] [nvarchar](50) NOT NULL,
	[TEAM_Name] [nvarchar](MAX) NOT NULL,
	[TEAM_Location] [nvarchar](MAX) NOT NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[TEAM_ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- Create the Player table.
IF NOT EXISTS (SELECT * FROM sys.objects 
		WHERE object_id = OBJECT_ID(N'[dbo].[Player]') 
		AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Player](
	[PLAY_ID] [nvarchar](50) NOT NULL,
	[PLAY_Name] [nvarchar](MAX) NOT NULL,
	[PLAY_DateOfBirth] [datetime] NOT NULL,
 CONSTRAINT [PK_Player] PRIMARY KEY CLUSTERED 
(
	[PLAY_ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- Create the TracksDataView table.
IF NOT EXISTS (SELECT * FROM sys.objects 
		WHERE object_id = OBJECT_ID(N'[dbo].[TracksDataView]') 
		AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TracksDataView](
	[T_ID] [int] NOT NULL,
	[T_Period] [int] NOT NULL,
	[T_VidFrame] [int] NOT NULL,
	[T_Time] [float] NOT NULL,
	[T_BallX] [float] NOT NULL,
	[T_BallY] [float] NOT NULL,
	[T_Ref1_X] [float] NOT NULL,
	[T_Ref1_Y] [float] NOT NULL,
	[T_Player1(T1)-X] [float] NOT NULL,
	[T_Player1(T1)-Y] [float] NOT NULL,
	[T_Player2(T1)-X] [float] NOT NULL,
	[T_Player2(T1)-Y] [float] NOT NULL,
	[T_Player1(T2)-X] [float] NOT NULL,
	[T_Player1(T2)-Y] [float] NOT NULL,
	[T_Player2(T2)-X] [float] NOT NULL,
	[T_Player2(T2)-Y] [float] NOT NULL,
 CONSTRAINT [PK_TracksDataView] PRIMARY KEY CLUSTERED 
(
	[T_ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- Create the EventsDataView table.
IF NOT EXISTS (SELECT * FROM sys.objects 
		WHERE object_id = OBJECT_ID(N'[dbo].[EventsDataView]') 
		AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EventsDataView](
	[E_ID] [int] NOT NULL,
	[TEAM_ID] [nvarchar](50) NOT NULL,
	[E_Type] [nvarchar](MAX) NOT NULL,
	[E_SubType] [nvarchar](MAX) NOT NULL,
	[E_Period] [int] NOT NULL,
	[E_StartVideoFrame] [int] NOT NULL,
	[E_StartTime] [float] NOT NULL,
	[E_EndVideoFrame] [int] NOT NULL,
	[E_EndTime] [float] NOT NULL,
	[E_From] [nvarchar](MAX) NOT NULL,
	[E_To] [nvarchar](MAX) NULL,
	[E_StartX] [float] NULL,
	[E_StartY] [float] NULL ,
	[E_EndX] [float] NULL,
	[E_EndY] [float] NULL,
 CONSTRAINT [PK_EventsDataView] PRIMARY KEY CLUSTERED 
(
	[E_ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- Define the relationship between Game and Season.
IF NOT EXISTS (SELECT * FROM sys.foreign_keys 
       WHERE object_id = OBJECT_ID(N'[dbo].[FK_Game_Season]')
       AND parent_object_id = OBJECT_ID(N'[dbo].[Game]'))
ALTER TABLE [dbo].[Game]  WITH CHECK ADD  
       CONSTRAINT [FK_Game_Season] FOREIGN KEY([SEA_ID])
REFERENCES [dbo].[Season] ([SEA_ID])
GO
ALTER TABLE [dbo].[Game] CHECK 
       CONSTRAINT [FK_Game_Season]
GO

-- Define the relationship between VideoDataView and Game.
IF NOT EXISTS (SELECT * FROM sys.foreign_keys 
       WHERE object_id = OBJECT_ID(N'[dbo].[FK_VideoDataView_Game]')
       AND parent_object_id = OBJECT_ID(N'[dbo].[VideoDataView]'))
ALTER TABLE [dbo].[VideoDataView]  WITH CHECK ADD  
       CONSTRAINT [FK_VideoDataView_Game] FOREIGN KEY([GAME_ID])
REFERENCES [dbo].[Game] ([GAME_ID])
GO
ALTER TABLE [dbo].[VideoDataView] CHECK 
       CONSTRAINT [FK_VideoDataView_Game]
GO

-- Define the relationship between EventsDataView and Team.
IF NOT EXISTS (SELECT * FROM sys.foreign_keys 
       WHERE object_id = OBJECT_ID(N'[dbo].[FK_EventsDataView_Team]')
       AND parent_object_id = OBJECT_ID(N'[dbo].[EventsDataView]'))
ALTER TABLE [dbo].[EventsDataView]  WITH CHECK ADD  
       CONSTRAINT [FK_EventsDataView_Team] FOREIGN KEY([TEAM_ID])
REFERENCES [dbo].[Team] ([TEAM_ID])
GO
ALTER TABLE [dbo].[EventsDataView] CHECK 
       CONSTRAINT [FK_EventsDataView_Team]
GO


INSERT INTO Season VALUES 
	(1,2015),
	(2,2016),
	(3,200017),
	(4,2018),
	(5,2019),
	(6,2020)

GO

INSERT INTO Game VALUES 
	('G1',3,'Mapfre Stadium',13/05/2017,'Eastern'),
	('G2',3,'Audi Field',20/05/2017,'Eastern'),
	('G3',3,'Rio Tinto Stadium',13/05/2017,'Western'),
	('G4',3,'Childrens Mercy Park',20/05/2017,'Western'),
	('G5',3,'Red Bull Arena',27/05/2017,'Eastern'),
	('G6',3,'Saputo Stadium',03/06/2017,'Eastern'),
	('G7',3,'Talen Energy Stadium',10/06/2017,'Eastern'),
	('G8',3,'Rio Tinto Stadium',27/05/2017,'Western'),
	('G9',3,'Childrens Mercy Park',03/06/2017,'Western')

GO

INSERT INTO VideoDataView VALUES 
	(1,'G1','“C:\dropbox\g1-fh.mp4”','“C:\dropbox\g1-sh.mp4”'),
	(2,'G2','“C:\dropbox\g2-fh.mp4”','“C:\dropbox\g2-sh.mp4”'),
	(3,'G3','“C:\dropbox\g3-fh.mp4”','“C:\dropbox\g3-sh.mp4”'),
	(4,'G4','“C:\dropbox\g4-fh.mp4”','“C:\dropbox\g4-sh.mp4”'),
	(5,'G5','“C:\dropbox\g5-fh.mp4”','“C:\dropbox\g5-sh.mp4”')


GO
	
INSERT INTO Team VALUES 
	('Team1','Columbus Crew SC','Mapfre Stadium'),
	('Team2','D.C. United','Audi Field'),
	('Team3','Real Salt Lake','Rio Tinto Stadium'),
	('Team4','Sporting Kansas City','Childrens Mercy Park'),
	('Team5','New York Red Bulls','Red Bull Arena'),
	('Team6','Montreal Impact','Saputo Stadium'),
	('Team7','Philadelphia Union','Talen Energy Stadium')


GO

INSERT INTO Referee VALUES 
	('R1','David Barkham',21/03/1988),
	('R2','Ron Arkinsaw',09/09/1987),
	('R3','Paolo Schools',15/10/1989),
	('R4','Ray Keen',02/12/1989),
	('R5','Teddy Bear',29/04/1985),
	('R6','Ollie Goon',12/04/1988),
	('R7','Rudie Nistlebrush',08/07/1985)


GO

INSERT INTO Player VALUES 
	('P1','Joe Jordan',20/05/1998),
	('P2','Martin Buchan',04/01/1997),
	('P3','Stevie Coppell',17/12/1999),
	('P4','Lou Macari',08/10/1999),
	('P5','Jimmy Greenhoff',25/04/1995),
	('P6','Norman Whiteside',13/09/1998),
	('P7','Eric Cantona',10/02/1995)


GO

INSERT INTO TracksDataView VALUES 
(1,1, 3718, 148.72, 0.49507, 0.4918, 0.46713, 0.34605, 0.94821, 0.46708, 0.68284, 0.28465, 0.04031, 0.49494, 0.34631, 0.82592),
(2,1, 3719, 148.76, 0.49228, 0.4901, 0.46733, 0.34628, 0.94802, 0.46709, 0.68302, 0.28453, 0.04028, 0.49491, 0.34633, 0.82591),
(3,1, 3720, 148.8, 0.4895, 0.48839, 0.46754, 0.34657, 0.94781, 0.46711, 0.68319, 0.28441, 0.04024, 0.49491, 0.34635, 0.82589),
(4,1, 3721, 148.84, 0.48678, 0.48673, 0.46775, 0.3468, 0.94758, 0.46718, 0.68336, 0.28429, 0.04019, 0.49491, 0.34637, 0.82591),
(5,1, 3722, 148.88, 0.48393, 0.48499, 0.46799, 0.34701, 0.94735, 0.46728, 0.68353, 0.28416, 0.04012, 0.49485, 0.3464, 0.82596),
(6,1, 3723, 148.92, 0.48114, 0.48328, 0.46824, 0.34721, 0.94711, 0.46737, 0.68369, 0.28404, 0.04003, 0.49468, 0.34641, 0.826),
(7,1, 3724, 148.96, 0.47836, 0.48158, 0.46849, 0.34742, 0.94689, 0.46747, 0.68384, 0.28392, 0.03986, 0.49426, 0.34642, 0.82605),
(8,1, 3725, 149, 0.47557, 0.47988, 0.46874, 0.34758, 0.94667, 0.46756, 0.68399, 0.2838, 0.03968, 0.49383, 0.34644, 0.82614),
(9,1, 3726, 149.04, 0.47279, 0.47817, 0.46902, 0.34762, 0.94645, 0.46765, 0.68412, 0.28368, 0.03965, 0.49385, 0.34646, 0.8264),
(10,1, 3727, 149.08, 0.47, 0.47647, 0.4693, 0.34765, 0.94624, 0.46775, 0.68424, 0.28356, 0.03968, 0.49405, 0.34648, 0.82668),
(11,1, 3728, 149.12, 0.46729, 0.47481, 0.46958, 0.34775, 0.94603, 0.46784, 0.68434, 0.28344, 0.03975, 0.4943, 0.34649, 0.8269),
(12,1, 3729, 149.16, 0.46443, 0.47306, 0.46987, 0.34791, 0.94579, 0.46799, 0.68444, 0.28332, 0.03975, 0.49435, 0.34651, 0.82707),
(13,1, 3730, 149.2, 0.46165, 0.47136, 0.47019, 0.34812, 0.94553, 0.46817, 0.68454, 0.2832, 0.03972, 0.49427, 0.34653, 0.82721),
(14,1, 3731, 149.24, 0.45886, 0.46966, 0.47054, 0.34832, 0.94529, 0.46835, 0.68463, 0.28308, 0.03971, 0.49418, 0.34655, 0.82734),
(15,1, 3732, 149.28, 0.45607, 0.46795, 0.47091, 0.34853, 0.94505, 0.46853, 0.6847, 0.28297, 0.03964, 0.49396, 0.34658, 0.82753),
(16,1, 3733, 149.32, 0.45329, 0.46625, 0.47129, 0.34873, 0.94482, 0.46871, 0.68473, 0.28285, 0.03948, 0.49355, 0.34662, 0.82779),
(17,1, 3734, 149.36, 0.4505, 0.46455, 0.47168, 0.34899, 0.94459, 0.4689, 0.68476, 0.28273, 0.03938, 0.49328, 0.34666, 0.82806),
(18,1, 3735, 149.4, 0.44779, 0.46289, 0.47206, 0.3493, 0.94437, 0.46908, 0.68476, 0.28262, 0.03934, 0.49316, 0.34671, 0.82834),
(19,1, 3736, 149.44, 0.44493, 0.46114, 0.47244, 0.34961, 0.94415, 0.46926, 0.68472, 0.2825, 0.03934, 0.49319, 0.34675, 0.82864),
(20,1, 3737, 149.48, 0.44215, 0.45944, 0.47283, 0.34992, 0.9439, 0.46951, 0.68466, 0.28239, 0.03935, 0.49324, 0.3468, 0.82889),
(21,1, 3738, 149.52, 0.43936, 0.45773, 0.47323, 0.35023, 0.9436, 0.46987, 0.68459, 0.28227, 0.03935, 0.49324, 0.34684, 0.82907),
(22,1, 3739, 149.56, 0.43665, 0.45607, 0.47362, 0.35054, 0.94329, 0.47023, 0.68451, 0.28216, 0.03932, 0.49314, 0.34687, 0.82925)



GO


INSERT INTO EventsDataView VALUES 
(1,'Team1', 'SET PIECE', 'KICK OFF', 1, 3718, 148.72, 3718, 148.72, 'Player1(T1)', '', null, null, null, null),
(2,'Team1', 'PASS', '', 1, 3718, 148.72, 3742, 149.68, 'Player1(T1)', 'Player2(T1)', 0.5, 0.49, 0.43, 0.45),
(3,'Team1', 'PASS', '', 1, 3774, 150.96, 3809, 152.36, 'Player2(T1)', 'Player3(T1)', 0.43, 0.47, 0.37, 0.85),
(4,'Team1', 'PASS', '', 1, 3840, 153.6, 3875, 155, 'Player3(T1)', 'Player4(T1)', 0.37, 0.84, 0.25, 0.64),
(5,'Team1', 'PASS', '', 1, 3907, 156.28, 3959, 158.36, 'Player4(T1)', 'Player5(T1)', 0.25, 0.59, 0.28, 0.26),
(6,'Team1', 'PASS', '', 1, 4163, 166.52, 4181, 167.24, 'Player5(T1)', 'Player6(T1)', 0.35, 0.29, 0.4, 0.41),
(7,'Team1', 'PASS', '', 1, 4208, 168.32, 4243, 169.72, 'Player6(T1)', 'Player2(T1)', 0.42, 0.36, 0.42, 0.04),
(8,'Team1', 'PASS', '', 1, 4283, 171.32, 4303, 172.12, 'Player2(T1)', 'Player7(T1)', 0.44, 0.07, 0.53, 0),
(9,'Team1', 'PASS', '', 1, 4356, 174.24, 4379, 175.16, 'Player7(T1)', 'Player2(T1)', 0.49, 0.01, 0.46, 0.17),
(10,'Team1', 'BALL LOST', '', 1, 4410, 176.4, 4455, 178.2, 'Player2(T1)', '', 0.44, 0.21, 0.56, 0.79),
(11,'Team2', 'RECOVERY', 'INTERCEPTION', 1, 4455, 178.2, 4455, 178.2, 'Player1(T2)', '', 0.55, 0.8, null, null),
(12,'Team2', 'BALL LOST', 'INTERCEPTION', 1, 4455, 178.2, 4493, 179.72, 'Player1(T2)', '', 0.55, 0.8, 0.43, 0.62),
(13,'Team1', 'RECOVERY', '', 1, 4491, 179.64, 4491, 179.64, 'Player6(T1)', '', 0.44, 0.62, null, null),
(14,'Team1', 'BALL OUT', '', 1, 4491, 179.64, 4551, 182.04, 'Player6(T1)', '', 0.44, 0.62, 0.58, 1.04),
(15,'Team2', 'SET PIECE', 'THROW IN', 1, 4654, 186.16, 4654, 186.16, 'Player1(T2)', '', null, null, null, null),
(16,'Team2', 'PASS', '', 1, 4654, 186.16, 4691, 187.64, 'Player1(T2)', 'Player2T2)', 0.61, 1, 0.75, 0.93),
(17,'Team2', 'PASS', '', 1, 4801, 192.04, 4821, 192.84, 'Player2(T2)', 'Player3(T2)', 0.73, 0.75, 0.7, 0.6),
(18,'Team2', 'PASS', '', 1, 4821, 192.84, 4872, 194.88, 'Player3(T2)', 'Player1(T2)', 0.7, 0.6, 0.58, 0.96),
(19,'Team2', 'PASS', '', 1, 4981, 199.24, 5036, 201.44, 'Player1(T2)', 'Player2(T2)', 0.39, 0.94, 0.55, 0.88),
(20,'Team2', 'PASS', '', 1, 5056, 202.24, 5078, 203.12, 'Player2(T2)', 'Player3(T2)', 0.55, 0.86, 0.52, 0.66),
(21,'Team2', 'BALL LOST', 'INTERCEPTION', 1, 5090, 203.6, 5090, 203.6, 'Player3(T2)', '', 0.52, 0.66, 0.53, 0.69),
(22,'Team1', 'RECOVERY', 'INTERCEPTION', 1, 5103, 204.12, 5103, 204.12, 'Player8(T1)', '', 0.52, 0.71, null, null),
(23,'Team1', 'PASS', '', 1, 5103, 204.12, 5139, 205.56, 'Player8(T1)', 'Player9(T1)', 0.52, 0.71, 0.48, 0.81),
(24,'Team2', 'CHALLENGE', 'TACKLE-LOST', 1, 5137, 205.48, 5137, 205.48, 'Player2T2)', '', 0.5, 0.82, null, null),
(25,'Team1', 'BALL LOST', 'INTERCEPTION', 1, 5139, 205.56, 5139, 205.56, 'Player9(T1)', '', 0.48, 0.81, 0.48, 0.79),
(26,'Team2', 'RECOVERY', 'INTERCEPTION', 1, 5184, 207.36, 5184, 207.36, 'Player3(T2)', '', 0.54, 0.73, null, null),
(27,'Team2', 'PASS', '', 1, 5187, 209.36, 5184, 207.36, 'Player3(T2)', 'Player4(T2)', 0.52, 0.66, 0.53, 0.69),
(28,'Team2', 'SHOT', 'NO-GOAL', 1, 5187, 209.36, 5184, 207.36, 'Player4(T2)', '', 0.53, 0.69, null, null),
(29,'Team2', 'SHOT', 'GOAL', 1, 5187, 209.36, 5184, 207.36, 'Player4(T2)', '', 0.33, 0.68, null, null),
(30,'Team1', 'CARD', 'YELLOW', 1, 5187, 209.36, 5184, 207.36, 'Player6(T1)', '', 0.34, 0.7, null, null)





