USE [GD2C2016]
GO

/*************************************************************************************
*				     INICIALIZACIÓN DE LA BASE DE DATOS                              *
**************************************************************************************/

--- CREACIÓN DEL ESQUEMA ---
IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'LOS_TRIGGERS'))
	BEGIN
		EXEC (N'CREATE SCHEMA [LOS_TRIGGERS] AUTHORIZATION [gd]')
		PRINT 'El esquema LOS_TRIGGERS ha sido creado.'
	END
GO

--- VERIFICAR Y RESTABLECER TABLAS ANTERIORES ---
IF OBJECT_ID ('LOS_TRIGGERS.Funcionalidad_Rol') IS NOT NULL DROP TABLE LOS_TRIGGERS.Funcionalidad_Rol
IF OBJECT_ID ('LOS_TRIGGERS.Funcionalidad') IS NOT NULL DROP TABLE LOS_TRIGGERS.Funcionalidad
IF OBJECT_ID ('LOS_TRIGGERS.Dia_Atencion') IS NOT NULL DROP TABLE LOS_TRIGGERS.Dia_Atencion
IF OBJECT_ID ('LOS_TRIGGERS.Usuario') IS NOT NULL DROP TABLE LOS_TRIGGERS.Usuario
IF OBJECT_ID ('LOS_TRIGGERS.Administrador') IS NOT NULL DROP TABLE LOS_TRIGGERS.Administrador
IF OBJECT_ID ('LOS_TRIGGERS.Baja_Afiliado') IS NOT NULL DROP TABLE LOS_TRIGGERS.Baja_Afiliado
IF OBJECT_ID ('LOS_TRIGGERS.Cancelacion_Turno') IS NOT NULL DROP TABLE LOS_TRIGGERS.Cancelacion_Turno
IF OBJECT_ID ('LOS_TRIGGERS.Tipo_Cancelacion') IS NOT NULL DROP TABLE LOS_TRIGGERS.Tipo_Cancelacion
IF OBJECT_ID ('LOS_TRIGGERS.Modificacion_Plan') IS NOT NULL DROP TABLE LOS_TRIGGERS.Modificacion_Plan
IF OBJECT_ID ('LOS_TRIGGERS.Compra_Bono') IS NOT NULL DROP TABLE LOS_TRIGGERS.Compra_Bono
IF OBJECT_ID ('LOS_TRIGGERS.Bono') IS NOT NULL DROP TABLE LOS_TRIGGERS.Bono
IF OBJECT_ID ('LOS_TRIGGERS.Consulta_Medica') IS NOT NULL DROP TABLE LOS_TRIGGERS.Consulta_Medica
IF OBJECT_ID ('LOS_TRIGGERS.Turno') IS NOT NULL DROP TABLE LOS_TRIGGERS.Turno
IF OBJECT_ID ('LOS_TRIGGERS.Especialidad_Profesional') IS NOT NULL DROP TABLE LOS_TRIGGERS.Especialidad_Profesional
IF OBJECT_ID ('LOS_TRIGGERS.Especialidad') IS NOT NULL DROP TABLE LOS_TRIGGERS.Especialidad
IF OBJECT_ID ('LOS_TRIGGERS.Tipo_Especialidad') IS NOT NULL DROP TABLE LOS_TRIGGERS.Tipo_Especialidad
IF OBJECT_ID ('LOS_TRIGGERS.Diagnostico') IS NOT NULL DROP TABLE LOS_TRIGGERS.Diagnostico
IF OBJECT_ID ('LOS_TRIGGERS.Clinica') IS NOT NULL DROP TABLE LOS_TRIGGERS.Clinica
IF OBJECT_ID ('LOS_TRIGGERS.Profesional') IS NOT NULL DROP TABLE LOS_TRIGGERS.Profesional
IF OBJECT_ID ('LOS_TRIGGERS.Afiliado') IS NOT NULL DROP TABLE LOS_TRIGGERS.Afiliado
IF OBJECT_ID ('LOS_TRIGGERS.Plan_Medico') IS NOT NULL DROP TABLE LOS_TRIGGERS.Plan_Medico
PRINT 'Las tablas del sistema han sido restablecidas.'
GO

