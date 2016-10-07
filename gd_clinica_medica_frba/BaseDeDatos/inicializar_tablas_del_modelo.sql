USE [GD2C2016]
GO
/****** Object:  Schema [LOS_TRIGGERS]    Script Date: 03/10/2016 18:39:01 ******/
CREATE SCHEMA [LOS_TRIGGERS]
GO
/****** Object:  Table [LOS_TRIGGERS].[Administrador]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LOS_TRIGGERS].[Administrador](
	[admi_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[admi_habilitacion] [numeric](18, 0) NULL,
 CONSTRAINT [PK_Administrador] PRIMARY KEY CLUSTERED 
(
	[admi_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [LOS_TRIGGERS].[Afiliado]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Afiliado](
	[afil_numero] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[afil_estado_civil] [varchar](10) NULL,
	[afil_habilitacion] [bit] NULL,
	[afil_titular_grupo_familiar] [numeric](18, 0) NULL,
	[afil_plan_medico] [numeric](18, 0) NULL,
	[afil_cant_consultas_realizadas] [numeric](4, 0) NULL,
 CONSTRAINT [PK_Afiliado] PRIMARY KEY CLUSTERED 
(
	[afil_numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LOS_TRIGGERS].[Agenda]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Agenda](
	[agen_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[agen_tipo] [char](10) NULL,
 CONSTRAINT [PK_Agenda] PRIMARY KEY CLUSTERED 
(
	[agen_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LOS_TRIGGERS].[Baja_Afiliado]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Baja_Afiliado](
	[baja_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[baja_fecha] [datetime] NULL,
	[baja_afiliado] [numeric](18, 0) NULL,
	[baja_detalle] [varchar](255) NULL,
 CONSTRAINT [PK_Baja_Afiliado] PRIMARY KEY CLUSTERED 
(
	[baja_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LOS_TRIGGERS].[Bono]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LOS_TRIGGERS].[Bono](
	[bono_numero] [numeric](18, 0) NOT NULL,
	[bono_plan_medico] [numeric](18, 0) NULL,
	[bono_afiliado] [numeric](18, 0) NULL,
	[bono_consulta_medica] [numeric](18, 0) NULL,
 CONSTRAINT [PK_Bono] PRIMARY KEY CLUSTERED 
(
	[bono_numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [LOS_TRIGGERS].[Cancelacion_Turno]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Cancelacion_Turno](
	[canc_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[canc_emisor] [numeric](18, 0) NULL,
	[canc_motivo] [varchar](255) NULL,
	[canc_tipo] [numeric](18, 0) NULL,
 CONSTRAINT [PK_Cancelacion_Turno] PRIMARY KEY CLUSTERED 
(
	[canc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LOS_TRIGGERS].[Compra_Bono]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LOS_TRIGGERS].[Compra_Bono](
	[comp_numero] [numeric](18, 0) NOT NULL,
	[comp_bono] [numeric](18, 0) NULL,
	[comp_afiliado] [numeric](18, 0) NULL,
	[comp_monto] [numeric](18, 0) NULL,
	[comp_cantidad] [numeric](4, 0) NULL,
 CONSTRAINT [PK_Compra_Bono] PRIMARY KEY CLUSTERED 
(
	[comp_numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [LOS_TRIGGERS].[Consulta_Medica]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LOS_TRIGGERS].[Consulta_Medica](
	[cons_numero] [numeric](18, 0) NOT NULL,
	[cons_diagnostico] [numeric](18, 0) NULL,
 CONSTRAINT [PK_Consulta_Medica] PRIMARY KEY CLUSTERED 
(
	[cons_numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [LOS_TRIGGERS].[Diagnostico]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Diagnostico](
	[diag_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[diag_fecha_y_hora] [datetime] NULL,
	[diag_sintomas] [varchar](255) NULL,
	[diag_descripcion] [varchar](255) NULL,
 CONSTRAINT [PK_Diagnostico] PRIMARY KEY CLUSTERED 
(
	[diag_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LOS_TRIGGERS].[Direccion]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Direccion](
	[dire_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[dire_calle] [varchar](50) NULL,
	[dire_numero] [numeric](8, 0) NULL,
	[dire_codigo_postal] [numeric](8, 0) NULL,
	[dire_ciudad] [varchar](50) NULL,
	[dire_provincia] [varchar](50) NULL,
	[dire_pais] [varchar](50) NULL,
	[dire_piso] [numeric](4, 0) NULL,
	[dire_departamento] [varchar](4) NULL,
 CONSTRAINT [PK_Direccion] PRIMARY KEY CLUSTERED 
(
	[dire_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LOS_TRIGGERS].[Especialidad]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Especialidad](
	[espe_codigo] [numeric](18, 0) NOT NULL,
	[espe_descripcion] [varchar](255) NULL,
	[espe_tipo] [numeric](18, 0) NULL,
 CONSTRAINT [PK_Especialidad] PRIMARY KEY CLUSTERED 
(
	[espe_codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LOS_TRIGGERS].[Especialidad_Profesional]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LOS_TRIGGERS].[Especialidad_Profesional](
	[profesional] [numeric](18, 0) NOT NULL,
	[especialidad] [numeric](18, 0) NOT NULL,
	[agenda] [numeric](18, 0) NULL,
 CONSTRAINT [PK_Especialidad_Profesional] PRIMARY KEY CLUSTERED 
(
	[profesional] ASC,
	[especialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [LOS_TRIGGERS].[Funcionalidad]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Funcionalidad](
	[func_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[func_nombre] [varchar](50) NULL,
 CONSTRAINT [PK_Funcionalidad] PRIMARY KEY CLUSTERED 
(
	[func_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LOS_TRIGGERS].[Funcionalidad_Rol]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LOS_TRIGGERS].[Funcionalidad_Rol](
	[rol] [numeric](18, 0) NOT NULL,
	[funcionalidad] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_Funcionalidad_Rol] PRIMARY KEY CLUSTERED 
(
	[rol] ASC,
	[funcionalidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [LOS_TRIGGERS].[Horario_Atencion]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Horario_Atencion](
	[hora_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[hora_agenda] [numeric](18, 0) NULL,
	[hora_dia_atencion] [char](10) NULL,
	[hora_inicio_atencion] [time](7) NULL,
	[hora_fin_atencion] [time](7) NULL,
	[hora_turno] [numeric](18, 0) NULL,
 CONSTRAINT [PK_Horario_Atencion] PRIMARY KEY CLUSTERED 
(
	[hora_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LOS_TRIGGERS].[Modificacion_Plan]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Modificacion_Plan](
	[modi_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[modi_fecha] [datetime] NULL,
	[modi_motivo] [varchar](255) NULL,
	[modi_plan_medico] [numeric](18, 0) NULL,
 CONSTRAINT [PK_Modificacion_Plan] PRIMARY KEY CLUSTERED 
(
	[modi_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LOS_TRIGGERS].[Plan_Medico]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Plan_Medico](
	[plan_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[plan_precio_bono_consulta] [numeric](18, 0) NULL,
	[plan_precio_bono_farmacia] [numeric](18, 0) NULL,
	[plan_med_descripcion] [varchar](255) NULL,
 CONSTRAINT [PK_Plan_Medico] PRIMARY KEY CLUSTERED 
(
	[plan_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LOS_TRIGGERS].[Profesional]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LOS_TRIGGERS].[Profesional](
	[prof_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[prof_matricula] [numeric](18, 0) NULL,
	[prof_horas_laborales] [numeric](4, 0) NULL,
	[prof_habilitacion] [bit] NULL,
 CONSTRAINT [PK_Profesional] PRIMARY KEY CLUSTERED 
(
	[prof_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [LOS_TRIGGERS].[Tipo_Cancelacion]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Tipo_Cancelacion](
	[tipo_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[tipo_descripcion] [varchar](255) NULL,
 CONSTRAINT [PK__Tipo_can__6EA5A01B707AD1E7] PRIMARY KEY CLUSTERED 
(
	[tipo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LOS_TRIGGERS].[Tipo_Especialidad]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Tipo_Especialidad](
	[tipo_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[tipo_descripcion] [varchar](255) NULL,
 CONSTRAINT [PK_Tipo Especialidad] PRIMARY KEY CLUSTERED 
(
	[tipo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LOS_TRIGGERS].[Turno]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LOS_TRIGGERS].[Turno](
	[turn_numero] [numeric](18, 0) NOT NULL,
	[turn_profesional] [numeric](18, 0) NULL,
	[turn_afiliado] [numeric](18, 0) NULL,
	[turn_fecha_atencion] [datetime] NULL,
	[turn_fecha_y_hora_asistencia] [datetime] NULL,
	[turn_consulta_medica] [numeric](18, 0) NULL,
	[turn_cancelacion] [numeric](18, 0) NULL,
 CONSTRAINT [PK_Turno] PRIMARY KEY CLUSTERED 
(
	[turn_numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [LOS_TRIGGERS].[Usuario]    Script Date: 03/10/2016 18:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Usuario](
	[user_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[user_name] [varchar](30) NULL,
	[user_password] [varchar](30) NULL,
	[user_intentos_fallidos_login] [numeric](1, 0) NULL,
	[user_nombre] [varchar](255) NULL,
	[user_apellido] [varchar](255) NULL,
	[user_documento_tipo] [varchar](10) NULL,
	[user_documento_numero] [numeric](18, 0) NULL,
	[user_telefono] [numeric](18, 0) NULL,
	[user_mail] [varchar](255) NULL,
	[user_fecha_nacimiento] [datetime] NULL,
	[user_sexo] [char](3) NULL,
	[user_direccion] [numeric](18, 0) NULL,
	[user_afiliado] [numeric](18, 0) NULL,
	[user_profesional] [numeric](18, 0) NULL,
	[user_administrador] [numeric](18, 0) NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [LOS_TRIGGERS].[Afiliado]  WITH CHECK ADD  CONSTRAINT [FK_Afiliado_Afiliado] FOREIGN KEY([afil_titular_grupo_familiar])
REFERENCES [LOS_TRIGGERS].[Afiliado] ([afil_numero])
GO
ALTER TABLE [LOS_TRIGGERS].[Afiliado] CHECK CONSTRAINT [FK_Afiliado_Afiliado]
GO
ALTER TABLE [LOS_TRIGGERS].[Afiliado]  WITH CHECK ADD  CONSTRAINT [FK_Afiliado_Plan_Medico] FOREIGN KEY([afil_plan_medico])
REFERENCES [LOS_TRIGGERS].[Plan_Medico] ([plan_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Afiliado] CHECK CONSTRAINT [FK_Afiliado_Plan_Medico]
GO
ALTER TABLE [LOS_TRIGGERS].[Baja_Afiliado]  WITH CHECK ADD  CONSTRAINT [FK_Baja_Afiliado_Afiliado] FOREIGN KEY([baja_afiliado])
REFERENCES [LOS_TRIGGERS].[Afiliado] ([afil_numero])
GO
ALTER TABLE [LOS_TRIGGERS].[Baja_Afiliado] CHECK CONSTRAINT [FK_Baja_Afiliado_Afiliado]
GO
ALTER TABLE [LOS_TRIGGERS].[Bono]  WITH CHECK ADD  CONSTRAINT [FK_Bono_Afiliado] FOREIGN KEY([bono_afiliado])
REFERENCES [LOS_TRIGGERS].[Afiliado] ([afil_numero])
GO
ALTER TABLE [LOS_TRIGGERS].[Bono] CHECK CONSTRAINT [FK_Bono_Afiliado]
GO
ALTER TABLE [LOS_TRIGGERS].[Bono]  WITH CHECK ADD  CONSTRAINT [FK_Bono_Consulta_Medica] FOREIGN KEY([bono_consulta_medica])
REFERENCES [LOS_TRIGGERS].[Consulta_Medica] ([cons_numero])
GO
ALTER TABLE [LOS_TRIGGERS].[Bono] CHECK CONSTRAINT [FK_Bono_Consulta_Medica]
GO
ALTER TABLE [LOS_TRIGGERS].[Bono]  WITH CHECK ADD  CONSTRAINT [FK_Bono_Plan_Medico] FOREIGN KEY([bono_plan_medico])
REFERENCES [LOS_TRIGGERS].[Plan_Medico] ([plan_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Bono] CHECK CONSTRAINT [FK_Bono_Plan_Medico]
GO
ALTER TABLE [LOS_TRIGGERS].[Cancelacion_Turno]  WITH CHECK ADD  CONSTRAINT [FK_Cancelacion_Turno_Afiliado] FOREIGN KEY([canc_emisor])
REFERENCES [LOS_TRIGGERS].[Afiliado] ([afil_numero])
GO
ALTER TABLE [LOS_TRIGGERS].[Cancelacion_Turno] CHECK CONSTRAINT [FK_Cancelacion_Turno_Afiliado]
GO
ALTER TABLE [LOS_TRIGGERS].[Cancelacion_Turno]  WITH CHECK ADD  CONSTRAINT [FK_Cancelacion_Turno_Profesional] FOREIGN KEY([canc_emisor])
REFERENCES [LOS_TRIGGERS].[Profesional] ([prof_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Cancelacion_Turno] CHECK CONSTRAINT [FK_Cancelacion_Turno_Profesional]
GO
ALTER TABLE [LOS_TRIGGERS].[Cancelacion_Turno]  WITH CHECK ADD  CONSTRAINT [FK_Cancelacion_Turno_Tipo_Cancelacion] FOREIGN KEY([canc_tipo])
REFERENCES [LOS_TRIGGERS].[Tipo_Cancelacion] ([tipo_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Cancelacion_Turno] CHECK CONSTRAINT [FK_Cancelacion_Turno_Tipo_Cancelacion]
GO
ALTER TABLE [LOS_TRIGGERS].[Compra_Bono]  WITH CHECK ADD  CONSTRAINT [FK_Compra_Bono_Afiliado] FOREIGN KEY([comp_afiliado])
REFERENCES [LOS_TRIGGERS].[Afiliado] ([afil_numero])
GO
ALTER TABLE [LOS_TRIGGERS].[Compra_Bono] CHECK CONSTRAINT [FK_Compra_Bono_Afiliado]
GO
ALTER TABLE [LOS_TRIGGERS].[Compra_Bono]  WITH CHECK ADD  CONSTRAINT [FK_Compra_Bono_Bono] FOREIGN KEY([comp_bono])
REFERENCES [LOS_TRIGGERS].[Bono] ([bono_numero])
GO
ALTER TABLE [LOS_TRIGGERS].[Compra_Bono] CHECK CONSTRAINT [FK_Compra_Bono_Bono]
GO
ALTER TABLE [LOS_TRIGGERS].[Consulta_Medica]  WITH CHECK ADD  CONSTRAINT [FK_Consulta_Medica_Diagnostico] FOREIGN KEY([cons_diagnostico])
REFERENCES [LOS_TRIGGERS].[Diagnostico] ([diag_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Consulta_Medica] CHECK CONSTRAINT [FK_Consulta_Medica_Diagnostico]
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad]  WITH CHECK ADD  CONSTRAINT [FK_Especialidad_Tipo_Especialidad] FOREIGN KEY([espe_tipo])
REFERENCES [LOS_TRIGGERS].[Tipo_Especialidad] ([tipo_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad] CHECK CONSTRAINT [FK_Especialidad_Tipo_Especialidad]
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad_Profesional]  WITH CHECK ADD  CONSTRAINT [FK_Especialidad_Profesional_Agenda] FOREIGN KEY([agenda])
REFERENCES [LOS_TRIGGERS].[Agenda] ([agen_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad_Profesional] CHECK CONSTRAINT [FK_Especialidad_Profesional_Agenda]
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad_Profesional]  WITH CHECK ADD  CONSTRAINT [FK_Especialidad_Profesional_Especialidad] FOREIGN KEY([especialidad])
REFERENCES [LOS_TRIGGERS].[Especialidad] ([espe_codigo])
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad_Profesional] CHECK CONSTRAINT [FK_Especialidad_Profesional_Especialidad]
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad_Profesional]  WITH CHECK ADD  CONSTRAINT [FK_Especialidad_Profesional_Especialidad_Profesional] FOREIGN KEY([especialidad])
REFERENCES [LOS_TRIGGERS].[Especialidad_Profesional] ([especialidad])
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad_Profesional] CHECK CONSTRAINT [FK_Especialidad_Profesional_Especialidad_Profesional]
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad_Profesional]  WITH CHECK ADD  CONSTRAINT [FK_Especialidad_Profesional_Profesional] FOREIGN KEY([profesional])
REFERENCES [LOS_TRIGGERS].[Profesional] ([prof_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad_Profesional] CHECK CONSTRAINT [FK_Especialidad_Profesional_Profesional]
GO
ALTER TABLE [LOS_TRIGGERS].[Funcionalidad_Rol]  WITH CHECK ADD  CONSTRAINT [FK_Funcionalidad_Rol_Administrador] FOREIGN KEY([rol])
REFERENCES [LOS_TRIGGERS].[Administrador] ([admi_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Funcionalidad_Rol] CHECK CONSTRAINT [FK_Funcionalidad_Rol_Administrador]
GO
ALTER TABLE [LOS_TRIGGERS].[Funcionalidad_Rol]  WITH CHECK ADD  CONSTRAINT [FK_Funcionalidad_Rol_Afiliado] FOREIGN KEY([rol])
REFERENCES [LOS_TRIGGERS].[Afiliado] ([afil_numero])
GO
ALTER TABLE [LOS_TRIGGERS].[Funcionalidad_Rol] CHECK CONSTRAINT [FK_Funcionalidad_Rol_Afiliado]
GO
ALTER TABLE [LOS_TRIGGERS].[Funcionalidad_Rol]  WITH CHECK ADD  CONSTRAINT [FK_Funcionalidad_Rol_Funcionalidad] FOREIGN KEY([funcionalidad])
REFERENCES [LOS_TRIGGERS].[Funcionalidad] ([func_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Funcionalidad_Rol] CHECK CONSTRAINT [FK_Funcionalidad_Rol_Funcionalidad]
GO
ALTER TABLE [LOS_TRIGGERS].[Funcionalidad_Rol]  WITH CHECK ADD  CONSTRAINT [FK_Funcionalidad_Rol_Profesional] FOREIGN KEY([rol])
REFERENCES [LOS_TRIGGERS].[Profesional] ([prof_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Funcionalidad_Rol] CHECK CONSTRAINT [FK_Funcionalidad_Rol_Profesional]
GO
ALTER TABLE [LOS_TRIGGERS].[Horario_Atencion]  WITH CHECK ADD  CONSTRAINT [FK_Horario_Atencion_Agenda] FOREIGN KEY([hora_agenda])
REFERENCES [LOS_TRIGGERS].[Agenda] ([agen_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Horario_Atencion] CHECK CONSTRAINT [FK_Horario_Atencion_Agenda]
GO
ALTER TABLE [LOS_TRIGGERS].[Horario_Atencion]  WITH CHECK ADD  CONSTRAINT [FK_Horario_Atencion_Turno] FOREIGN KEY([hora_turno])
REFERENCES [LOS_TRIGGERS].[Turno] ([turn_numero])
GO
ALTER TABLE [LOS_TRIGGERS].[Horario_Atencion] CHECK CONSTRAINT [FK_Horario_Atencion_Turno]
GO
ALTER TABLE [LOS_TRIGGERS].[Modificacion_Plan]  WITH CHECK ADD  CONSTRAINT [FK_Modificacion_Plan_Plan_Medico] FOREIGN KEY([modi_plan_medico])
REFERENCES [LOS_TRIGGERS].[Plan_Medico] ([plan_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Modificacion_Plan] CHECK CONSTRAINT [FK_Modificacion_Plan_Plan_Medico]
GO
ALTER TABLE [LOS_TRIGGERS].[Turno]  WITH CHECK ADD  CONSTRAINT [FK_Turno_Afiliado] FOREIGN KEY([turn_afiliado])
REFERENCES [LOS_TRIGGERS].[Afiliado] ([afil_numero])
GO
ALTER TABLE [LOS_TRIGGERS].[Turno] CHECK CONSTRAINT [FK_Turno_Afiliado]
GO
ALTER TABLE [LOS_TRIGGERS].[Turno]  WITH CHECK ADD  CONSTRAINT [FK_Turno_Consulta_Medica] FOREIGN KEY([turn_consulta_medica])
REFERENCES [LOS_TRIGGERS].[Consulta_Medica] ([cons_numero])
GO
ALTER TABLE [LOS_TRIGGERS].[Turno] CHECK CONSTRAINT [FK_Turno_Consulta_Medica]
GO
ALTER TABLE [LOS_TRIGGERS].[Turno]  WITH CHECK ADD  CONSTRAINT [FK_Turno_Profesional] FOREIGN KEY([turn_profesional])
REFERENCES [LOS_TRIGGERS].[Profesional] ([prof_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Turno] CHECK CONSTRAINT [FK_Turno_Profesional]
GO
ALTER TABLE [LOS_TRIGGERS].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Administrador] FOREIGN KEY([user_administrador])
REFERENCES [LOS_TRIGGERS].[Administrador] ([admi_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Usuario] CHECK CONSTRAINT [FK_Usuario_Administrador]
GO
ALTER TABLE [LOS_TRIGGERS].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Afiliado] FOREIGN KEY([user_afiliado])
REFERENCES [LOS_TRIGGERS].[Afiliado] ([afil_numero])
GO
ALTER TABLE [LOS_TRIGGERS].[Usuario] CHECK CONSTRAINT [FK_Usuario_Afiliado]
GO
ALTER TABLE [LOS_TRIGGERS].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Direccion] FOREIGN KEY([user_direccion])
REFERENCES [LOS_TRIGGERS].[Direccion] ([dire_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Usuario] CHECK CONSTRAINT [FK_Usuario_Direccion]
GO
ALTER TABLE [LOS_TRIGGERS].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Profesional] FOREIGN KEY([user_profesional])
REFERENCES [LOS_TRIGGERS].[Profesional] ([prof_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Usuario] CHECK CONSTRAINT [FK_Usuario_Profesional]
GO
