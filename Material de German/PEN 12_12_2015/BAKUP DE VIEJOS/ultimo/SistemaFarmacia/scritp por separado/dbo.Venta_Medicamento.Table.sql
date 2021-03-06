USE [farmacia]
GO
/****** Object:  Table [dbo].[Venta_Medicamento]    Script Date: 16/11/2015 17:05:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Venta_Medicamento](
	[venta_medicamento_id] [int] IDENTITY(1,1) NOT NULL,
	[venta_id] [int] NULL,
	[medicamento_id] [int] NULL,
	[cantidad_venta] [int] NULL,
	[precio_venta] [float] NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Venta_Medicamento] PRIMARY KEY CLUSTERED 
(
	[venta_medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
