USE [farmacia]
GO
/****** Object:  Table [dbo].[Bitacora]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bitacora](
	[bitacora_id] [int] IDENTITY(1,1) NOT NULL,
	[usuario_fk] [int] NULL,
	[descripcion] [nvarchar](255) NULL,
	[fecha_hora] [datetime] NULL,
	[criticidad] [nvarchar](50) NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Bitacora] PRIMARY KEY CLUSTERED 
(
	[bitacora_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Bitacora_bitacora_id] UNIQUE NONCLUSTERED 
(
	[bitacora_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
