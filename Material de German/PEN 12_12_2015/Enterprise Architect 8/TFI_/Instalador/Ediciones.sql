USE [Ediciones]
GO
/****** Object:  Table [dbo].[traduccion]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[traduccion](
	[tra_id] [int] NOT NULL,
	[tra_idio_id] [int] NOT NULL,
	[tra_texto] [varchar](255) NOT NULL,
	[tra_control] [varchar](255) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[vent_lib]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vent_lib](
	[vent_id] [int] NOT NULL,
	[lib_id] [int] NOT NULL,
	[vent_lib_cant] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vendedor]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Vendedor](
	[vend_id] [int] IDENTITY(1,1) NOT NULL,
	[vend_nom] [varchar](30) NOT NULL,
	[vend_legajo] [int] NOT NULL,
	[vend_ape] [varchar](30) NOT NULL,
	[vend_tel] [int] NOT NULL,
	[vend_activo] [bit] NOT NULL,
	[vend_email] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Patente]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Patente](
	[pat_id] [int] NOT NULL,
	[pat_nom] [varchar](15) NOT NULL,
	[pat_desc] [varchar](50) NOT NULL,
	[par_perm] [varchar](30) NOT NULL,
	[pat_dvh] [int] NOT NULL,
 CONSTRAINT [PK_Patente] PRIMARY KEY CLUSTERED 
(
	[pat_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Localidad]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Localidad](
	[loc_id] [int] NOT NULL,
	[loc_desc] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Localidad] PRIMARY KEY CLUSTERED 
(
	[loc_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Libro]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Libro](
	[lib_id] [int] IDENTITY(1,1) NOT NULL,
	[lib_desc] [varchar](100) NOT NULL,
	[lib_cant] [int] NOT NULL,
	[lib_precio] [int] NOT NULL,
	[lib_activo] [bit] NOT NULL,
	[lib_editorial] [varchar](100) NOT NULL,
	[lib_usu_id] [int] NOT NULL,
 CONSTRAINT [PK_Libro] PRIMARY KEY CLUSTERED 
(
	[lib_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_Libro] ON [dbo].[Libro] 
(
	[lib_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Idioma]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Idioma](
	[idio_id] [int] IDENTITY(1,1) NOT NULL,
	[idio_desc] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Idioma_1] PRIMARY KEY CLUSTERED 
(
	[idio_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Criticidad]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Criticidad](
	[crit_id] [int] IDENTITY(1,1) NOT NULL,
	[crit_desc] [nchar](20) NOT NULL,
	[crit_dvh] [int] NOT NULL,
 CONSTRAINT [PK_Criticidad] PRIMARY KEY CLUSTERED 
(
	[crit_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Familia]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Familia](
	[fam_id] [int] NOT NULL,
	[fam_nom] [varchar](15) NULL,
	[fam_desc] [varchar](50) NULL,
	[fam_patente] [varchar](30) NULL,
	[fam_dvh] [int] NOT NULL,
 CONSTRAINT [PK_Familia] PRIMARY KEY CLUSTERED 
(
	[fam_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DVV]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DVV](
	[iddvv] [int] NOT NULL,
	[dvv_tabla_nom] [nchar](10) NOT NULL,
	[dvv_dvv] [int] NOT NULL,
 CONSTRAINT [PK_DVV] PRIMARY KEY CLUSTERED 
(
	[iddvv] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Direccion]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Direccion](
	[dir_id] [int] NOT NULL,
	[dir_desc] [varchar](50) NOT NULL,
	[loc_id] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[clie_id] [int] IDENTITY(1,1) NOT NULL,
	[clie_nom] [varchar](30) NOT NULL,
	[clie_ape] [varchar](30) NOT NULL,
	[clie_dir] [varchar](30) NOT NULL,
	[clie_tel] [int] NOT NULL,
	[clie_saldo] [decimal](10, 0) NOT NULL,
	[clie_fec_alta] [datetime] NOT NULL,
	[clie_activo] [bit] NOT NULL,
	[clie_dni] [int] NOT NULL,
	[clie_email] [varchar](50) NOT NULL,
	[clie_dvh] [int] NOT NULL,
	[clie_usu_id] [int] NOT NULL,
	[clie_dir_id] [int] NOT NULL,
	[clie_lib_id] [int] NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[clie_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_Cliente] ON [dbo].[Cliente] 
(
	[clie_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usu-pat]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usu-pat](
	[tipo] [bit] NULL,
	[pat-id] [int] NOT NULL,
	[usu-id] [int] NOT NULL,
	[dvh] [int] NULL,
 CONSTRAINT [PK_usu-pat] PRIMARY KEY CLUSTERED 
(
	[pat-id] ASC,
	[usu-id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[usu_id] [int] IDENTITY(1,1) NOT NULL,
	[usu_nom] [varchar](30) NOT NULL,
	[usu_ape] [varchar](30) NOT NULL,
	[usu_dni] [int] NOT NULL,
	[usu_pass] [varchar](20) NOT NULL,
	[usu_log] [varchar](30) NOT NULL,
	[usu_dvh] [int] NOT NULL,
	[usu_activo] [bit] NOT NULL,
	[usu_ciii] [int] NOT NULL,
	[usu_bloqueado] [bit] NULL,
	[usu_email] [varchar](50) NULL,
	[usu_idio_id] [int] NOT NULL,
	[usu_pat_id] [int] NULL,
	[usu_fam_id] [int] NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[usu_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[pat-fam]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pat-fam](
	[pat-id] [int] NOT NULL,
	[fam-id] [int] NOT NULL,
	[dvh] [int] NULL,
 CONSTRAINT [PK_pat-fam] PRIMARY KEY CLUSTERED 
(
	[pat-id] ASC,
	[fam-id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venta]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta](
	[vent_id] [int] IDENTITY(1,1) NOT NULL,
	[vent_clie_id] [int] NOT NULL,
	[vent_vend_id] [int] NOT NULL,
	[vent_usu_id] [int] NOT NULL,
	[vent_lib_id] [int] NOT NULL,
	[vent_importe] [decimal](18, 0) NOT NULL,
	[vent_activo] [bit] NOT NULL,
	[vent_cuotas] [int] NOT NULL,
	[vent_fecha] [datetime] NOT NULL,
	[vent_dvh] [int] NOT NULL,
	[vent_valorcuota] [int] NULL,
 CONSTRAINT [PK_Venta] PRIMARY KEY CLUSTERED 
(
	[vent_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fam-usu]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fam-usu](
	[fam-id] [int] NOT NULL,
	[usu-id] [int] NOT NULL,
	[dvh] [int] NULL,
 CONSTRAINT [PK_fam-usu] PRIMARY KEY CLUSTERED 
(
	[fam-id] ASC,
	[usu-id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bitacora]    Script Date: 11/24/2012 21:31:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bitacora](
	[bit_id] [int] IDENTITY(1,1) NOT NULL,
	[bit_fecha] [datetime] NOT NULL,
	[bit_desc] [varchar](50) NOT NULL,
	[bit_usu_log] [varchar](30) NOT NULL,
	[bit_dvh] [int] NOT NULL,
	[but_usu_id] [int] NOT NULL,
	[bit_crit_id] [int] NULL,
 CONSTRAINT [PK_Bitacora] PRIMARY KEY CLUSTERED 
(
	[bit_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  ForeignKey [FK_Direccion_Localidad]    Script Date: 11/24/2012 21:31:34 ******/