--- CREACIÓN DE NUEVAS TABLAS ---

--- << Administrador >>
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

--- << Información útil sobre la Clínica >>
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LOS_TRIGGERS].[Clinica](
	[clin_id] [numeric](18, 0) IDENTITY NOT NULL,
	[clin_nombre] [varchar](255) NULL,
	[clin_inicio_dia_semana] [varchar](255) NULL,
	[clin_fin_dia_semana] [varchar](255) NULL,
	[clin_inicio_sabado] [varchar](255) NULL,
	[clin_fin_sabado] [varchar](255) NULL,
	[clin_inicio_domingo] [varchar](255) NULL,
	[clin_fin_domingo] [varchar](255) NULL,
 CONSTRAINT [PK_Clinica] PRIMARY KEY CLUSTERED 
(
	[clin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

--- << Afiliado >>
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Afiliado](
	[afil_numero] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[afil_estado_civil] [varchar](255) NULL,
	[afil_habilitacion] [bit] NULL,
	[afil_titular_grupo_familiar] [numeric](18, 0) NULL,
	[afil_plan_medico] [numeric](18, 0) NULL,
	[afil_cant_consultas_realizadas] [numeric](18, 0) NULL,
 CONSTRAINT [PK_Afiliado] PRIMARY KEY CLUSTERED 
(
	[afil_numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

--- << Baja Afiliado >>
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

--- << Bono >>
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LOS_TRIGGERS].[Bono](
	[bono_numero] [numeric](18, 0) IDENTITY NOT NULL,
	[bono_plan_medico] [numeric](18, 0) NULL,
	[bono_afiliado] [numeric](18, 0) NULL,
	[bono_consulta_medica] [numeric](18, 0) NULL,
	[bono_fecha_impresion] [datetime] NULL,
 CONSTRAINT [PK_Bono] PRIMARY KEY CLUSTERED 
(
	[bono_numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

--- << Cancelación Turno >>
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Cancelacion_Turno](
	[canc_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[canc_profesional] [numeric](18, 0) NULL,
	[canc_horario_atencion] [numeric](18, 0) NULL,
	[canc_afiliado] [numeric](18, 0) NULL,
	[canc_fecha_y_hora] [datetime] NULL,
	[canc_fecha_turno] [datetime] NULL,
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

--- << Compra Bono >>
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LOS_TRIGGERS].[Compra_Bono](
	[comp_numero] [numeric](18, 0) IDENTITY NOT NULL,
	[comp_bono] [numeric](18, 0) NULL,
	[comp_afiliado] [numeric](18, 0) NULL,
	[comp_monto] [numeric](18, 0) NULL,
	[comp_cantidad] [numeric](4, 0) NULL,
	[comp_fecha] [datetime] NULL,
 CONSTRAINT [PK_Compra_Bono] PRIMARY KEY CLUSTERED 
(
	[comp_numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

--- << Consulta Médica >>
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LOS_TRIGGERS].[Consulta_Medica](
	[cons_numero] [numeric](18, 0) IDENTITY NOT NULL,
	[cons_turno] [numeric](18, 0) NULL,
	[cons_diagnostico] [numeric](18, 0) NULL,
 CONSTRAINT [PK_Consulta_Medica] PRIMARY KEY CLUSTERED 
(
	[cons_numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

--- << Diagnóstico >>
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

--- << Especialidad >>
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Especialidad](  
	[espe_codigo] [numeric](18, 0) IDENTITY NOT NULL,
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

--- << Funcionalidad >>
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Funcionalidad](
	[func_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[func_nombre] [varchar](127) NULL,
 CONSTRAINT [PK_Funcionalidad] PRIMARY KEY CLUSTERED 
(
	[func_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

--- << Funcionalidad Rol >>
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

--- << Horario Atención >>
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Dia_Atencion](
	[dia_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[dia_especialidad_profesional] [numeric](18, 0) NULL,
	[dia_clinica] [numeric](18, 0) NULL,
	[dia_nombre_dia] [varchar](255) NULL,
	[dia_hora_inicio] [varchar](255) NULL,
	[dia_hora_fin] [varchar](255) NULL,
 CONSTRAINT [PK_Dia_Atencion] PRIMARY KEY CLUSTERED 
(
	[dia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

--- << Modificación Plan >>
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

--- << Plan Médico >>
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

--- << Profesional >>
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

--- << Tipo Cancelación >>
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

--- << Tipo Especialidad >>
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

--- << Turno >>
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LOS_TRIGGERS].[Turno](
	[turn_numero] [numeric](18, 0) IDENTITY NOT NULL,
	[turn_afiliado] [numeric](18, 0) NULL,
	[turn_especialidad_profesional] [numeric](18, 0) NULL,
	[turn_fecha] [date] NULL,
	[turn_hora_inicio] [varchar](255) NULL,
	[turn_hora_fin] [varchar](255) NULL,
	[turn_fecha_y_hora_asistencia] [datetime] NULL,
 CONSTRAINT [PK_Turno] PRIMARY KEY CLUSTERED 
(
	[turn_numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

--- << Especialidad Profesional >>
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LOS_TRIGGERS].[Especialidad_Profesional](
	[espe_prof_id] [numeric](18, 0) IDENTITY NOT NULL,
	[profesional] [numeric](18, 0) NOT NULL,
	[especialidad] [numeric](18, 0) NOT NULL,
	[disponible_desde_fecha] [varchar](255) NULL,
	[disponible_hasta_fecha] [varchar](255) NULL,
 CONSTRAINT [PK_Especialidad_Profesional] PRIMARY KEY CLUSTERED 
(
	[espe_prof_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

--- << Usuario >>
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [LOS_TRIGGERS].[Usuario](
	[user_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[user_name] [varchar](255) NULL,
	[user_password] [varchar](255) NULL,
	[user_intentos_fallidos_login] [numeric](1, 0) NULL,
	[user_nombre] [varchar](255) NULL,
	[user_apellido] [varchar](255) NULL,
	[user_dni] [numeric](18, 0) NULL,
	[user_telefono] [numeric](18, 0) NULL,
	[user_mail] [varchar](255) NULL,
	[user_fecha_nacimiento] [datetime] NULL,
	[user_sexo] [char](3) NULL,
	[user_direccion] [varchar](255) NULL,
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

--- ESTABLECER RELACIONES ---
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
ALTER TABLE [LOS_TRIGGERS].[Cancelacion_Turno]  WITH CHECK ADD  CONSTRAINT [FK_Cancelacion_Turno_Afiliado] FOREIGN KEY([canc_afiliado])
REFERENCES [LOS_TRIGGERS].[Afiliado] ([afil_numero])
GO
ALTER TABLE [LOS_TRIGGERS].[Cancelacion_Turno] CHECK CONSTRAINT [FK_Cancelacion_Turno_Afiliado]
GO
ALTER TABLE [LOS_TRIGGERS].[Cancelacion_Turno]  WITH CHECK ADD  CONSTRAINT [FK_Cancelacion_Turno_Profesional] FOREIGN KEY([canc_profesional])
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
ALTER TABLE [LOS_TRIGGERS].[Consulta_Medica]  WITH CHECK ADD  CONSTRAINT [FK_Consulta_Medica_Turno] FOREIGN KEY([cons_turno])
REFERENCES [LOS_TRIGGERS].[Turno] ([turn_numero])
GO
ALTER TABLE [LOS_TRIGGERS].[Consulta_Medica] CHECK CONSTRAINT [FK_Consulta_Medica_Turno]
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad]  WITH CHECK ADD  CONSTRAINT [FK_Especialidad_Tipo_Especialidad] FOREIGN KEY([espe_tipo])
REFERENCES [LOS_TRIGGERS].[Tipo_Especialidad] ([tipo_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad] CHECK CONSTRAINT [FK_Especialidad_Tipo_Especialidad]
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
ALTER TABLE [LOS_TRIGGERS].[Especialidad_Profesional]  WITH CHECK ADD  CONSTRAINT [FK_Especialidad_Profesional_Especialidad] FOREIGN KEY([especialidad])
REFERENCES [LOS_TRIGGERS].[Especialidad] ([espe_codigo])
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad_Profesional] CHECK CONSTRAINT [FK_Especialidad_Profesional_Especialidad]
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad_Profesional]  WITH CHECK ADD  CONSTRAINT [FK_Especialidad_Profesional_Profesional] FOREIGN KEY([profesional])
REFERENCES [LOS_TRIGGERS].[Profesional] ([prof_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Especialidad_Profesional] CHECK CONSTRAINT [FK_Especialidad_Profesional_Profesional]
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
ALTER TABLE [LOS_TRIGGERS].[Turno]  WITH CHECK ADD  CONSTRAINT [FK_Turno_Especialidad_Profesional] FOREIGN KEY([turn_especialidad_profesional])
REFERENCES [LOS_TRIGGERS].[Especialidad_Profesional] ([espe_prof_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Turno] CHECK CONSTRAINT [FK_Turno_Especialidad_Profesional]
GO
ALTER TABLE [LOS_TRIGGERS].[Dia_Atencion]  WITH CHECK ADD  CONSTRAINT [FK_Dia_Atencion_Clinica] FOREIGN KEY([dia_clinica])
REFERENCES [LOS_TRIGGERS].[Clinica] ([clin_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Dia_Atencion] CHECK CONSTRAINT [FK_Dia_Atencion_Clinica]
GO
ALTER TABLE [LOS_TRIGGERS].[Dia_Atencion]  WITH CHECK ADD  CONSTRAINT [FK_Dia_Atencion_Especialidad_Profesional] FOREIGN KEY([dia_especialidad_profesional])
REFERENCES [LOS_TRIGGERS].[Especialidad_Profesional] ([espe_prof_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Dia_Atencion] CHECK CONSTRAINT [FK_Dia_Atencion_Especialidad_Profesional]
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
ALTER TABLE [LOS_TRIGGERS].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Profesional] FOREIGN KEY([user_profesional])
REFERENCES [LOS_TRIGGERS].[Profesional] ([prof_id])
GO
ALTER TABLE [LOS_TRIGGERS].[Usuario] CHECK CONSTRAINT [FK_Usuario_Profesional]
GO
PRINT 'Fin de la CREACIÓN de tablas.'
GO

/*************************************************************************************
*				           OBJETOS DE BASE DE DATOS                                  *
**************************************************************************************/
-- En scripts separados (por ahora)

/*

/*************************************************************************************
*			         MIGRACIÓN (de tabla Maestra al Sistema)                          *
**************************************************************************************/
PRINT 'Comienza la MIGRACIÓN.'
GO
--- << Planes Médicos >>
SET IDENTITY_INSERT LOS_TRIGGERS.Plan_Medico ON
GO
insert into LOS_TRIGGERS.Plan_Medico (plan_id, plan_med_descripcion, plan_precio_bono_consulta, plan_precio_bono_farmacia)
	select distinct(Plan_Med_Codigo), Plan_Med_Descripcion, Plan_Med_Precio_Bono_Consulta, Plan_Med_Precio_Bono_Farmacia
	from gd_esquema.Maestra where Plan_Med_Codigo is not null
SET IDENTITY_INSERT LOS_TRIGGERS.Plan_Medico OFF
PRINT '1. Tabla Plan Médico OK'
GO

--- << Tipos de Especialidad >>
SET IDENTITY_INSERT LOS_TRIGGERS.Tipo_Especialidad ON
GO
insert into LOS_TRIGGERS.Tipo_Especialidad (tipo_id, tipo_descripcion)
	select distinct(Tipo_Especialidad_Codigo), Tipo_Especialidad_Descripcion from gd_esquema.Maestra
	where Tipo_Especialidad_Codigo is not null
SET IDENTITY_INSERT LOS_TRIGGERS.Tipo_Especialidad OFF
PRINT '2. Tabla Tipo_Especialidad OK'
GO

--- << Especialidades >>
SET IDENTITY_INSERT LOS_TRIGGERS.Especialidad ON
GO
insert into LOS_TRIGGERS.Especialidad (espe_codigo, espe_descripcion, espe_tipo)
	select distinct(Especialidad_Codigo), Especialidad_Descripcion, Tipo_Especialidad_Codigo
	from gd_esquema.Maestra where Especialidad_Codigo is not null
SET IDENTITY_INSERT LOS_TRIGGERS.Especialidad OFF
PRINT '3. Tabla Especialidad OK'
GO

--- << Afiliados >>
SET IDENTITY_INSERT LOS_TRIGGERS.Afiliado ON
GO
declare @dni as numeric(18,0), @direccion as varchar(255), @mail as varchar(255), @nombre as varchar(255), @nro_afiliado as numeric(18,0),
		@apellido as varchar(255), @nacimiento as datetime, @telefono as numeric(18,0), @plan as numeric(18,0)
declare AFILIADOS cursor for select distinct (Paciente_Dni), Paciente_Direccion, Paciente_Mail, Paciente_Nombre, Paciente_Apellido, Paciente_Fecha_Nac, Paciente_Telefono, Plan_Med_Codigo
							from gd_esquema.Maestra where Paciente_Dni is not null
OPEN AFILIADOS
FETCH NEXT FROM AFILIADOS INTO @dni, @direccion, @mail, @nombre, @apellido, @nacimiento, @telefono, @plan
WHILE @@fetch_status = 0
	BEGIN
		set @nro_afiliado = CONVERT(numeric(18,0), CAST(@dni*10 as varchar) + '01')
		insert into LOS_TRIGGERS.Afiliado (afil_numero, afil_habilitacion, afil_cant_consultas_realizadas, afil_plan_medico, afil_titular_grupo_familiar)
			values (@nro_afiliado, 1, 0, @plan, @nro_afiliado)
	
		insert into LOS_TRIGGERS.Usuario (user_name, user_password, user_afiliado, user_intentos_fallidos_login, user_dni, user_direccion, user_mail, user_nombre, user_apellido, user_fecha_nacimiento, user_telefono)
			select CONVERT(varchar(255), @dni), HASHBYTES('SHA2_256', CONVERT(varchar(255), @dni)), @nro_afiliado, 0, @dni, @direccion, @mail, @nombre, @apellido, @nacimiento, @telefono

		FETCH NEXT FROM AFILIADOS INTO @dni, @direccion, @mail, @nombre, @apellido, @nacimiento, @telefono, @plan
	END
CLOSE AFILIADOS
DEALLOCATE AFILIADOS
GO
SET IDENTITY_INSERT LOS_TRIGGERS.Afiliado OFF
PRINT '4. Tabla Afiliado OK'
GO

--- << Profesionales >>
SET IDENTITY_INSERT LOS_TRIGGERS.Profesional ON
GO
declare @dni as numeric(18,0), @direccion as varchar(255), @mail as varchar(255), @nombre as varchar(255),
		@apellido as varchar(255), @nacimiento as datetime, @telefono as numeric(18,0), @nro_profesional as numeric(18,0)

declare PROFESIONALES cursor for select distinct (Medico_Dni), Medico_Direccion, Medico_Mail, Medico_Nombre,
				Medico_Apellido, Medico_Fecha_Nac, Medico_Telefono from gd_esquema.Maestra where Medico_Dni is not null
OPEN PROFESIONALES
FETCH NEXT FROM PROFESIONALES INTO @dni, @direccion, @mail, @nombre, @apellido, @nacimiento, @telefono
WHILE @@fetch_status = 0
	BEGIN
		set @nro_profesional = CONVERT(numeric(18,0), CAST(@dni*10 as varchar) + '99')
		insert into LOS_TRIGGERS.Profesional(prof_id, prof_habilitacion, prof_horas_laborales)
			values (@nro_profesional, 1,0)
		
		insert into LOS_TRIGGERS.Usuario (user_name, user_password, user_profesional, user_intentos_fallidos_login, user_dni, user_direccion, user_mail, user_nombre, user_apellido, user_fecha_nacimiento, user_telefono)
			select CONVERT(varchar(255), CONVERT(int, @dni)), HASHBYTES('SHA2_256', CONVERT(varchar(255), CONVERT(int, @dni))), @nro_profesional, 0, @dni, @direccion, @mail, @nombre, @apellido, @nacimiento, @telefono

		FETCH NEXT FROM PROFESIONALES INTO @dni, @direccion, @mail, @nombre, @apellido, @nacimiento, @telefono
	END
CLOSE PROFESIONALES
DEALLOCATE PROFESIONALES
SET IDENTITY_INSERT LOS_TRIGGERS.Profesional OFF
PRINT '5. Tabla Profesional OK'
GO

-- << Especialidad_Profesional >>
insert into LOS_TRIGGERS.Especialidad_Profesional(especialidad, profesional)
select distinct(Especialidad_Codigo), CONVERT(numeric(18,0), CAST(Medico_Dni*10 as varchar) + '99')
from gd_esquema.Maestra where Medico_Dni is not null
PRINT '6. Tabla Especialidad_Profesional OK'
GO

--- << Bonos >>
SET IDENTITY_INSERT LOS_TRIGGERS.Bono ON
GO
insert into LOS_TRIGGERS.Bono (bono_numero, bono_fecha_impresion, bono_afiliado, bono_plan_medico)
	select distinct(Bono_Consulta_Numero), Bono_Consulta_Fecha_Impresion, CONVERT(numeric(18,0), CAST(Paciente_Dni*10 as varchar) + '01'), Plan_Med_Codigo
	from gd_esquema.Maestra where Bono_Consulta_Numero is not null
SET IDENTITY_INSERT LOS_TRIGGERS.Bono OFF
PRINT '7. Tabla Bono OK'
GO

--- << Compras de Bonos >>
insert into LOS_TRIGGERS.Compra_Bono (comp_bono, comp_fecha, comp_afiliado, comp_monto, comp_cantidad)
	select distinct(Bono_Consulta_Numero), Compra_Bono_Fecha, CONVERT(numeric(18,0), CAST(Paciente_Dni*10 as varchar) + '01'), Plan_Med_Precio_Bono_Consulta, 1
	from gd_esquema.Maestra where Compra_Bono_Fecha is not null
PRINT '8. Tabla Compra_Bono OK'
GO

--- << Turnos, Consultas Médicas & Diagnósticos >>
SET IDENTITY_INSERT LOS_TRIGGERS.Turno ON
GO
declare @turno as numeric(18,0), @fecha_turno as datetime, @sintomas as varchar(255), @descripcion as varchar(255), @bono as numeric(18,0)
declare TURNOS cursor for select distinct (Turno_Numero), Turno_Fecha, Consulta_Sintomas, Consulta_Enfermedades, Bono_Consulta_Numero
						from gd_esquema.Maestra where Turno_Numero is not null AND Bono_Consulta_Numero is not null
OPEN TURNOS
FETCH NEXT FROM TURNOS INTO @turno, @fecha_turno, @sintomas, @descripcion, @bono
WHILE @@fetch_status = 0
	BEGIN
				insert into LOS_TRIGGERS.Turno (turn_numero, turn_fecha_atencion) values(@turno, @fecha_turno)
				
				insert into LOS_TRIGGERS.Diagnostico (diag_sintomas, diag_descripcion) values(@sintomas, @descripcion)
				
				insert into LOS_TRIGGERS.Consulta_Medica (cons_diagnostico, cons_turno) values ((select SCOPE_IDENTITY()), @turno)
				
				update LOS_TRIGGERS.Bono
					SET bono_consulta_medica=(select SCOPE_IDENTITY())
					WHERE bono_numero=@bono

		FETCH NEXT FROM TURNOS INTO @turno, @fecha_turno, @sintomas, @descripcion, @bono
	END
CLOSE TURNOS
DEALLOCATE TURNOS
SET IDENTITY_INSERT LOS_TRIGGERS.Turno OFF
PRINT '9. Tabla Turno OK'
GO

--- << Horarios de Atención de Turnos (Agendas de Profesionales) >>
SET DATEFIRST 7 -- Domingo
insert into LOS_TRIGGERS.Horario_Atencion(hora_turno, hora_dia_atencion, hora_inicio_atencion, hora_fin_atencion, hora_fecha_asignada, hora_especialidad_profesional)
	select distinct(Turno_Numero), datename(weekday, Turno_Fecha), datename(hour, Turno_Fecha)+':'+datename(minute, Turno_Fecha), datename(hour, dateadd(minute, 30, Turno_Fecha))+':'+datename(minute, dateadd(minute, 30, Turno_Fecha)), CAST(Turno_Fecha as date), espe_prof_id
	from gd_esquema.Maestra, LOS_TRIGGERS.Especialidad_Profesional where Turno_Numero is not null AND Bono_Consulta_Numero is not null
		AND especialidad=Especialidad_Codigo AND profesional=CONVERT(numeric(18,0), CAST(Medico_Dni*10 as varchar) + '99')
PRINT '10. Tabla Horarios de Atención de Turnos OK'
GO

-- << Afiliados y Profesionales en Turnos >>
declare @turno as numeric(18,0), @afiliado as numeric(18,0), @profesional as numeric(18,0), @especialidad as numeric(18,0)
declare TURNOS cursor for select distinct (Turno_Numero), Paciente_Dni, Medico_Dni, Especialidad_Codigo from gd_esquema.Maestra where Turno_Numero is not null
OPEN TURNOS
FETCH NEXT FROM TURNOS INTO @turno, @afiliado, @profesional, @especialidad
WHILE @@fetch_status = 0
	BEGIN
			update LOS_TRIGGERS.Turno
				set turn_afiliado=CONVERT(numeric(18,0), CAST(@afiliado*10 as varchar) + '01'), turn_profesional=CONVERT(numeric(18,0), CAST(@profesional*10 as varchar) + '99'), turn_especialidad = @especialidad
				where turn_numero=@turno

		FETCH NEXT FROM TURNOS INTO @turno, @afiliado, @profesional, @especialidad
	END
CLOSE TURNOS
DEALLOCATE TURNOS
PRINT '11. Carga Profesionales y Afiliados en Turnos OK'
GO

-- << Cantidad de Consultas realizadas por Afiliado >>
declare @afiliado as numeric(18,0), @consultas as int
declare CONSULTAS cursor for select turn_afiliado, COUNT(distinct(cons_numero))
					from gd_esquema.Maestra, LOS_TRIGGERS.Afiliado, LOS_TRIGGERS.Consulta_Medica, LOS_TRIGGERS.Turno
					where turn_afiliado=CONVERT(numeric(18,0), CAST(Paciente_Dni*10 as varchar) + '01') AND cons_turno=turn_numero
						AND Paciente_Dni is not null AND Consulta_Sintomas is not null
					group by turn_afiliado
OPEN CONSULTAS
FETCH NEXT FROM CONSULTAS INTO @afiliado, @consultas
WHILE @@fetch_status = 0
	BEGIN
			update LOS_TRIGGERS.Afiliado
				set afil_cant_consultas_realizadas = CONVERT(numeric(18,0), @consultas)
				where afil_numero=@afiliado

		FETCH NEXT FROM CONSULTAS INTO @afiliado, @consultas
	END
CLOSE CONSULTAS
DEALLOCATE CONSULTAS
PRINT '12. Consultas realizadas por Afiliados OK'
GO

-- << Rango de atención de la Clínica >>
insert into LOS_TRIGGERS.Clinica (clin_nombre, clin_inicio_dia_semana, clin_fin_dia_semana, clin_inicio_sabado, clin_fin_sabado, clin_inicio_domingo, clin_fin_domingo)
	values('Clinica Medica FRBA', '7:0', '20:0', '10:0', '15:0', '0:0', '0:0')
PRINT '13. Rango de Atención de la Clínica OK'
GO

-- << Tipos de Cancelaciones de Turno >>
insert into LOS_TRIGGERS.Tipo_Cancelacion (tipo_descripcion)
	values ('Ya no necesito el servicio'),
			('He encontrado otro servicio alternativo que cubre mejor mis necesidades'),
			('La atención al cliente no ha cubierto mis expectativas'),
			('No puedo asistir debido a un problema personal'),
			('Otro motivo')
PRINT '13. Rango de Atención de la Clínica OK'
GO


*/

--- TODO:
--  Calcular cantidad de horas laborales en Profesional (quizás no haga falta).
-- Anazlizar si los turnos que tienen NULL en Consulta es porque se cancelaron y, en ese caso, registrar las cancelaciones correspondientes.