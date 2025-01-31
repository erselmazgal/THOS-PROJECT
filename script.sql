USE [master]
GO
/****** Object:  Database [ThosCafeTask]    Script Date: 30.10.2024 21:39:35 ******/
CREATE DATABASE [ThosCafeTask]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ThosCafeTask', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ThosCafeTask.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ThosCafeTask_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ThosCafeTask_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ThosCafeTask] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ThosCafeTask].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ThosCafeTask] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ThosCafeTask] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ThosCafeTask] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ThosCafeTask] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ThosCafeTask] SET ARITHABORT OFF 
GO
ALTER DATABASE [ThosCafeTask] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ThosCafeTask] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ThosCafeTask] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ThosCafeTask] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ThosCafeTask] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ThosCafeTask] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ThosCafeTask] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ThosCafeTask] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ThosCafeTask] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ThosCafeTask] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ThosCafeTask] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ThosCafeTask] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ThosCafeTask] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ThosCafeTask] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ThosCafeTask] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ThosCafeTask] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [ThosCafeTask] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ThosCafeTask] SET RECOVERY FULL 
GO
ALTER DATABASE [ThosCafeTask] SET  MULTI_USER 
GO
ALTER DATABASE [ThosCafeTask] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ThosCafeTask] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ThosCafeTask] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ThosCafeTask] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ThosCafeTask] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ThosCafeTask] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ThosCafeTask', N'ON'
GO
ALTER DATABASE [ThosCafeTask] SET QUERY_STORE = OFF
GO
USE [ThosCafeTask]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 30.10.2024 21:39:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 30.10.2024 21:39:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](max) NULL,
	[ParentCategoryId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatorUserId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductProperties]    Script Date: 30.10.2024 21:39:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductProperties](
	[ProductPropertyId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[PropertyId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.ProductProperties] PRIMARY KEY CLUSTERED 
(
	[ProductPropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 30.10.2024 21:39:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](max) NULL,
	[CategoryId] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[ImagePath] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatorUserId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Products] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Properties]    Script Date: 30.10.2024 21:39:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Properties](
	[PropertyId] [int] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](max) NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Properties] PRIMARY KEY CLUSTERED 
