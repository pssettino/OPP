USE [farmacia]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[cliente_id] [int] IDENTITY(1,1) NOT NULL,
	[dni] [nvarchar](50) NULL,
	[apellido] [nvarchar](80) NULL,
	[nombre] [nvarchar](80) NULL,
	[nombreCompleto] [nvarchar](160) NULL,
	[telefono] [nvarchar](50) NULL,
	[email] [nvarchar](100) NULL,
	[direccion] [nvarchar](255) NULL,
	[localidad_fk] [int] NULL,
	[provincia_fk] [int] NULL,
	[fecha_alta] [date] NULL,
	[eliminado] [bit] NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Cliente_cliente_id] UNIQUE NONCLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