ALTER TABLE [dbo].[Direccion]  WITH CHECK ADD  CONSTRAINT [FK_Direccion_Localidad] FOREIGN KEY([loc_id])
REFERENCES [dbo].[Localidad] ([loc_id])
GO
ALTER TABLE [dbo].[Direccion] CHECK CONSTRAINT [FK_Direccion_Localidad]
GO
/****** Object:  ForeignKey [FK_Cliente_Libro]    Script Date: 11/24/2012 21:31:34 ******/
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Libro] FOREIGN KEY([clie_lib_id])
REFERENCES [dbo].[Libro] ([lib_id])
GO
ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [FK_Cliente_Libro]
GO
/****** Object:  ForeignKey [FK_usu-pat_Patente]    Script Date: 11/24/2012 21:31:34 ******/
ALTER TABLE [dbo].[usu-pat]  WITH CHECK ADD  CONSTRAINT [FK_usu-pat_Patente] FOREIGN KEY([pat-id])
REFERENCES [dbo].[Patente] ([pat_id])
GO
ALTER TABLE [dbo].[usu-pat] CHECK CONSTRAINT [FK_usu-pat_Patente]
GO
/****** Object:  ForeignKey [FK_Usuario_Idioma1]    Script Date: 11/24/2012 21:31:34 ******/
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Idioma1] FOREIGN KEY([usu_idio_id])
REFERENCES [dbo].[Idioma] ([idio_id])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Idioma1]
GO
/****** Object:  ForeignKey [FK_pat-fam_Familia]    Script Date: 11/24/2012 21:31:34 ******/
ALTER TABLE [dbo].[pat-fam]  WITH CHECK ADD  CONSTRAINT [FK_pat-fam_Familia] FOREIGN KEY([fam-id])
REFERENCES [dbo].[Familia] ([fam_id])
GO
ALTER TABLE [dbo].[pat-fam] CHECK CONSTRAINT [FK_pat-fam_Familia]
GO
/****** Object:  ForeignKey [FK_pat-fam_Patente]    Script Date: 11/24/2012 21:31:34 ******/
ALTER TABLE [dbo].[pat-fam]  WITH CHECK ADD  CONSTRAINT [FK_pat-fam_Patente] FOREIGN KEY([pat-id])
REFERENCES [dbo].[Patente] ([pat_id])
GO
ALTER TABLE [dbo].[pat-fam] CHECK CONSTRAINT [FK_pat-fam_Patente]
GO
/****** Object:  ForeignKey [FK_Venta_Cliente]    Script Date: 11/24/2012 21:31:34 ******/
ALTER TABLE [dbo].[Venta]  WITH CHECK ADD  CONSTRAINT [FK_Venta_Cliente] FOREIGN KEY([vent_clie_id])
REFERENCES [dbo].[Cliente] ([clie_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Venta] CHECK CONSTRAINT [FK_Venta_Cliente]
GO
/****** Object:  ForeignKey [FK_fam-usu_Familia]    Script Date: 11/24/2012 21:31:34 ******/
ALTER TABLE [dbo].[fam-usu]  WITH CHECK ADD  CONSTRAINT [FK_fam-usu_Familia] FOREIGN KEY([fam-id])
REFERENCES [dbo].[Familia] ([fam_id])
GO
ALTER TABLE [dbo].[fam-usu] CHECK CONSTRAINT [FK_fam-usu_Familia]
GO
/****** Object:  ForeignKey [FK_fam-usu_Usuario]    Script Date: 11/24/2012 21:31:34 ******/
ALTER TABLE [dbo].[fam-usu]  WITH CHECK ADD  CONSTRAINT [FK_fam-usu_Usuario] FOREIGN KEY([usu-id])
REFERENCES [dbo].[Usuario] ([usu_id])
GO
ALTER TABLE [dbo].[fam-usu] CHECK CONSTRAINT [FK_fam-usu_Usuario]
GO
/****** Object:  ForeignKey [FK_Bitacora_Criticidad]    Script Date: 11/24/2012 21:31:34 ******/
ALTER TABLE [dbo].[Bitacora]  WITH CHECK ADD  CONSTRAINT [FK_Bitacora_Criticidad] FOREIGN KEY([bit_crit_id])
REFERENCES [dbo].[Criticidad] ([crit_id])
GO
ALTER TABLE [dbo].[Bitacora] CHECK CONSTRAINT [FK_Bitacora_Criticidad]
GO
/****** Object:  ForeignKey [FK_Bitacora_Usuario]    Script Date: 11/24/2012 21:31:34 ******/
ALTER TABLE [dbo].[Bitacora]  WITH CHECK ADD  CONSTRAINT [FK_Bitacora_Usuario] FOREIGN KEY([but_usu_id])
REFERENCES [dbo].[Usuario] ([usu_id])
GO
ALTER TABLE [dbo].[Bitacora] CHECK CONSTRAINT [FK_Bitacora_Usuario]
GO