(
	[PropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 30.10.2024 21:39:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Surname] [nvarchar](max) NULL,
	[UserName] [nvarchar](max) NULL,
	[HashPassword] [nvarchar](max) NULL,
	[SaltPassword] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202410251853496_InitialCreate', N'Thos_project.DAL.qweqweqweDB', 0x1F8B0800000000000400ED5ACD6EDB4610BE17E83B103CB58023DACE2535A404B664B742E3D8089D5C8B153992D890BBECEED2B19EAD873E525FA1B3FCFF9548919202A4306088BB3BDFCE0CBF597266F8EFDFFF8CDFBD78AEF60C5C388C4EF48BD1B9AE01B598EDD0D5440FE4F2D51BFDDDDB1F7F18DFDADE8BF63959F75AAD43492A26FA5A4AFFCA3084B5068F8891E7589C09B694238B7906B19971797EFE8B7171610042E888A569E38F01958E07E1055E4E19B5C0970171EF990DAE88C771C60C51B50FC403E1130B26FAD39A893F7CCEFE044B8E66D7EF75EDDA7508EA6182BBD43542299344A296579F04989233BA327D1C20EED3C6075CB724AE8058FBAB6C795B43CE2F952146269840598190CCEB0878F13AF68C5116DFCBBF7AEA39F4DD2DFA586E94D5A1FF26FA94485831BED1B5F266575397AB8525F746776394C89D69F9D9B3940EC81AF577A64D0357061C261402C9897BA63D060BD7B17E87CD13FB02744203D7CDAB884AE25C6100871E39F381CBCD475896149FDBBA6614E58D32402A5E231B9938A7F2F5A5AE7D4065C8C28594113977989271F815287094B61F8994C0F186CE6D087D5AD1A2614F7595EC8A54C498D2B57BF2F21EE84AAE273AFED4B53BE705EC6424D6E4137530045148F200766DF648386AD568E676E1B998810B68632275C3980B84D6B86787C91C94AB66F82F8152BF9F1CE5817DB018C7F8E5BBEF5A1E6A6C649CDF1A09B8A11D58B26B20C462278B8378FF7DC220277AAC2888B73C4A10B48FF25D3A3B564660B01C8FB8BAF6C8F157FC847CA36BA645146077F4B94756807E5C1FDC1FDF775C27FBEE19DF89F8A9E33C99E811EF798823C77DFF506CABFABE54D997232727471F561C9D0EA8D3C18FBBCFC40D867EC8B466923ACFBAB248C99C8C41C901DC953DED0EEEE1987394370733E0F418FB28E71DC5A0DF88583F1221BE326E1FDE7BC49507DA6C7BFC4D1995C44166C58AA8509A92253C11F1657653138EE8FF382245BC5BD1B008D6045949963335A222C3289B32B663A4694605229D6987903DAC9A90B215BB11B740B5C3884EBC8A7C345C770FD3BB9555768CA8B49394808C861AD0F89EF83ED22957138A4734332A084D5F99DD6B255E846158A2A664926A9BEE84E718BEB99766716BD4F4CEE142E22B31591045E8A9ED559695B8D9E0DB64B312FDCAC779E6F54440FDCE82205F1B1B35A1645EBC43C33C3C8E431B2155A6598150586540846FC9C1A6CC0D3CBAAB7AD3062D3A33EBF0A299F688D542491EB53ADB1E39976DE52173C31DECCE275C05B3F3131DF1B2A4AB82984D5531C746892565321A1536965E29CAEC6EC5FDE470EC45FD069016CC6F946C245696F01418D554AD698155657D61A27B180D13947179A4A85738D42158B222482158B2E1FF03EFB48197BE070C11804D60ED03B119614710E5B3DD9A506A4EA45B600F15EC4D0A6ED1EC74E41886153DE8D09D077BF8B7092D2C64E461C281F6F27191228F100F7D33F7387C83EF757FEB105ADCDB7AB1264FD69DA9CD8769134AF519DBF5E19AD60EF220E9607B9CAC3650B6A8AB46C5E43F8F569CE9606321C32F185A983932872B99657949BA7B9A619632C9719CD5EDFEE4A092E6454B545F883D3BB64AF1CC8D90E08DD48291F9973B751DB4375B704FA8B30421A3BA9D7E797E7159FA6EE1DBF986C010C2765B7E4870F25EBEA3BCBCB3CCD8B54F55D3BEA7CF845B6BC27FF2C8CBCF79C43E2DFA50FB6E5095C6DEC2914334F56CFC2D076BEA950C1BA2557FE276F9418856D321EFC5B39D0CEBDE03B70FDE03EF65F1F71A0EF5EFC2A7EF2E1F324CFAB2BA56D7819BC927EFE71EE406E45AB8BDA2B5D0A6ED80D4AD157BB28EE8417C3FD8C3A1D4E8EC85556E66F602AB6B58F6B3B4A6293918DBCA8DC76A0F6880BE629460E06368C1D08048D178D6013144DFB16E8778B2357E97AEE496FDE2452D0DDBDDBC6CD8AAED1E5B9B9B75D86A46D453A845DFB39A858E8DFCE7F1E31908679541A88FE529582ABDCB40933573BA648923D0A2BC46C99252ACDC8324F8B243AED1394B12DE0C0B84081BF8E1713DD16FBD05D873FA10483F90D74280B7700B85AFB1B17DFFB0B95BD479FCE0AB2B318409A8A6A3DED71EE84DE0B876AAF75DCD03BD014205717C66A356A65467F76A93227D60B42550ECBE19F840D589FF049EEF229878A02679867D74437ABD8715B1364931A11964F78D28BA7D3C73C88A134FC418993C5E22876DEFE5ED7F4D38AB2825320000, N'6.5.1')
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202410251853496_InitialCreate', N'Thos_project.DAL.ThosCafeTaskDB', 0x1F8B0800000000000400ED5ACD6EDB4610BE17E83B103CB58023DACE2535A404B664B742E3D8089D5C8B153992D890BBECEED2B19EAD873E525FA1B3FCFF9548919202A4306088BB3BDFCE0CBF597266F8EFDFFF8CDFBD78AEF60C5C388C4EF48BD1B9AE01B598EDD0D5440FE4F2D51BFDDDDB1F7F18DFDADE8BF63959F75AAD43492A26FA5A4AFFCA3084B5068F8891E7589C09B694238B7906B19971797EFE8B7171610042E888A569E38F01958E07E1055E4E19B5C0970171EF990DAE88C771C60C51B50FC403E1130B26FAD39A893F7CCEFE044B8E66D7EF75EDDA7508EA6182BBD43542299344A296579F04989233BA327D1C20EED3C6075CB724AE8058FBAB6C795B43CE2F952146269840598190CCEB0878F13AF68C5116DFCBBF7AEA39F4DD2DFA586E94D5A1FF26FA94485831BED1B5F266575397AB8525F746776394C89D69F9D9B3940EC81AF577A64D0357061C261402C9897BA63D060BD7B17E87CD13FB02744203D7CDAB884AE25C6100871E39F381CBCD475896149FDBBA6614E58D32402A5E231B9938A7F2F5A5AE7D4065C8C28594113977989271F815287094B61F8994C0F186CE6D087D5AD1A2614F7595EC8A54C498D2B57BF2F21EE84AAE273AFED4B53BE705EC6424D6E4137530045148F200766DF648386AD568E676E1B998810B68632275C3980B84D6B86787C91C94AB66F82F8152BF9F1CE5817DB018C7F8E5BBEF5A1E6A6C649CDF1A09B8A11D58B26B20C462278B8378FF7DC220277AAC2888B73C4A10B48FF25D3A3B564660B01C8FB8BAF6C8F157FC847CA36BA645146077F4B94756807E5C1FDC1FDF775C27FBEE19DF89F8A9E33C99E811EF798823C77DFF506CABFABE54D997232727471F561C9D0EA8D3C18FBBCFC40D867EC8B466923ACFBAB248C99C8C41C901DC953DED0EEEE1987394370733E0F418FB28E71DC5A0DF88583F1221BE326E1FDE7BC49507DA6C7BFC4D1995C44166C58AA8509A92253C11F1657653138EE8FF382245BC5BD1B008D6045949963335A222C3289B32B663A4694605229D6987903DAC9A90B215BB11B740B5C3884EBC8A7C345C770FD3BB9555768CA8B49394808C861AD0F89EF83ED22957138A4734332A084D5F99DD6B255E846158A2A664926A9BEE84E718BEB99766716BD4F4CEE142E22B31591045E8A9ED559695B8D9E0DB64B312FDCAC779E6F54440FDCE82205F1B1B35A1645EBC43C33C3C8E431B2155A6598150586540846FC9C1A6CC0D3CBAAB7AD3062D3A33EBF0A299F688D542491EB53ADB1E39976DE52173C31DECCE275C05B3F3131DF1B2A4AB82984D5531C746892565321A1536965E29CAEC6EC5FDE470EC45FD069016CC6F946C245696F01418D554AD698155657D61A27B180D13947179A4A85738D42158B222482158B2E1FF03EFB48197BE070C11804D60ED03B119614710E5B3DD9A506A4EA45B600F15EC4D0A6ED1EC74E41886153DE8D09D077BF8B7092D2C64E461C281F6F27191228F100F7D33F7387C83EF757FEB105ADCDB7AB1264FD69DA9CD8769134AF519DBF5E19AD60EF220E9607B9CAC3650B6A8AB46C5E43F8F569CE9606321C32F185A983932872B99657949BA7B9A619632C9719CD5EDFEE4A092E6454B545F883D3BB64AF1CC8D90E08DD48291F9973B751DB4375B704FA8B30421A3BA9D7E797E7159FA6EE1DBF986C010C2765B7E4870F25EBEA3BCBCB3CCD8B54F55D3BEA7CF845B6BC27FF2C8CBCF79C43E2DFA50FB6E5095C6DEC2914334F56CFC2D076BEA950C1BA2557FE276F9418856D321EFC5B39D0CEBDE03B70FDE03EF65F1F71A0EF5EFC2A7EF2E1F324CFAB2BA56D7819BC927EFE71EE406E45AB8BDA2B5D0A6ED80D4AD157BB28EE8417C3FD8C3A1D4E8EC85556E66F602AB6B58F6B3B4A6293918DBCA8DC76A0F6880BE629460E06368C1D08048D178D6013144DFB16E8778B2357E97AEE496FDE2452D0DDBDDBC6CD8AAED1E5B9B9B75D86A46D453A845DFB39A858E8DFCE7F1E31908679541A88FE529582ABDCB40933573BA648923D0A2BC46C99252ACDC8324F8B243AED1394B12DE0C0B84081BF8E1713DD16FBD05D873FA10483F90D74280B7700B85AFB1B17DFFB0B95BD479FCE0AB2B318409A8A6A3DED71EE84DE0B876AAF75DCD03BD014205717C66A356A65467F76A93227D60B42550ECBE19F840D589FF049EEF229878A02679867D74437ABD8715B1364931A11964F78D28BA7D3C73C88A134FC418993C5E22876DEFE5ED7F4D38AB2825320000, N'6.5.1')
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryId], [CategoryName], [ParentCategoryId], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (1, N'test', NULL, 1, CAST(N'2024-10-25T21:57:48.920' AS DateTime), 0)
INSERT [dbo].[Categories] ([CategoryId], [CategoryName], [ParentCategoryId], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (2, N'test2', NULL, 1, CAST(N'2024-10-25T22:05:22.033' AS DateTime), 0)
INSERT [dbo].[Categories] ([CategoryId], [CategoryName], [ParentCategoryId], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (3, N'İçecekler', NULL, 0, CAST(N'2024-10-26T20:25:39.480' AS DateTime), 0)
INSERT [dbo].[Categories] ([CategoryId], [CategoryName], [ParentCategoryId], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (4, N'Tatlılar', NULL, 0, CAST(N'2024-10-26T20:25:49.177' AS DateTime), 0)
INSERT [dbo].[Categories] ([CategoryId], [CategoryName], [ParentCategoryId], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (5, N'Ana Yemekler', NULL, 0, CAST(N'2024-10-26T20:25:57.253' AS DateTime), 0)
INSERT [dbo].[Categories] ([CategoryId], [CategoryName], [ParentCategoryId], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (6, N'Fastfood', NULL, 0, CAST(N'2024-10-26T20:26:02.393' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductProperties] ON 

INSERT [dbo].[ProductProperties] ([ProductPropertyId], [ProductId], [PropertyId]) VALUES (3, 5, 5)
INSERT [dbo].[ProductProperties] ([ProductPropertyId], [ProductId], [PropertyId]) VALUES (4, 16, 6)
INSERT [dbo].[ProductProperties] ([ProductPropertyId], [ProductId], [PropertyId]) VALUES (5, 15, 5)
INSERT [dbo].[ProductProperties] ([ProductPropertyId], [ProductId], [PropertyId]) VALUES (6, 17, 6)
INSERT [dbo].[ProductProperties] ([ProductPropertyId], [ProductId], [PropertyId]) VALUES (7, 18, 6)
INSERT [dbo].[ProductProperties] ([ProductPropertyId], [ProductId], [PropertyId]) VALUES (8, 19, 6)
INSERT [dbo].[ProductProperties] ([ProductPropertyId], [ProductId], [PropertyId]) VALUES (9, 20, 7)
INSERT [dbo].[ProductProperties] ([ProductPropertyId], [ProductId], [PropertyId]) VALUES (10, 21, 7)
SET IDENTITY_INSERT [dbo].[ProductProperties] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (1, N'test', 2, CAST(100.00 AS Decimal(18, 2)), N'System.Web.HttpPostedFileWrapper', 1, CAST(N'2024-10-25T22:22:39.237' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (2, N'test222', 2, CAST(22222.00 AS Decimal(18, 2)), N'System.Web.HttpPostedFileWrapper', 1, CAST(N'2024-10-25T22:27:15.677' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (3, N'deneme2', 1, CAST(2222.00 AS Decimal(18, 2)), N'System.Web.HttpPostedFileWrapper', 1, CAST(N'2024-10-25T22:31:32.067' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (4, N'test', 2, CAST(1111.00 AS Decimal(18, 2)), N'System.Web.HttpPostedFileWrapper', 1, CAST(N'2024-10-26T00:01:59.343' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (5, N'Hamburger', 2, CAST(200.00 AS Decimal(18, 2)), N'System.Web.HttpPostedFileWrapper', 1, CAST(N'2024-10-26T19:22:20.273' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (6, N'123', 2, CAST(123.00 AS Decimal(18, 2)), N'System.Web.HttpPostedFileWrapper', 1, CAST(N'2024-10-26T19:49:31.923' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (7, N'123', 2, CAST(123.00 AS Decimal(18, 2)), N'System.Web.HttpPostedFileWrapper', 1, CAST(N'2024-10-26T20:00:49.537' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (8, N'123', 2, CAST(223.00 AS Decimal(18, 2)), N'ersel.png', 1, CAST(N'2024-10-26T20:05:24.187' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (9, N'Hamburger', 6, CAST(300.00 AS Decimal(18, 2)), N'/Images/aaaa.jpg', 1, CAST(N'2024-10-26T20:27:37.180' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (10, N'123', 4, CAST(2.00 AS Decimal(18, 2)), N'istockphoto-1309352410-612x612.jpg', 1, CAST(N'2024-10-26T20:34:11.213' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (11, N'123', 4, CAST(2.00 AS Decimal(18, 2)), N'aaaa.jpg', 1, CAST(N'2024-10-26T20:34:23.660' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (12, N'12', 3, CAST(3123.00 AS Decimal(18, 2)), N'aaaa.jpg', 1, CAST(N'2024-10-26T20:37:45.950' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (13, N'12', 3, CAST(1.00 AS Decimal(18, 2)), N'ersel.png', 1, CAST(N'2024-10-26T20:44:50.750' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (14, N'Hamburger', 6, CAST(400.00 AS Decimal(18, 2)), N'aaaa.jpg', 0, CAST(N'2024-10-26T20:47:35.123' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (15, N'Pizza', 6, CAST(450.00 AS Decimal(18, 2)), N'istockphoto-1459715799-612x612.jpg', 0, CAST(N'2024-10-26T20:48:31.210' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (16, N'Kola', 3, CAST(50.00 AS Decimal(18, 2)), N'istockphoto-1393991948-612x612.jpg', 0, CAST(N'2024-10-26T20:48:59.120' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (17, N'Ayran', 3, CAST(40.00 AS Decimal(18, 2)), N'istockphoto-1270306337-612x612.jpg', 0, CAST(N'2024-10-26T20:49:30.633' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (18, N'Baklava', 4, CAST(300.00 AS Decimal(18, 2)), N'istockphoto-1218839959-612x612.jpg', 0, CAST(N'2024-10-26T20:49:56.007' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (19, N'Tiramisu', 4, CAST(300.00 AS Decimal(18, 2)), N'istockphoto-1248489319-612x612.jpg', 0, CAST(N'2024-10-26T20:50:23.807' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (20, N'Kebap', 5, CAST(350.00 AS Decimal(18, 2)), N'istockphoto-1408897449-612x612.jpg', 0, CAST(N'2024-10-26T20:50:45.500' AS DateTime), 0)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [Price], [ImagePath], [IsDeleted], [CreatedDate], [CreatorUserId]) VALUES (21, N'Et Döner', 5, CAST(350.00 AS Decimal(18, 2)), N'istockphoto-915458648-612x612.jpg', 0, CAST(N'2024-10-26T20:51:13.423' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Properties] ON 

INSERT [dbo].[Properties] ([PropertyId], [Key], [Value]) VALUES (5, N'sıcak', N'1')
INSERT [dbo].[Properties] ([PropertyId], [Key], [Value]) VALUES (6, N'soğuk', N'2')
INSERT [dbo].[Properties] ([PropertyId], [Key], [Value]) VALUES (7, N'çok sıcak', N'3')
SET IDENTITY_INSERT [dbo].[Properties] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [Name], [Surname], [UserName], [HashPassword], [SaltPassword]) VALUES (3, N'hasan', N'deveci', N'hasan', N'u3xK3d5Un/EjCdqUuvoTQCk71GDaj5yMaonQAePCysA=', N'Hy5rzIJ4HcrfmPkxgOEVGg==')
INSERT [dbo].[Users] ([UserId], [Name], [Surname], [UserName], [HashPassword], [SaltPassword]) VALUES (4, N'ersel', N'test', N'admin', N's6WBgWBM5O9+XOqtCPN9RAHVK+wvF9OhusRmj2c9vsY=', N'PlIuPTY9DfbMr63DFgwesg==')
INSERT [dbo].[Users] ([UserId], [Name], [Surname], [UserName], [HashPassword], [SaltPassword]) VALUES (9, N'wqsada', N'asdasd', N'123123', N'nG8BP5RhaES3zkU2PwZuHv930AcTRyu04Fi6xzXx3Ms=', N'YmMZiwl27Knl7hlJpSbY3w==')
INSERT [dbo].[Users] ([UserId], [Name], [Surname], [UserName], [HashPassword], [SaltPassword]) VALUES (10, N'Yiğit', N'Kılıç', N'yigit', N'FYpA0O2rXIsniITr6B0X+JasgZ0EMiBcvbDm5KYPOOo=', N'+kzLFF47/CWfkgMMu+stsw==')
INSERT [dbo].[Users] ([UserId], [Name], [Surname], [UserName], [HashPassword], [SaltPassword]) VALUES (11, N'Yavuz', N'Gül', N'yavuz', N'zEVCpSRLDVKuj7JOfWMXQ94nut58nURLZd+EGYwQOmQ=', N'3KrxLXnbyKTlc32z2dRcgg==')
INSERT [dbo].[Users] ([UserId], [Name], [Surname], [UserName], [HashPassword], [SaltPassword]) VALUES (12, N'ahmet', N'mazgal', N'ahmet', N'5lbqJFIT7MjmeXKNmpZdnqx2Rgivir8fsUcd161SzO8=', N'uQBJzf+VYJLnHkuKbJ8a5g==')
INSERT [dbo].[Users] ([UserId], [Name], [Surname], [UserName], [HashPassword], [SaltPassword]) VALUES (13, N'test', N'test', N'test', N'PyOpwLJFTcJ6wHe9j8e++wTA10ItjYcB2Qn0CTMQ4yk=', N'ovzpNh7QzJRJaoGJCjHdGA==')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
USE [master]
GO
ALTER DATABASE [ThosCafeTask] SET  READ_WRITE 
GO
