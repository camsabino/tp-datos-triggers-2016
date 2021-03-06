USE [GD2C2016]
GO

SET NOCOUNT ON;
/*************************************************************************************
*				       INICIALIZACIÓN DE LA BASE DE DATOS                            *
**************************************************************************************/

--- CREACIÓN DEL ESQUEMA ---
IF (NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'LOS_TRIGGERS'))
	BEGIN
		EXEC (N'CREATE SCHEMA [LOS_TRIGGERS] AUTHORIZATION [gd]')
		PRINT 'El esquema LOS_TRIGGERS ha sido creado.'
	END
GO

--- VERIFICAR Y RESTABLECER TABLAS ---
IF OBJECT_ID ('LOS_TRIGGERS.Funcionalidad_Rol') IS NOT NULL DROP TABLE LOS_TRIGGERS.Funcionalidad_Rol
IF OBJECT_ID ('LOS_TRIGGERS.Funcionalidad') IS NOT NULL DROP TABLE LOS_TRIGGERS.Funcionalidad
IF OBJECT_ID ('LOS_TRIGGERS.Usuario') IS NOT NULL DROP TABLE LOS_TRIGGERS.Usuario
IF OBJECT_ID ('LOS_TRIGGERS.Administrador') IS NOT NULL DROP TABLE LOS_TRIGGERS.Administrador
IF OBJECT_ID ('LOS_TRIGGERS.Modificacion_Plan') IS NOT NULL DROP TABLE LOS_TRIGGERS.Modificacion_Plan
IF OBJECT_ID ('LOS_TRIGGERS.Bono') IS NOT NULL DROP TABLE LOS_TRIGGERS.Bono
IF OBJECT_ID ('LOS_TRIGGERS.Compra_Bono') IS NOT NULL DROP TABLE LOS_TRIGGERS.Compra_Bono
IF OBJECT_ID ('LOS_TRIGGERS.Baja_Afiliado') IS NOT NULL DROP TABLE LOS_TRIGGERS.Baja_Afiliado
IF OBJECT_ID ('LOS_TRIGGERS.Consulta_Medica') IS NOT NULL DROP TABLE LOS_TRIGGERS.Consulta_Medica
IF OBJECT_ID ('LOS_TRIGGERS.Diagnostico') IS NOT NULL DROP TABLE LOS_TRIGGERS.Diagnostico
IF OBJECT_ID ('LOS_TRIGGERS.Turno') IS NOT NULL DROP TABLE LOS_TRIGGERS.Turno
IF OBJECT_ID ('LOS_TRIGGERS.Cancelacion_Turno') IS NOT NULL DROP TABLE LOS_TRIGGERS.Cancelacion_Turno
IF OBJECT_ID ('LOS_TRIGGERS.Tipo_Cancelacion') IS NOT NULL DROP TABLE LOS_TRIGGERS.Tipo_Cancelacion
IF OBJECT_ID ('LOS_TRIGGERS.Dia_Atencion') IS NOT NULL DROP TABLE LOS_TRIGGERS.Dia_Atencion
IF OBJECT_ID ('LOS_TRIGGERS.Horario_Atencion') IS NOT NULL DROP TABLE LOS_TRIGGERS.Horario_Atencion
IF OBJECT_ID ('LOS_TRIGGERS.Clinica') IS NOT NULL DROP TABLE LOS_TRIGGERS.Clinica
IF OBJECT_ID ('LOS_TRIGGERS.Especialidad_Profesional') IS NOT NULL DROP TABLE LOS_TRIGGERS.Especialidad_Profesional
IF OBJECT_ID ('LOS_TRIGGERS.Especialidad') IS NOT NULL DROP TABLE LOS_TRIGGERS.Especialidad
IF OBJECT_ID ('LOS_TRIGGERS.Tipo_Especialidad') IS NOT NULL DROP TABLE LOS_TRIGGERS.Tipo_Especialidad
IF OBJECT_ID ('LOS_TRIGGERS.Profesional') IS NOT NULL DROP TABLE LOS_TRIGGERS.Profesional
IF OBJECT_ID ('LOS_TRIGGERS.Afiliado') IS NOT NULL DROP TABLE LOS_TRIGGERS.Afiliado
IF OBJECT_ID ('LOS_TRIGGERS.Plan_Medico') IS NOT NULL DROP TABLE LOS_TRIGGERS.Plan_Medico
PRINT 'Las tablas del sistema han sido restablecidas.'
GO

--- CREACIÓN DE TABLAS ---

--- << Administrador >>
CREATE TABLE [LOS_TRIGGERS].[Administrador](
	[admi_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[admi_habilitacion] [bit] NULL,
	[nombre_rol] [varchar](255) NULL
	);

--- << Información útil sobre la Clínica >>
CREATE TABLE [LOS_TRIGGERS].[Clinica](
	[clin_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[clin_nombre] [varchar](255) NULL
	);

--- << Funcionalidad >>
CREATE TABLE [LOS_TRIGGERS].[Funcionalidad](
	[func_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[func_nombre] [varchar](127) NULL
	);

--- << Diagnóstico >>
CREATE TABLE [LOS_TRIGGERS].[Diagnostico](
	[diag_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[diag_fecha_y_hora] [datetime] NULL,
	[diag_sintomas] [varchar](255) NULL,
	[diag_descripcion] [varchar](255) NULL
	);

--- << Plan Médico >>
CREATE TABLE [LOS_TRIGGERS].[Plan_Medico](
	[plan_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[plan_precio_bono_consulta] [numeric](18, 0) NULL,
	[plan_precio_bono_farmacia] [numeric](18, 0) NULL,
	[plan_med_descripcion] [varchar](255) NULL
	);

--- << Profesional >>
CREATE TABLE [LOS_TRIGGERS].[Profesional](
	[prof_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[prof_matricula] [numeric](18, 0) NULL,
	[prof_horas_laborales] [numeric](2, 0) NULL,
	[nombre_rol] [varchar](255) NULL,
	[prof_habilitacion] [bit] NULL
	);

--- << Tipo Cancelación de Turno >>
CREATE TABLE [LOS_TRIGGERS].[Tipo_Cancelacion](
	[tipo_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[tipo_descripcion] [varchar](255) NULL
	);

--- << Tipo Especialidad >>
CREATE TABLE [LOS_TRIGGERS].[Tipo_Especialidad](
	[tipo_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[tipo_descripcion] [varchar](255) NULL
	);

--- << Especialidad >>
CREATE TABLE [LOS_TRIGGERS].[Especialidad](  
	[espe_codigo] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[espe_descripcion] [varchar](255) NULL,
	[espe_tipo] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Tipo_Especialidad
	);

--- << Afiliado >>
CREATE TABLE [LOS_TRIGGERS].[Afiliado](
	[afil_numero] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[afil_estado_civil] [varchar](255) NULL,
	[afil_habilitacion] [bit] NULL,
	[nombre_rol] [varchar](255) NULL,
	[afil_titular_grupo_familiar] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Afiliado,
	[afil_plan_medico] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Plan_Medico,
	[afil_cant_consultas_realizadas] [numeric](18, 0) NULL,
	[afil_cant_familiares_a_cargo] [numeric](2, 0) NULL,
	[afil_relacion_con_titular] [varchar](255) NULL
	);

--- << Baja Afiliado >>
CREATE TABLE [LOS_TRIGGERS].[Baja_Afiliado](
	[baja_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[baja_fecha] [datetime] NULL,
	[baja_afiliado] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Afiliado
	);

--- << Modificación Plan >>
CREATE TABLE [LOS_TRIGGERS].[Modificacion_Plan](
	[modi_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[modi_fecha_y_hora] [datetime] NULL,
	[modi_motivo] [varchar](255) NULL,
	[modi_viejo_plan] [varchar](255) NULL,
	[modi_nuevo_plan] [varchar](255) NULL,
	[modi_afiliado] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Afiliado
	);

--- << Funcionalidad Rol >>
CREATE TABLE [LOS_TRIGGERS].[Funcionalidad_Rol](
	[func_rol_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[afiliado] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Afiliado,
	[administrador] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Administrador,
	[profesional] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Profesional,
	[funcionalidad] [numeric](18, 0) NOT NULL foreign key references LOS_TRIGGERS.Funcionalidad
	);

--- << Especialidad Profesional >>
CREATE TABLE [LOS_TRIGGERS].[Especialidad_Profesional](
	[espe_prof_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[profesional] [numeric](18, 0) NOT NULL foreign key references LOS_TRIGGERS.Profesional,
	[especialidad] [numeric](18, 0) NOT NULL foreign key references LOS_TRIGGERS.Especialidad,
	[disponible_desde_fecha] [date] NULL,
	[disponible_hasta_fecha] [date] NULL
	);

--- << Día de Atención >>
CREATE TABLE [LOS_TRIGGERS].[Dia_Atencion](
	[dia_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[dia_especialidad_profesional] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Especialidad_Profesional,
	[dia_clinica] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Clinica,
	[dia_nombre_dia] [varchar](255) NULL,
	[dia_hora_inicio] [varchar](255) NULL,
	[dia_hora_fin] [varchar](255) NULL
	);

--- << Horario de Atención >>
CREATE TABLE [LOS_TRIGGERS].[Horario_Atencion](
	[hora_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[hora_especialidad_profesional] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Especialidad_Profesional,
	[hora_nombre_dia] [varchar](255) NULL,
	[hora_fecha] [datetime] NULL,
	[hora_inicio] [varchar](255) NULL,
	[hora_fin] [varchar](255) NULL,
	[hora_turno] [numeric](18, 0) NULL
	);

--- << Turno >>
CREATE TABLE [LOS_TRIGGERS].[Turno](
	[turn_numero] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[turn_afiliado] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Afiliado,
	[turn_especialidad_profesional] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Especialidad_Profesional,
	[turn_fecha] [datetime] NULL,
	[turn_nombre_dia] [varchar](255) NULL,
	[turn_hora_inicio] [varchar](255) NULL,
	[turn_hora_fin] [varchar](255) NULL,
	[turn_fecha_y_hora_asistencia] [datetime] NULL
	);

--- << Consulta Médica >>
CREATE TABLE [LOS_TRIGGERS].[Consulta_Medica](
	[cons_numero] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[cons_turno] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Turno,
	[cons_diagnostico] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Diagnostico
	);

--- << Cancelación Turno >>
CREATE TABLE [LOS_TRIGGERS].[Cancelacion_Turno](
	[canc_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[canc_especialidad_profesional] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Especialidad_Profesional,
	[canc_afiliado] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Afiliado,
	[canc_emisor_afiliado] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Afiliado,
	[canc_emisor_profesional] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Profesional,
	[canc_fecha_y_hora] [datetime] NULL,
	[canc_fecha_turno] [datetime] NULL,
	[canc_hora_turno] [varchar](255) NULL,
	[canc_motivo] [varchar](255) NULL,
	[canc_tipo] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Tipo_Cancelacion
	);

--- << Compra Bono >>
CREATE TABLE [LOS_TRIGGERS].[Compra_Bono](
	[comp_numero] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[comp_afiliado] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Afiliado,
	[comp_monto] [numeric](18, 0) NULL,
	[comp_cantidad] [numeric](4, 0) NULL,
	[comp_fecha_y_hora] [datetime] NULL
	);

--- << Bono >>
CREATE TABLE [LOS_TRIGGERS].[Bono](
	[bono_numero] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[bono_plan_medico] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Plan_Medico,
	[bono_afiliado] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Afiliado,
	[bono_consulta_medica] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Consulta_Medica,
	[bono_compra] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Compra_Bono,
	[bono_fecha_impresion] [datetime] NULL
	);

--- << Usuario >>
CREATE TABLE [LOS_TRIGGERS].[Usuario](
	[user_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
	[user_name] [varchar](255) NULL,
	[user_password] [varbinary](300) NULL,
	[user_intentos_fallidos_login] [numeric](1, 0) NULL,
	[user_nombre] [varchar](255) NULL,
	[user_apellido] [varchar](255) NULL,
	[user_dni] [numeric](18, 0) NULL,
	[user_telefono] [numeric](18, 0) NULL,
	[user_mail] [varchar](255) NULL,
	[user_fecha_nacimiento] [datetime] NULL,
	[user_sexo] [char](3) NULL,
	[user_direccion] [varchar](255) NULL,
	[user_afiliado] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Afiliado,
	[user_profesional] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Profesional,
	[user_administrador] [numeric](18, 0) NULL foreign key references LOS_TRIGGERS.Administrador
	);

PRINT 'Fin de la CREACIÓN de tablas.'
GO

/*************************************************************************************
*				           OBJETOS DE BASE DE DATOS                                  *
**************************************************************************************/

--- << Login y Seguridad >> ---

IF OBJECT_ID ('LOS_TRIGGERS.usuario_traer_ID_rol') is not null DROP PROCEDURE LOS_TRIGGERS.usuario_traer_ID_rol
GO	
CREATE PROC LOS_TRIGGERS.usuario_traer_ID_rol(@usuario varchar(255), @rol varchar(255), @nro numeric(18) OUTPUT)
AS 
BEGIN
	SELECT @nro = CASE @rol WHEN 'Afiliado' THEN user_afiliado
				  WHEN 'Profesional' THEN user_profesional
				  WHEN 'Administrador' THEN user_administrador
				  END
	FROM LOS_TRIGGERS.Usuario WHERE @usuario = user_name

	IF (@nro is null) set @nro = 0
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.usuario_login') is not null DROP PROCEDURE LOS_TRIGGERS.usuario_login
GO	
CREATE PROC LOS_TRIGGERS.usuario_login (@user_name varchar(255), @user_password varchar(255), @rol varchar(255), @resultado int OUTPUT)
AS
BEGIN
DECLARE @intentos_fallidos numeric(1), @num_afiliado numeric(18), @num_profesional numeric(18),
		@num_administrador numeric(18), @nro_rol as numeric(18,0), @password varbinary(300)

IF(EXISTS (select * from LOS_TRIGGERS.Usuario where user_name = @user_name))
BEGIN
	SELECT @password = user_password, @intentos_fallidos = user_intentos_fallidos_login, @num_afiliado = user_afiliado,
		   @num_profesional = user_profesional, @num_administrador = user_administrador
	FROM LOS_TRIGGERS.Usuario where user_name = @user_name

	IF(HASHBYTES('SHA2_256', @user_password) = @password)
	BEGIN
		SELECT @nro_rol = CASE @rol WHEN 'Afiliado' THEN user_afiliado
						  WHEN 'Profesional' THEN user_profesional
				          WHEN 'Administrador' THEN user_administrador
					      END
		FROM LOS_TRIGGERS.Usuario WHERE user_name = @user_name
		IF (@nro_rol is null) SET @resultado = 3 -- No tiene asignado el rol
		ELSE
			BEGIN
				UPDATE LOS_TRIGGERS.Usuario SET user_intentos_fallidos_login = 0 WHERE user_name = @user_name 
				UPDATE LOS_TRIGGERS.Afiliado set afil_habilitacion = 1 where @num_afiliado = afil_numero
				UPDATE LOS_TRIGGERS.Administrador set admi_habilitacion = 1 where @num_administrador = admi_id
				UPDATE LOS_TRIGGERS.Profesional set prof_habilitacion = 1 where @num_profesional = prof_id
				SET @resultado = 0 -- OK
			END
	END
	ELSE -- La contraseña ingresada no coincide.
	BEGIN
		UPDATE LOS_TRIGGERS.Usuario SET user_intentos_fallidos_login = user_intentos_fallidos_login + 1 WHERE user_name = @user_name
		IF (@intentos_fallidos >= 2)
		BEGIN
				UPDATE LOS_TRIGGERS.Afiliado set afil_habilitacion = 0 where @num_afiliado = afil_numero
				UPDATE LOS_TRIGGERS.Administrador set admi_habilitacion = 0 where @num_administrador = admi_id
				UPDATE LOS_TRIGGERS.Profesional set prof_habilitacion = 0 where @num_profesional = prof_id
				set @resultado = 2 -- inhabilitado
		END 
		ELSE set @resultado = 1 -- Aún tiene intentos
	END
END
ELSE -- El usuario ingresado no existe.
	SET @resultado = 4
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.usuario_tiene_permiso') is not null DROP PROCEDURE LOS_TRIGGERS.usuario_tiene_permiso
GO
CREATE PROC LOS_TRIGGERS.usuario_tiene_permiso(@rol varchar(255), @funcionalidad varchar(255), @resultado bit OUTPUT)
AS
BEGIN
	set @resultado = 0
	IF (@rol='Afiliado' AND 
		@funcionalidad IN (SELECT distinct(func_nombre) FROM LOS_TRIGGERS.Funcionalidad, LOS_TRIGGERS.Funcionalidad_Rol
						   WHERE func_id = funcionalidad AND afiliado is not null))
		set @resultado = 1
	IF(@rol = 'Administrador' AND
		@funcionalidad IN (SELECT distinct(func_nombre) FROM LOS_TRIGGERS.Funcionalidad, LOS_TRIGGERS.Funcionalidad_Rol
						   WHERE func_id = funcionalidad AND administrador is not null))
		set @resultado = 1
	IF(@rol='Profesional' AND
		@funcionalidad IN (SELECT distinct(func_nombre) FROM LOS_TRIGGERS.Funcionalidad, LOS_TRIGGERS.Funcionalidad_Rol
						   WHERE func_id = funcionalidad AND profesional is not null))
		set @resultado = 1
END;
GO

--- << ABM de Rol >> ---

IF OBJECT_ID ('LOS_TRIGGERS.ModificarRol') is not null DROP PROCEDURE LOS_TRIGGERS.ModificarRol
GO
CREATE PROC LOS_TRIGGERS.ModificarRol (@rol varchar(255), @nuevo_nombre varchar(255)) AS
	BEGIN
		update LOS_TRIGGERS.Administrador set nombre_rol = @nuevo_nombre where nombre_rol=@rol
		update LOS_TRIGGERS.Afiliado set nombre_rol = @nuevo_nombre where nombre_rol=@rol
		update LOS_TRIGGERS.Profesional set nombre_rol = @nuevo_nombre where nombre_rol=@rol
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.InhabilitarRol') is not null DROP PROCEDURE LOS_TRIGGERS.InhabilitarRol
GO
CREATE PROC LOS_TRIGGERS.InhabilitarRol (@rol varchar(255)) AS
	BEGIN
		IF (@rol='Afiliado')
			BEGIN
				update LOS_TRIGGERS.Afiliado set afil_habilitacion = 0
				update LOS_TRIGGERS.Usuario set user_afiliado = null where user_afiliado is not null
			END
		ELSE IF (@rol='Administrador')
			BEGIN
				update LOS_TRIGGERS.Administrador set admi_habilitacion = 0
				update LOS_TRIGGERS.Usuario set user_administrador = null where user_administrador is not null
			END
		ELSE IF (@rol='Profesional')
			BEGIN
				update LOS_TRIGGERS.Profesional set prof_habilitacion = 0
				update LOS_TRIGGERS.Usuario set user_profesional = null where user_profesional is not null
			END
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.HabilitarRol') is not null DROP PROCEDURE LOS_TRIGGERS.HabilitarRol
GO
CREATE PROC LOS_TRIGGERS.HabilitarRol (@rol varchar(255)) AS
	BEGIN
		IF (@rol='Afiliado')
			update LOS_TRIGGERS.Afiliado set afil_habilitacion = 1
		ELSE IF (@rol='Administrador')
			update LOS_TRIGGERS.Administrador set admi_habilitacion = 1
		ELSE IF (@rol='Profesional')
			update LOS_TRIGGERS.Profesional set prof_habilitacion = 1
	END;
GO

--- << Funcionalidades del sistema >> ---

IF OBJECT_ID ('LOS_TRIGGERS.AgregarFuncionalidadAUnRol') is not null DROP PROCEDURE LOS_TRIGGERS.AgregarFuncionalidadAUnRol
GO
CREATE PROC LOS_TRIGGERS.AgregarFuncionalidadAUnRol (@rol varchar(255), @funcionalidad varchar(255)) AS
BEGIN
		declare @func_id as numeric(18,0)
		set @func_id = (select func_id from LOS_TRIGGERS.Funcionalidad where func_nombre=@funcionalidad)
		IF (@rol='Afiliado' AND NOT EXISTS (select func_rol_id from LOS_TRIGGERS.Funcionalidad_Rol
											where funcionalidad=@func_id AND afiliado is not null))
			insert into LOS_TRIGGERS.Funcionalidad_Rol(funcionalidad, afiliado)
				select @func_id, afil_numero from LOS_TRIGGERS.Afiliado
		ELSE IF (@rol='Administrador' AND NOT EXISTS (select func_rol_id from LOS_TRIGGERS.Funcionalidad_Rol
													  where funcionalidad=@func_id AND administrador is not null))
			insert into LOS_TRIGGERS.Funcionalidad_Rol(funcionalidad, administrador)
				select @func_id, admi_id from LOS_TRIGGERS.Administrador
		ELSE IF (@rol='Profesional' AND NOT EXISTS (select func_rol_id from LOS_TRIGGERS.Funcionalidad_Rol
													where funcionalidad=@func_id AND profesional is not null))
			insert into LOS_TRIGGERS.Funcionalidad_Rol(funcionalidad, profesional)
				select @func_id, prof_id from LOS_TRIGGERS.Profesional
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.QuitarFuncionalidadAUnRol') is not null DROP PROCEDURE LOS_TRIGGERS.QuitarFuncionalidadAUnRol
GO
CREATE PROC LOS_TRIGGERS.QuitarFuncionalidadAUnRol (@rol varchar(255), @funcionalidad varchar(255)) AS
BEGIN
		declare @func_id as numeric(18,0)
		set @func_id = (select func_id from LOS_TRIGGERS.Funcionalidad where func_nombre=@funcionalidad)

		IF (@rol='Afiliado')
			delete from LOS_TRIGGERS.Funcionalidad_Rol where funcionalidad=@func_id
				AND afiliado IN (select afil_numero from LOS_TRIGGERS.Afiliado)
		ELSE IF (@rol='Administrador')
			delete from LOS_TRIGGERS.Funcionalidad_Rol where funcionalidad=@func_id
				AND administrador IN (select admi_id from LOS_TRIGGERS.Administrador)
		ELSE IF (@rol='Profesional')
			delete from LOS_TRIGGERS.Funcionalidad_Rol where funcionalidad=@func_id
				AND profesional IN (select prof_id from LOS_TRIGGERS.Profesional)
END;
GO

--- << ABM de Afiliado >> ---

IF OBJECT_ID ('LOS_TRIGGERS.ModificarAfiliadoDireccion') is not null DROP PROCEDURE LOS_TRIGGERS.ModificarAfiliadoDireccion
GO
CREATE PROC LOS_TRIGGERS.ModificarAfiliadoDireccion(@afiliado numeric(18,0), @nueva_direccion varchar(255)) AS
	BEGIN
		update LOS_TRIGGERS.Usuario set user_direccion = @nueva_direccion where user_afiliado = @afiliado
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.ModificarAfiliadoTelefono') is not null DROP PROCEDURE LOS_TRIGGERS.ModificarAfiliadoTelefono
GO
CREATE PROC LOS_TRIGGERS.ModificarAfiliadoTelefono(@afiliado numeric(18,0), @nuevo_telefono numeric(18,0)) AS
	BEGIN
		update LOS_TRIGGERS.Usuario set user_telefono = @nuevo_telefono where user_afiliado = @afiliado
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.ModificarAfiliadoMail') is not null DROP PROCEDURE LOS_TRIGGERS.ModificarAfiliadoMail
GO
CREATE PROC LOS_TRIGGERS.ModificarAfiliadoMail(@afiliado numeric(18,0), @nuevo_mail varchar(255)) AS
	BEGIN
		update LOS_TRIGGERS.Usuario set user_mail = @nuevo_mail where user_afiliado = @afiliado
	END;
GO

--- << Historial de cambios del Plan Médico de un Afiliado >> ---
IF OBJECT_ID ('LOS_TRIGGERS.ModificarAfiliadoPlanMedico') is not null DROP PROCEDURE LOS_TRIGGERS.ModificarAfiliadoPlanMedico
GO
CREATE PROC LOS_TRIGGERS.ModificarAfiliadoPlanMedico(@afiliado numeric(18,0), @nuevo_plan numeric(18,0), @motivo varchar(255),
			@fecha_sistema datetime) AS
	BEGIN
		IF (@nuevo_plan <> (select afil_plan_medico from LOS_TRIGGERS.Afiliado where afil_numero = @afiliado))
			BEGIN
				IF (@afiliado = (select afil_titular_grupo_familiar from LOS_TRIGGERS.Afiliado where afil_numero=@afiliado))
					BEGIN
						insert into LOS_TRIGGERS.Modificacion_Plan(modi_afiliado, modi_viejo_plan, modi_nuevo_plan, modi_fecha_y_hora, modi_motivo)
							select afil_numero, afil_plan_medico, @nuevo_plan, @fecha_sistema, @motivo
							from LOS_TRIGGERS.Afiliado where afil_titular_grupo_familiar=@afiliado
						update LOS_TRIGGERS.Afiliado set afil_plan_medico = @nuevo_plan where afil_titular_grupo_familiar = @afiliado
					END
				ELSE
					BEGIN
						insert into LOS_TRIGGERS.Modificacion_Plan(modi_afiliado, modi_viejo_plan, modi_nuevo_plan, modi_fecha_y_hora, modi_motivo)
							select @afiliado, afil_plan_medico, @nuevo_plan, @fecha_sistema, @motivo
							from LOS_TRIGGERS.Afiliado where afil_numero=@afiliado
						update LOS_TRIGGERS.Afiliado set afil_plan_medico = @nuevo_plan where afil_numero = @afiliado
					END
			END
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.ModificarAfiliadoEstadoCivil') is not null DROP PROCEDURE LOS_TRIGGERS.ModificarAfiliadoEstadoCivil
GO
CREATE PROC LOS_TRIGGERS.ModificarAfiliadoEstadoCivil(@afiliado numeric(18,0), @nuevoEstadoCivil varchar(255)) AS
	BEGIN
		update LOS_TRIGGERS.Afiliado set afil_estado_civil = @nuevoEstadoCivil where afil_numero = @afiliado
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.HabilitarUnAfiliado') is not null DROP PROCEDURE LOS_TRIGGERS.HabilitarUnAfiliado
GO
CREATE PROC LOS_TRIGGERS.HabilitarUnAfiliado(@afiliado numeric(18,0), @fecha_sistema datetime) AS
	BEGIN
		update LOS_TRIGGERS.Afiliado set afil_habilitacion = 1 where afil_numero = @afiliado
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.DeshabilitarUnAfiliado') is not null DROP PROCEDURE LOS_TRIGGERS.DeshabilitarUnAfiliado
GO
CREATE PROC LOS_TRIGGERS.DeshabilitarUnAfiliado(@afiliado numeric(18,0), @fecha_sistema datetime) AS
	BEGIN
		update LOS_TRIGGERS.Afiliado set afil_habilitacion = 0 where afil_numero = @afiliado
		insert into LOS_TRIGGERS.Baja_Afiliado(baja_afiliado, baja_fecha) values (@afiliado, @fecha_sistema)

		update LOS_TRIGGERS.Horario_Atencion set hora_turno=null
		where hora_turno IN (select turn_numero from LOS_TRIGGERS.Turno
							 where turn_afiliado = @afiliado AND turn_fecha>=@fecha_sistema)

		delete from LOS_TRIGGERS.Turno where turn_afiliado = @afiliado AND
			NOT EXISTS(select * from LOS_TRIGGERS.Consulta_Medica where cons_turno=turn_numero)
			AND turn_fecha>=@fecha_sistema
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.CalcularNumeroAfiliado') is not null DROP FUNCTION LOS_TRIGGERS.CalcularNumeroAfiliado
GO
CREATE FUNCTION LOS_TRIGGERS.CalcularNumeroAfiliado(@dni numeric(18,0), @numeroDelTitular numeric(18,0), @relacionConTitular varchar(255))
	RETURNS numeric(18,0)
	AS
	BEGIN
		DECLARE @numeroAfiliado numeric(18,0) 
		IF(@relacionConTitular = 'Titular' OR @relacionConTitular = NULL) set @numeroAfiliado = (@dni*100) + 1  
		ELSE IF(@relacionConTitular = 'Cónyuge') set @numeroAfiliado = @numeroDelTitular + 1
		ELSE IF(@relacionConTitular = 'Hijo/a') set @numeroAfiliado = ISNULL((select TOP 1 afil_numero from LOS_TRIGGERS.Afiliado
			where afil_titular_grupo_familiar=@numeroDelTitular
				AND afil_relacion_con_titular='Hijo/a' order by afil_numero DESC), @numeroDelTitular+1) + 1
		
		RETURN @numeroAfiliado
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.VerificarTitular') is not null DROP FUNCTION LOS_TRIGGERS.VerificarTitular
GO
CREATE FUNCTION LOS_TRIGGERS.VerificarTitular(@dni numeric(18,0), @numeroDelTitular numeric(18,0), @relacionConTitular varchar(255))
	RETURNS numeric(18,0)
	AS
	BEGIN
		DECLARE @numeroAfiliado numeric(18,0)
		IF(@numeroDelTitular IS NULL) set @numeroAfiliado = LOS_TRIGGERS.CalcularNumeroAfiliado(@dni,@numeroDelTitular,@relacionConTitular)
		ELSE set @numeroAfiliado = @numeroDelTitular		
		RETURN @numeroAfiliado
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.DarDeAltaUnAfiliado') is not null DROP PROCEDURE LOS_TRIGGERS.DarDeAltaUnAfiliado
GO
CREATE PROC LOS_TRIGGERS.DarDeAltaUnAfiliado(@usuario varchar(255), @dni numeric(18,0), @titularNumero numeric(18,0), @estadoCivil varchar(255),
			@plan numeric(18,0), @familiaresACargo numeric(2,0), @relacionConTitular varchar(255)) AS
	BEGIN
	SET IDENTITY_INSERT LOS_TRIGGERS.Afiliado ON
		insert into LOS_TRIGGERS.Afiliado(afil_numero, afil_estado_civil, afil_habilitacion, nombre_rol, afil_plan_medico,
			afil_cant_consultas_realizadas, afil_cant_familiares_a_cargo, afil_titular_grupo_familiar, afil_relacion_con_titular) 
		values (LOS_TRIGGERS.CalcularNumeroAfiliado(@dni,@titularNumero,@relacionConTitular), @estadoCivil, 1, 'Afiliado', @plan,
			0, @familiaresACargo, LOS_TRIGGERS.VerificarTitular(@dni,@titularNumero,@relacionConTitular), @relacionConTitular) 
	SET IDENTITY_INSERT LOS_TRIGGERS.Afiliado OFF	

		declare @afiliado as numeric(18,0)
		set @afiliado = (select SCOPE_IDENTITY())
		update LOS_TRIGGERS.Usuario set user_afiliado = @afiliado where user_name = @usuario

		insert into LOS_TRIGGERS.Funcionalidad_Rol(funcionalidad, afiliado)
			select distinct(funcionalidad), @afiliado
			from LOS_TRIGGERS.Funcionalidad_Rol where afiliado is not null
	END;
GO

--- << Compra de Bonos de Consulta >> ---

IF OBJECT_ID('LOS_TRIGGERS.CalcularMontoCompraBonos') is not null DROP FUNCTION LOS_TRIGGERS.CalcularMontoCompraBonos
GO
CREATE FUNCTION LOS_TRIGGERS.CalcularMontoCompraBonos(@afiliado numeric(18,0), @cantidad numeric(4,0))
	RETURNS numeric(18,0)
	AS
	BEGIN
		DECLARE @monto numeric(18,0)
		set @monto = (select plan_precio_bono_consulta from LOS_TRIGGERS.Afiliado, LOS_TRIGGERS.Plan_Medico where afil_numero = @afiliado
			AND plan_id = afil_plan_medico) * @cantidad
		
		RETURN @monto
	END
GO

IF OBJECT_ID ('LOS_TRIGGERS.ComprarBonos') is not null DROP PROCEDURE LOS_TRIGGERS.ComprarBonos
GO
CREATE PROC LOS_TRIGGERS.ComprarBonos(@afiliado numeric(18,0), @cantBonos numeric(4,0), @fecha_sistema datetime) AS
	BEGIN
		IF((select afil_habilitacion from LOS_TRIGGERS.Afiliado where afil_numero = @afiliado) = 1)
			BEGIN
				DECLARE @numeroCompra numeric(18,0), @i numeric(4,0)
				insert into LOS_TRIGGERS.Compra_Bono(comp_afiliado, comp_cantidad, comp_monto, comp_fecha_y_hora) 
					values (@afiliado, @cantBonos, LOS_TRIGGERS.CalcularMontoCompraBonos(@afiliado, @cantBonos), @fecha_sistema)
				SET @numeroCompra = @@IDENTITY
				set @i = 1
				WHILE (@i <= @cantBonos)
				BEGIN
					insert into LOS_TRIGGERS.Bono(bono_compra, bono_plan_medico, bono_fecha_impresion)
						values(@numeroCompra, (select afil_plan_medico from LOS_TRIGGERS.Afiliado where afil_numero = @afiliado), @fecha_sistema)
					set @i = @i+1
				END
			END
		ELSE PRINT 'El afiliado indicado no se encuentra activo.'
	END;
GO

--- << Pedido de Turno >> ---

IF OBJECT_ID ('LOS_TRIGGERS.ComboProfesionalesDeUnaEspecialidad') is not null DROP PROCEDURE LOS_TRIGGERS.ComboProfesionalesDeUnaEspecialidad
GO
CREATE PROC LOS_TRIGGERS.ComboProfesionalesDeUnaEspecialidad (@especialidad numeric(18,0)) AS
	BEGIN
			select distinct(profesional) as profesional_id, user_apellido+', '+user_nombre as apellido_y_nombre
			from LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Profesional, LOS_TRIGGERS.Usuario
			where especialidad=@especialidad AND user_profesional=profesional
			order by apellido_y_nombre
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.ComboFechasDisponiblesTurno') is not null DROP PROCEDURE LOS_TRIGGERS.ComboFechasDisponiblesTurno
GO
CREATE PROC LOS_TRIGGERS.ComboFechasDisponiblesTurno (@profesional numeric(18,0), @especialidad numeric(18,0), @fecha_sistema datetime) AS
	BEGIN
			select distinct(CAST(CAST(hora_fecha as date) as varchar)) as Fecha, hora_nombre_dia as Día from LOS_TRIGGERS.Horario_Atencion
			where hora_especialidad_profesional=(select espe_prof_id from LOS_TRIGGERS.Especialidad_Profesional
												 where profesional=@profesional AND especialidad=@especialidad)
			AND hora_turno IS NULL AND hora_fecha>=@fecha_sistema AND hora_fecha<=DATEADD(day, 180, @fecha_sistema)
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.HorariosDisponiblesTurno') is not null DROP PROCEDURE LOS_TRIGGERS.HorariosDisponiblesTurno
GO
CREATE PROC LOS_TRIGGERS.HorariosDisponiblesTurno (@profesional numeric(18,0), @especialidad numeric(18,0), @fecha datetime) AS
	BEGIN
		select distinct(hora_inicio) as Horario from LOS_TRIGGERS.Horario_Atencion
		where hora_especialidad_profesional=(select espe_prof_id from LOS_TRIGGERS.Especialidad_Profesional
											 where profesional=@profesional AND especialidad=@especialidad)
			AND CAST(hora_fecha as date)=cast(@fecha as date) AND hora_turno IS NULL
		order by hora_inicio asc
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.PedirTurno') is not null DROP PROCEDURE LOS_TRIGGERS.PedirTurno
GO
CREATE PROC LOS_TRIGGERS.PedirTurno (@afiliado numeric(18,00), @profesional numeric(18,00), @especialidad numeric(18,0), @fecha datetime, @hora varchar(255)) AS
BEGIN
	declare @espe_prof as numeric(18,0)
	set @espe_prof = (select espe_prof_id from LOS_TRIGGERS.Especialidad_Profesional
					  where profesional=@profesional AND especialidad=@especialidad)

	insert into LOS_TRIGGERS.Turno (turn_afiliado, turn_especialidad_profesional, turn_fecha, turn_nombre_dia, turn_hora_inicio, turn_hora_fin)
		values(@afiliado, @espe_prof, @fecha+cast(@hora as datetime), datename(weekday, @fecha), @hora,
			   format(dateadd(minute, 30, cast(@hora as datetime)), 'HH:mm'))

	update LOS_TRIGGERS.Horario_Atencion set hora_turno=(select SCOPE_IDENTITY())
		where hora_especialidad_profesional = @espe_prof AND CAST(hora_fecha as date) = CAST(@fecha as date) AND hora_inicio=@hora
END;
GO

--- << Cancelación de Turno(s) >> ---

IF OBJECT_ID ('LOS_TRIGGERS.TurnosAsignadosAUnAfiliado') is not null DROP PROCEDURE LOS_TRIGGERS.TurnosAsignadosAUnAfiliado
GO
CREATE PROC LOS_TRIGGERS.TurnosAsignadosAUnAfiliado (@afiliado numeric(18,0), @fecha_sistema datetime) AS
BEGIN
	select turn_numero as "Nº Turno", user_apellido+', '+user_nombre as Profesional, espe_descripcion as Especialidad,
		   CAST(turn_fecha as date) as Fecha, turn_nombre_dia as Día, turn_hora_inicio as Horario
	from LOS_TRIGGERS.Turno, LOS_TRIGGERS.Usuario, LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Especialidad
	where turn_afiliado=@afiliado AND turn_fecha >= DATEADD(d, 1, @fecha_sistema) AND espe_prof_id=turn_especialidad_profesional
		  AND espe_codigo=especialidad AND user_profesional=profesional
	order by turn_fecha, turn_hora_inicio
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.TurnosCanceladosAfiliado') is not null DROP PROCEDURE LOS_TRIGGERS.TurnosCanceladosAfiliado
GO
CREATE PROC LOS_TRIGGERS.TurnosCanceladosAfiliado (@afiliado numeric(18,0), @fecha_sistema datetime) AS
BEGIN
		select user_apellido+', '+user_nombre as Profesional, espe_descripcion as Especialidad,
			   CAST(canc_fecha_turno as date) as Fecha, canc_hora_turno as Horario, canc_motivo as Motivo
		from LOS_TRIGGERS.Cancelacion_Turno, LOS_TRIGGERS.Usuario, LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Especialidad
		where canc_afiliado=@afiliado AND canc_emisor_profesional is not null AND cast(canc_fecha_turno as date) >= CAST(@fecha_sistema as date)
		AND espe_prof_id=canc_especialidad_profesional AND espe_codigo=especialidad AND user_profesional=profesional
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.CancelarTurnoAfiliado') is not null DROP PROCEDURE LOS_TRIGGERS.CancelarTurnoAfiliado
GO
CREATE PROC LOS_TRIGGERS.CancelarTurnoAfiliado (@afiliado numeric(18,0), @turno numeric(18,0), @tipo_canc numeric(18,0), @motivo varchar(255),
			@fecha_sistema datetime) AS
BEGIN
	insert into LOS_TRIGGERS.Cancelacion_Turno (canc_afiliado, canc_emisor_afiliado, canc_especialidad_profesional, canc_fecha_turno,
												canc_hora_turno, canc_fecha_y_hora, canc_tipo, canc_motivo)
		select @afiliado, @afiliado, turn_especialidad_profesional, turn_fecha, turn_hora_inicio, @fecha_sistema, @tipo_canc, @motivo
		from LOS_TRIGGERS.Turno where turn_numero=@turno

	update LOS_TRIGGERS.Horario_Atencion set hora_turno=null where hora_turno=@turno

	delete from LOS_TRIGGERS.Turno where turn_numero=@turno AND
	NOT EXISTS(select * from LOS_TRIGGERS.Consulta_Medica where cons_turno=turn_numero)
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.TurnosDeUnProfesional') is not null DROP PROCEDURE LOS_TRIGGERS.TurnosDeUnProfesional
GO
CREATE PROC LOS_TRIGGERS.TurnosDeUnProfesional (@profesional numeric(18,0), @fecha_sistema datetime) AS
BEGIN
	select distinct(CAST(turn_fecha as date)) as "Fecha de atención", DATENAME(weekday, turn_fecha) as Día
	from LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Turno
	where profesional=@profesional AND turn_especialidad_profesional=espe_prof_id AND turn_fecha>=@fecha_sistema
	AND NOT EXISTS (select * from LOS_TRIGGERS.Cancelacion_Turno where canc_emisor_profesional=@profesional AND
	CAST(canc_fecha_turno as date)=CAST(turn_fecha as date))
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.FechasDeAtencionProfesional') is not null DROP PROCEDURE LOS_TRIGGERS.FechasDeAtencionProfesional
GO
CREATE PROC LOS_TRIGGERS.FechasDeAtencionProfesional (@profesional numeric(18,0), @fecha_sistema datetime) AS
BEGIN
	select distinct(cast(hora_fecha as date)) as "Fecha de atención", hora_nombre_dia as Día
	from LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Horario_Atencion
	where profesional=@profesional AND hora_especialidad_profesional=espe_prof_id
		AND (hora_turno <> 0 OR hora_turno is null) AND hora_fecha>=DATEADD(d, 1, @fecha_sistema) order by 1
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.CancelarTurnoProfesionalDiaParticular') is not null DROP PROCEDURE LOS_TRIGGERS.CancelarTurnoProfesionalDiaParticular
GO
CREATE PROC LOS_TRIGGERS.CancelarTurnoProfesionalDiaParticular (@profesional numeric(18,0), @fecha datetime, @tipo_canc numeric(18,0),
			@motivo varchar(255), @fecha_sistema datetime) AS
BEGIN
	-- Cancela los turnos que existan en la fecha indicada:
	insert into LOS_TRIGGERS.Cancelacion_Turno (canc_afiliado, canc_emisor_profesional, canc_especialidad_profesional, canc_fecha_turno,
												canc_hora_turno, canc_fecha_y_hora, canc_tipo, canc_motivo)
		select turn_afiliado, @profesional, turn_especialidad_profesional, turn_fecha, turn_hora_inicio, @fecha_sistema, @tipo_canc, @motivo
		from LOS_TRIGGERS.Turno where turn_especialidad_profesional IN (select espe_prof_id from LOS_TRIGGERS.Especialidad_Profesional
																		where profesional=@profesional)
		AND CAST(turn_fecha as date)=CAST(@fecha as date)

	delete from LOS_TRIGGERS.Turno where turn_numero IN (select turn_numero from LOS_TRIGGERS.Turno
														 where turn_especialidad_profesional IN (select espe_prof_id
																								 from LOS_TRIGGERS.Especialidad_Profesional
																								 where profesional=@profesional)
														AND CAST(turn_fecha as date)=CAST(@fecha as date)) AND
	NOT EXISTS(select * from LOS_TRIGGERS.Consulta_Medica where cons_turno=turn_numero)

	-- Deja no disponibles los horarios de atención de la fecha indicada:
	insert into LOS_TRIGGERS.Cancelacion_Turno (canc_emisor_profesional, canc_fecha_turno, canc_fecha_y_hora, canc_tipo, canc_motivo)
		values(@profesional, @fecha, @fecha_sistema, @tipo_canc, @motivo)

	update LOS_TRIGGERS.Horario_Atencion
		set hora_turno = 0
		where hora_especialidad_profesional IN (select espe_prof_id from LOS_TRIGGERS.Especialidad_Profesional where profesional=@profesional)
		AND cast(hora_fecha as date)=CAST(@fecha as date)
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.CancelarTurnosProfesionalPeriodo') is not null DROP PROCEDURE LOS_TRIGGERS.CancelarTurnosProfesionalPeriodo
GO
CREATE PROC LOS_TRIGGERS.CancelarTurnosProfesionalPeriodo (@profesional numeric(18,0), @desde datetime, @hasta datetime,
			@tipo_canc numeric(18,0), @motivo varchar(255), @fecha_sistema datetime) AS
BEGIN
	declare @fecha_atencion as datetime
	declare CANCELACIONES cursor for select distinct(hora_fecha) from LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Horario_Atencion
									where profesional=@profesional AND espe_prof_id=hora_especialidad_profesional
										  AND (hora_fecha BETWEEN @desde AND @hasta)
	OPEN CANCELACIONES
	FETCH NEXT FROM CANCELACIONES INTO @fecha_atencion
	WHILE @@fetch_status = 0
	BEGIN
			EXEC LOS_TRIGGERS.CancelarTurnoProfesionalDiaParticular @profesional, @fecha_atencion, @tipo_canc, @motivo, @fecha_sistema

		FETCH NEXT FROM CANCELACIONES INTO @fecha_atencion
	END
CLOSE CANCELACIONES
DEALLOCATE CANCELACIONES
END;
GO

--- << Registrar la Agenda de un Profesional >> ---

IF OBJECT_ID ('LOS_TRIGGERS.Calendario') IS NOT NULL DROP TABLE LOS_TRIGGERS.Calendario
CREATE TABLE [LOS_TRIGGERS].[Calendario](
	[dia_del_año] [date] NOT NULL primary key
	);

DECLARE @primer_dia datetime, @ultimo_dia datetime
SET @primer_dia = DATEADD(YEAR, -1, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0))
SET @ultimo_dia = DATEADD(d, 730, @primer_dia)

WHILE @primer_dia <= @ultimo_dia
	BEGIN
		insert into [LOS_TRIGGERS].[Calendario] (dia_del_año)
			select @primer_dia SET @primer_dia = DATEADD(dd, 1, @primer_dia)
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.RegistrarDiaAtencionProfesional') is not null DROP PROCEDURE LOS_TRIGGERS.RegistrarDiaAtencionProfesional
GO
CREATE PROC LOS_TRIGGERS.RegistrarDiaAtencionProfesional (@profesional numeric(18,0), @especialidad numeric(18,0), @dia varchar(255),
			@inicio varchar(255), @fin varchar(255)) AS
BEGIN
	insert into LOS_TRIGGERS.Dia_Atencion(dia_nombre_dia, dia_hora_inicio, dia_hora_fin, dia_especialidad_profesional)
		select @dia, @inicio, @fin, (select espe_prof_id from LOS_TRIGGERS.Especialidad_Profesional
		                             where profesional=@profesional AND especialidad=@especialidad)

	update LOS_TRIGGERS.Profesional
		set prof_horas_laborales = CONVERT(numeric(2,0), (select prof_horas_laborales from LOS_TRIGGERS.Profesional where prof_id=@profesional)
														  + DATEDIFF(hour, @inicio, @fin))
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.RegistrarAgendaProfesional') is not null DROP PROCEDURE LOS_TRIGGERS.RegistrarAgendaProfesional
GO
CREATE PROC LOS_TRIGGERS.RegistrarAgendaProfesional (@profesional numeric(18,0), @especialidad numeric(18,0), @desde datetime,
			@hasta datetime, @fecha_sistema datetime) AS
BEGIN
	declare @espe_prof as numeric(18,0), @d_desde as date, @d_hasta as date, @inicio as varchar(255), @fin as varchar(255),
			@nombre_dia as varchar(255), @fecha as date
	set @d_desde = CAST(@desde as date)
	set @d_hasta = CAST(@hasta as date)
	set @espe_prof=(select espe_prof_id from Especialidad_Profesional where profesional=@profesional AND especialidad=@especialidad)

	update LOS_TRIGGERS.Especialidad_Profesional
		set disponible_desde_fecha = @d_desde, disponible_hasta_fecha = @d_hasta
		where espe_prof_id=@espe_prof

	declare AGENDA cursor for select dia_nombre_dia, dia_hora_inicio, dia_hora_fin, dia_del_año
							   from LOS_TRIGGERS.Dia_Atencion, LOS_TRIGGERS.Calendario
							    where dia_especialidad_profesional=@espe_prof AND dia_del_año>=@fecha_sistema
									AND datename(weekday, dia_del_año)=dia_nombre_dia
	OPEN AGENDA
	FETCH NEXT FROM AGENDA INTO @nombre_dia, @inicio, @fin, @fecha
	WHILE @@fetch_status = 0
		BEGIN
			WHILE(@inicio<@fin AND @fecha<=@d_hasta)
				BEGIN
					insert into LOS_TRIGGERS.Horario_Atencion(hora_especialidad_profesional, hora_fecha, hora_nombre_dia, hora_inicio, hora_fin)
						values(@espe_prof, @fecha, @nombre_dia, @inicio, FORMAT(DATEADD(MINUTE, 30, @inicio), 'HH:mm'))
					
					set @inicio = FORMAT(DATEADD(MINUTE, 30, @inicio), 'HH:mm')
				END;

			FETCH NEXT FROM AGENDA INTO @nombre_dia, @inicio, @fin, @fecha
		END
	CLOSE AGENDA
	DEALLOCATE AGENDA
END;
GO

--- << Consulta Médica y Diagnóstico >> ---

IF OBJECT_ID ('LOS_TRIGGERS.TurnosAsignadosProfesionalEspecialidad') is not null DROP PROCEDURE LOS_TRIGGERS.TurnosAsignadosProfesionalEspecialidad
GO
CREATE PROC LOS_TRIGGERS.TurnosAsignadosProfesionalEspecialidad (@profesional numeric(18,0), @especialidad numeric(18,0), @fecha_sistema datetime) AS
BEGIN
	select turn_numero as "Nº Turno", turn_hora_inicio as Horario, turn_afiliado as "Nº Afiliado", user_apellido+', '+user_nombre as "Nombre y Apellido"
	from LOS_TRIGGERS.Turno, LOS_TRIGGERS.Usuario
	where turn_especialidad_profesional=(select espe_prof_id from LOS_TRIGGERS.Especialidad_Profesional
										 where profesional=@profesional AND especialidad=@especialidad)
	AND turn_fecha_y_hora_asistencia is null AND turn_fecha>=@fecha_sistema AND cast(turn_fecha as date) = cast(@fecha_sistema as date)
	AND user_afiliado=turn_afiliado order by 2 asc
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.registro_llegada') is not null DROP PROCEDURE LOS_TRIGGERS.registro_llegada
GO			
CREATE PROC LOS_TRIGGERS.registro_llegada (@turn_numero numeric(18,0), @bono_numero numeric(18,0), @afiliado numeric(18,0), @fecha datetime)
AS
BEGIN
	UPDATE LOS_TRIGGERS.Turno SET turn_fecha_y_hora_asistencia = @fecha
		WHERE turn_numero = @turn_numero
	INSERT INTO LOS_TRIGGERS.Consulta_Medica(cons_turno)
		VALUES (@turn_numero)
	UPDATE LOS_TRIGGERS.Bono SET bono_afiliado = @afiliado, bono_consulta_medica = @@IDENTITY
		WHERE bono_numero = @bono_numero
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.ConsultasPendientesAfiliado') is not null DROP PROCEDURE LOS_TRIGGERS.ConsultasPendientesAfiliado
GO				
CREATE PROC LOS_TRIGGERS.ConsultasPendientesAfiliado(@profesional numeric(18,0), @especialidad numeric(18,0), @afiliado numeric(18,0),
			@fecha_sistema datetime)
AS
BEGIN
	select turn_numero as "Nº Turno", CAST(turn_fecha as date) as Fecha, turn_hora_inicio as Horario, cons_numero as "Nº Consulta"
	from LOS_TRIGGERS.Turno, LOS_TRIGGERS.Consulta_Medica
	where turn_afiliado=@afiliado AND turn_especialidad_profesional = (select espe_prof_id from LOS_TRIGGERS.Especialidad_Profesional
																		where profesional=@profesional AND especialidad=@especialidad)
		AND turn_fecha>=@fecha_sistema AND cons_turno=turn_numero AND cons_diagnostico is null
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.registro_resultado') is not null DROP PROCEDURE LOS_TRIGGERS.registro_resultado
GO				
CREATE PROC LOS_TRIGGERS.registro_resultado(@consulta_numero numeric(18,0), @fecha_y_hora datetime, @diag_sintomas varchar(255), @diag_descripcion varchar(255))
AS
BEGIN
	insert into LOS_TRIGGERS.Diagnostico(diag_fecha_y_hora, diag_sintomas, diag_descripcion)
		values(@fecha_y_hora, @diag_sintomas, @diag_descripcion)

	UPDATE LOS_TRIGGERS.Consulta_Medica
	SET cons_diagnostico = @@IDENTITY where cons_numero = @consulta_numero
END;
GO

--- << Listados Estadísticos >> ---

IF OBJECT_ID ('LOS_TRIGGERS.EspecialidadesConMasCancelaciones') is not null DROP PROCEDURE LOS_TRIGGERS.EspecialidadesConMasCancelaciones
GO
CREATE PROC LOS_TRIGGERS.EspecialidadesConMasCancelaciones (@anio int, @semestre int) AS
BEGIN
	declare @mes as int
	IF (@semestre = 1) set @mes = 1
	ELSE IF (@semestre = 2) set @mes = 7

	select TOP 5 espe_codigo as "Código", espe_descripcion as Especialidad, ISNULL(COUNT(canc_id), 0) as "Cantidad de Cancelaciones"
	from LOS_TRIGGERS.Cancelacion_Turno, LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Especialidad
	where year(canc_fecha_y_hora)=@anio AND (month(canc_fecha_y_hora) BETWEEN @mes AND @mes+5)
		AND espe_prof_id=canc_especialidad_profesional AND espe_codigo=especialidad
	group by espe_codigo, espe_descripcion order by 3 DESC
END;
GO

IF OBJECT_ID('LOS_TRIGGERS.ProfesionalesMasConsultadosPorPlan') is not null DROP PROCEDURE LOS_TRIGGERS.ProfesionalesMasConsultadosPorPlan
GO
CREATE PROC LOS_TRIGGERS.ProfesionalesMasConsultadosPorPlan(@anio int, @semestre int, @plan numeric(18,0)) AS
BEGIN
	declare @mes as int
	IF (@semestre = 1) set @mes = 1
	ELSE IF (@semestre = 2) set @mes = 7

	select TOP 5 profesional as "Id Profesional", user_apellido+', '+user_nombre as "Nombre y Apellido", cast(especialidad as varchar)+' - '+espe_descripcion as Especialidad,
				 ISNULL(COUNT(cons_numero), 0) as "Cantidad Consultas"
	from LOS_TRIGGERS.Afiliado, LOS_TRIGGERS.Turno, LOS_TRIGGERS.Usuario, LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Especialidad, LOS_TRIGGERS.Consulta_Medica
	where afil_plan_medico = @plan AND afil_numero = turn_afiliado AND year(turn_fecha)=@anio AND (month(turn_fecha) BETWEEN @mes AND @mes+5)
	AND cons_turno = turn_numero AND turn_especialidad_profesional = espe_prof_id AND profesional = user_profesional AND especialidad = espe_codigo
	group by profesional, user_apellido+', '+user_nombre, cast(especialidad as varchar)+' - '+espe_descripcion order by 4 DESC
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.ProfesionalesConMenosHorasTrabajadas') is not null DROP PROCEDURE LOS_TRIGGERS.ProfesionalesConMenosHorasTrabajadas
GO
CREATE PROC LOS_TRIGGERS.ProfesionalesConMenosHorasTrabajadas (@anio int, @semestre int, @plan numeric(18,0), @especialidad numeric(18,0)) AS
BEGIN
	declare @mes as int
	IF (@semestre = 1) set @mes = 1
	ELSE IF (@semestre = 2) set @mes = 7

	select TOP 5 profesional as "Id Profesional", user_apellido+', '+user_nombre as "Nombre y Apellido", ISNULL((COUNT(turn_numero)*30)/60, 0) as "Horas Trabajadas"
	from  LOS_TRIGGERS.Consulta_Medica, LOS_TRIGGERS.Turno, LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Usuario, LOS_TRIGGERS.Afiliado, LOS_TRIGGERS.Plan_Medico
	where year(turn_fecha)=@anio AND (month(turn_fecha) BETWEEN @mes AND @mes+5) AND cons_numero=turn_numero AND espe_prof_id=turn_especialidad_profesional
		AND especialidad=@especialidad AND user_profesional=profesional AND afil_numero=turn_afiliado AND afil_plan_medico=@plan
	group by profesional, user_apellido+', '+user_nombre order by 3 ASC
END;
GO

IF OBJECT_ID('LOS_TRIGGERS.AfiliadosConMasBonosComprados') is not null DROP PROCEDURE LOS_TRIGGERS.AfiliadosConMasBonosComprados
GO
CREATE PROC LOS_TRIGGERS.AfiliadosConMasBonosComprados(@anio int, @semestre int) AS
BEGIN
	declare @mes as int
	IF (@semestre = 1) set @mes = 1
	ELSE IF (@semestre = 2) set @mes = 7

	select TOP 5 afil_numero as "Número Afiliado" , user_apellido+', '+user_nombre as "Nombre y Apellido", "Grupo Familiar" = CASE
		WHEN (afil_titular_grupo_familiar = afil_numero AND (afil_cant_familiares_a_cargo is null OR afil_cant_familiares_a_cargo = 0)) THEN 'No'
	    WHEN (afil_titular_grupo_familiar = afil_numero AND afil_cant_familiares_a_cargo <> 0) THEN 'Sí'
		WHEN (afil_titular_grupo_familiar is not null AND afil_titular_grupo_familiar <> afil_numero) THEN 'Sí'
		WHEN (afil_titular_grupo_familiar is null) THEN 'No'
		END, ISNULL(SUM(comp_cantidad), 0) as "Bonos Comprados"
	from LOS_TRIGGERS.Afiliado, LOS_TRIGGERS.Compra_Bono, LOS_TRIGGERS.Usuario
	where year(comp_fecha_y_hora)=@anio AND (month(comp_fecha_y_hora) BETWEEN @mes AND @mes+5)
		AND afil_numero = comp_afiliado AND user_afiliado = afil_numero
	group by afil_numero, user_apellido+', '+user_nombre, afil_titular_grupo_familiar, afil_cant_familiares_a_cargo order by 4 DESC		
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.EspecialidadesConMasBonosUtilizados') is not null DROP PROCEDURE LOS_TRIGGERS.EspecialidadesConMasBonosUtilizados
GO
CREATE PROC LOS_TRIGGERS.EspecialidadesConMasBonosUtilizados (@anio int, @semestre int) AS
BEGIN
	declare @mes as int
	IF (@semestre = 1) set @mes = 1
	ELSE IF (@semestre = 2) set @mes = 7

	select TOP 5 espe_codigo as "Código", espe_descripcion as Especialidad, ISNULL(COUNT(cons_numero), 0) as "Bonos Consulta Utilizados"
	from LOS_TRIGGERS.Consulta_Medica, LOS_TRIGGERS.Turno, LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Especialidad
	where year(turn_fecha)=@anio AND (month(turn_fecha) BETWEEN @mes AND @mes+5) AND
		turn_numero=cons_turno AND espe_prof_id=turn_especialidad_profesional AND espe_codigo=especialidad
	group by espe_codigo, espe_descripcion order by 3 DESC
END;
GO

PRINT 'Fin CREACIÓN Objetos de Base de Datos'
GO

/*************************************************************************************
*			         MIGRACIÓN (de tabla Maestra al Sistema)                          *
**************************************************************************************/
PRINT 'Comienza la MIGRACIÓN.'
GO

SET DATEFIRST 7 -- Domingo

--- << Planes Médicos >>
SET IDENTITY_INSERT LOS_TRIGGERS.Plan_Medico ON
insert into LOS_TRIGGERS.Plan_Medico (plan_id, plan_med_descripcion, plan_precio_bono_consulta, plan_precio_bono_farmacia)
	select distinct(Plan_Med_Codigo), Plan_Med_Descripcion, Plan_Med_Precio_Bono_Consulta, Plan_Med_Precio_Bono_Farmacia
	from gd_esquema.Maestra where Plan_Med_Codigo is not null
SET IDENTITY_INSERT LOS_TRIGGERS.Plan_Medico OFF
PRINT '1. Tabla Plan Médico OK'
GO

--- << Tipos de Especialidad >>
SET IDENTITY_INSERT LOS_TRIGGERS.Tipo_Especialidad ON
insert into LOS_TRIGGERS.Tipo_Especialidad (tipo_id, tipo_descripcion)
	select distinct(Tipo_Especialidad_Codigo), Tipo_Especialidad_Descripcion from gd_esquema.Maestra
	where Tipo_Especialidad_Codigo is not null
SET IDENTITY_INSERT LOS_TRIGGERS.Tipo_Especialidad OFF
PRINT '2. Tabla Tipo_Especialidad OK'
GO

--- << Especialidades >>
SET IDENTITY_INSERT LOS_TRIGGERS.Especialidad ON
insert into LOS_TRIGGERS.Especialidad (espe_codigo, espe_descripcion, espe_tipo)
	select distinct(Especialidad_Codigo), Especialidad_Descripcion, Tipo_Especialidad_Codigo
	from gd_esquema.Maestra where Especialidad_Codigo is not null
SET IDENTITY_INSERT LOS_TRIGGERS.Especialidad OFF
PRINT '3. Tabla Especialidad OK'
GO

--- << Afiliados >>
SET IDENTITY_INSERT LOS_TRIGGERS.Afiliado ON
declare @dni as numeric(18,0), @direccion as varchar(255), @mail as varchar(255), @nombre as varchar(255), @nro_afiliado as numeric(18,0),
		@apellido as varchar(255), @nacimiento as datetime, @telefono as numeric(18,0), @plan as numeric(18,0)
declare AFILIADOS cursor for select distinct (Paciente_Dni), Paciente_Direccion, Paciente_Mail, Paciente_Nombre, Paciente_Apellido,
									Paciente_Fecha_Nac, Paciente_Telefono, Plan_Med_Codigo
							 from gd_esquema.Maestra where Paciente_Dni is not null
OPEN AFILIADOS
FETCH NEXT FROM AFILIADOS INTO @dni, @direccion, @mail, @nombre, @apellido, @nacimiento, @telefono, @plan
WHILE @@fetch_status = 0
	BEGIN
		set @nro_afiliado = CONVERT(numeric(18,0), CAST(@dni as varchar) + '01')
		insert into LOS_TRIGGERS.Afiliado (afil_numero, afil_habilitacion, afil_cant_consultas_realizadas, afil_plan_medico, afil_titular_grupo_familiar,
										   nombre_rol, afil_cant_familiares_a_cargo, afil_relacion_con_titular)
			values (@nro_afiliado, 1, 0, @plan, @nro_afiliado, 'Afiliado', 0, 'Titular')
	
		insert into LOS_TRIGGERS.Usuario (user_name, user_password, user_afiliado, user_intentos_fallidos_login, user_dni, user_direccion, user_mail,
										  user_nombre, user_apellido, user_fecha_nacimiento, user_telefono)
			values(CONVERT(varchar(255), @dni), HASHBYTES('SHA2_256', CONVERT(varchar(255), @dni)), @nro_afiliado, 0, @dni, @direccion, @mail,
				   @nombre, @apellido, @nacimiento, @telefono)
		
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
declare @dni as numeric(18,0), @direccion as varchar(255), @mail as varchar(255), @nombre as varchar(255),
		@apellido as varchar(255), @nacimiento as datetime, @telefono as numeric(18,0), @nro_profesional as numeric(18,0)

declare PROFESIONALES cursor for select distinct (Medico_Dni), Medico_Direccion, Medico_Mail, Medico_Nombre,
				Medico_Apellido, Medico_Fecha_Nac, Medico_Telefono from gd_esquema.Maestra where Medico_Dni is not null
OPEN PROFESIONALES
FETCH NEXT FROM PROFESIONALES INTO @dni, @direccion, @mail, @nombre, @apellido, @nacimiento, @telefono
WHILE @@fetch_status = 0
	BEGIN
		set @nro_profesional = CONVERT(numeric(18,0), CAST(@dni as varchar) + '99')
		insert into LOS_TRIGGERS.Profesional(prof_id, prof_habilitacion, prof_horas_laborales, nombre_rol)
			values (@nro_profesional, 1, 0, 'Profesional')
		
		insert into LOS_TRIGGERS.Usuario (user_name, user_password, user_profesional, user_intentos_fallidos_login, user_dni, user_direccion,
										  user_mail, user_nombre, user_apellido, user_fecha_nacimiento, user_telefono)
			values(CONVERT(varchar(255), CONVERT(int, @dni)), HASHBYTES('SHA2_256', CONVERT(varchar(255), CONVERT(int, @dni))), @nro_profesional, 0,
				   @dni, @direccion, @mail, @nombre, @apellido, @nacimiento, @telefono)

		FETCH NEXT FROM PROFESIONALES INTO @dni, @direccion, @mail, @nombre, @apellido, @nacimiento, @telefono
	END
CLOSE PROFESIONALES
DEALLOCATE PROFESIONALES
SET IDENTITY_INSERT LOS_TRIGGERS.Profesional OFF
PRINT '5. Tabla Profesional OK'
GO

-- << Especialidad_Profesional >>
insert into LOS_TRIGGERS.Especialidad_Profesional(especialidad, profesional, disponible_desde_fecha, disponible_hasta_fecha)
select distinct(Especialidad_Codigo), CONVERT(numeric(18,0), CAST(Medico_Dni as varchar) + '99'), CAST('2015-01-01' as date), CAST('2016-01-01' as date)
from gd_esquema.Maestra where Medico_Dni is not null
PRINT '6. Tabla Especialidad_Profesional OK'
GO

--- << Bonos y Compras de Bonos >>
SET IDENTITY_INSERT LOS_TRIGGERS.Bono ON
declare @bono as numeric(18,0), @fecha_impr as datetime, @afiliado as numeric(18,0), @plan as numeric(18,0), @precio as numeric(18,0),
		@fecha_compra as datetime
declare BONOS cursor for select distinct(Bono_Consulta_Numero), Bono_Consulta_Fecha_Impresion, Paciente_Dni, Plan_Med_Codigo,
								Plan_Med_Precio_Bono_Consulta, Compra_Bono_Fecha
						 from gd_esquema.Maestra where Compra_Bono_Fecha is not null

OPEN BONOS
FETCH NEXT FROM BONOS INTO @bono, @fecha_impr, @afiliado, @plan, @precio, @fecha_compra
WHILE @@fetch_status = 0
	BEGIN
			insert into LOS_TRIGGERS.Compra_Bono (comp_fecha_y_hora, comp_afiliado, comp_monto, comp_cantidad)
				values (@fecha_compra, CONVERT(numeric(18,0), CAST(@afiliado as varchar)+'01'), @precio, 1)

			insert into LOS_TRIGGERS.Bono (bono_numero, bono_fecha_impresion, bono_afiliado, bono_plan_medico, bono_compra)
				values (@bono, @fecha_impr, CONVERT(numeric(18,0), CAST(@afiliado as varchar)+'01'), @plan, (select SCOPE_IDENTITY()))

		FETCH NEXT FROM BONOS INTO @bono, @fecha_impr, @afiliado, @plan, @precio, @fecha_compra
	END
CLOSE BONOS
DEALLOCATE BONOS
SET IDENTITY_INSERT LOS_TRIGGERS.Bono OFF
PRINT '7. Tablas Bono y Compra_Bono OK'
GO

--- << Turnos, Consultas Médicas & Diagnósticos >>
SET IDENTITY_INSERT LOS_TRIGGERS.Turno ON
declare @turno as numeric(18,0), @fecha_turno as datetime, @sintomas as varchar(255), @descripcion as varchar(255),
	@bono as numeric(18,0), @profesional as numeric(18,0), @especialidad as numeric(18,0), @afiliado as numeric(18,0)
declare TURNOS cursor for select distinct (Turno_Numero), Turno_Fecha, Consulta_Sintomas, Consulta_Enfermedades, Bono_Consulta_Numero, Medico_Dni,
								 Especialidad_Codigo, Paciente_Dni
						  from gd_esquema.Maestra where Turno_Numero is not null AND Bono_Consulta_Numero is not null
OPEN TURNOS
FETCH NEXT FROM TURNOS INTO @turno, @fecha_turno, @sintomas, @descripcion, @bono, @profesional, @especialidad, @afiliado
WHILE @@fetch_status = 0
	BEGIN
			insert into LOS_TRIGGERS.Turno (turn_numero, turn_fecha, turn_nombre_dia, turn_hora_inicio, turn_hora_fin, turn_especialidad_profesional, turn_afiliado)
				select @turno, @fecha_turno, datename(weekday, @fecha_turno), FORMAT(@fecha_turno, 'HH:mm'), FORMAT(dateadd(minute, 30, @fecha_turno), 'HH:mm'),
					   espe_prof_id, CONVERT(numeric(18,0), CAST(@afiliado as varchar) + '01')
				from LOS_TRIGGERS.Especialidad_Profesional where especialidad=@especialidad AND profesional=CONVERT(numeric(18,0), CAST(@profesional as varchar) + '99')
			
			insert into LOS_TRIGGERS.Diagnostico (diag_sintomas, diag_descripcion) values(@sintomas, @descripcion)
				
			insert into LOS_TRIGGERS.Consulta_Medica (cons_diagnostico, cons_turno) values ((select SCOPE_IDENTITY()), @turno)
				
			update LOS_TRIGGERS.Bono set bono_consulta_medica=(select SCOPE_IDENTITY()) where bono_numero=@bono

		FETCH NEXT FROM TURNOS INTO @turno, @fecha_turno, @sintomas, @descripcion, @bono, @profesional, @especialidad, @afiliado
	END
CLOSE TURNOS
DEALLOCATE TURNOS
SET IDENTITY_INSERT LOS_TRIGGERS.Turno OFF
PRINT '8. Tabla Turno OK'
GO

-- << Cantidad de Consultas realizadas por Afiliado >>
declare @afiliado as numeric(18,0), @consultas as int
declare CONSULTAS cursor for select turn_afiliado, COUNT(distinct(cons_numero))
					from gd_esquema.Maestra, LOS_TRIGGERS.Afiliado, LOS_TRIGGERS.Consulta_Medica, LOS_TRIGGERS.Turno
					where turn_afiliado=CONVERT(numeric(18,0), CAST(Paciente_Dni as varchar) + '01') AND cons_turno=turn_numero
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
PRINT '9. Consultas realizadas por Afiliados OK'
GO

-- << Rango de atención de la Clínica >>
declare @clinica as numeric(18,0)
insert into LOS_TRIGGERS.Clinica (clin_nombre) values('Clinica Medica FRBA')
set @clinica = (select SCOPE_IDENTITY())
insert into LOS_TRIGGERS.Dia_Atencion(dia_nombre_dia, dia_hora_inicio, dia_hora_fin, dia_clinica)
	values('Lunes', '07:00', '20:00', @clinica), ('Martes', '07:00', '20:00', @clinica), ('Miércoles', '07:00', '20:00', @clinica),
		  ('Jueves', '07:00', '20:00', @clinica), ('Viernes', '07:00', '20:00', @clinica), ('Sábado', '10:00', '15:00', @clinica)

declare @nombre_dia as varchar(255), @inicio as varchar(255), @fin as varchar(255)
declare AGENDA_CLINICA cursor for select dia_nombre_dia, dia_hora_inicio, dia_hora_fin
						from LOS_TRIGGERS.Dia_Atencion
						where dia_especialidad_profesional is null
OPEN AGENDA_CLINICA
	FETCH NEXT FROM AGENDA_CLINICA INTO @nombre_dia, @inicio, @fin
	WHILE @@fetch_status = 0
	BEGIN
		WHILE(@inicio<@fin)
			BEGIN
				insert into LOS_TRIGGERS.Horario_Atencion(hora_nombre_dia, hora_inicio, hora_fin)
					values(@nombre_dia, @inicio, FORMAT(DATEADD(MINUTE, 30, @inicio), 'HH:mm'))
					
				set @inicio = FORMAT(DATEADD(MINUTE, 30, @inicio), 'HH:mm')
			END;

	FETCH NEXT FROM AGENDA_CLINICA INTO @nombre_dia, @inicio, @fin
	END
CLOSE AGENDA_CLINICA
DEALLOCATE AGENDA_CLINICA
PRINT '10. Rango de Atención de la Clínica OK'
GO

--- << Agenda Profesional >>
insert into LOS_TRIGGERS.Dia_Atencion(dia_hora_inicio, dia_hora_fin, dia_nombre_dia, dia_especialidad_profesional)
	select distinct(turn_hora_inicio), turn_hora_fin, turn_nombre_dia, turn_especialidad_profesional
	from LOS_TRIGGERS.Turno

insert into LOS_TRIGGERS.Horario_Atencion(hora_especialidad_profesional, hora_fecha, hora_nombre_dia, hora_inicio, hora_fin, hora_turno)
	select dia_especialidad_profesional, cast(dia_del_año as date), dia_nombre_dia, dia_hora_inicio, dia_hora_fin, (select turn_numero
		from LOS_TRIGGERS.Turno where turn_especialidad_profesional=dia_especialidad_profesional
			AND CAST(turn_fecha as date)=dia_del_año AND turn_hora_inicio=dia_hora_inicio)
	from LOS_TRIGGERS.Dia_Atencion, LOS_TRIGGERS.Calendario
	where datename(weekday, dia_del_año)=dia_nombre_dia AND dia_especialidad_profesional IS NOT NULL
PRINT '11. Agendas Profesionales OK'
GO

-- << Tipos de Cancelaciones de Turno >>
insert into LOS_TRIGGERS.Tipo_Cancelacion (tipo_descripcion)
	values ('Ya no necesita el servicio'),
			('Ha encontrado otro servicio alternativo'),
			('La atención al cliente no ha cubierto sus expectativas'),
			('No puede asistir por un problema personal'),
			('Otro motivo')
PRINT '12. Tipos de Cancelación de Turno OK'
GO

-- << Funcionalidades del Sistema >>
insert into LOS_TRIGGERS.Funcionalidad (func_nombre)
	values ('Abm de Rol'),
			('Registro de Usuario'),
			('Abm de Afiliado'),
			('Abm de Profesional'),
			('Abm de Especialidad Médica'),
			('Compra de Bono'),
			('Abm de Plan'),
			('Pedido de Turno'),
			('Registro de Agenda Profesional'),
			('Registro de Consulta Médica'),
			('Registro de Diagnóstico Médico'),
			('Cancelación de Turno'),
			('Listado Estadístico')
PRINT '12.  Funcionalidades del Sistema OK'
GO

-- << Alta de un usuario Administrador >>
INSERT INTO LOS_TRIGGERS.Administrador (admi_habilitacion, nombre_rol) values (1, 'Administrador')
INSERT INTO LOS_TRIGGERS.Usuario (user_name, user_password, user_intentos_fallidos_login, user_administrador, user_nombre)
	values ('admin', HASHBYTES('SHA2_256', CONVERT(varchar(255), 'w23e')), 0, @@IDENTITY, 'Administrador General')

-- << Carga de Funcionalidades a los Roles del sistema >>
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'ABM de Rol'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'ABM de Afiliado'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'ABM de Profesional'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'ABM de Plan'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'ABM de Especialidad Médica'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'Registro de Usuario'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'Registro de Agenda Profesional'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'Registro de Consulta Médica'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'Compra de Bono'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'Listado Estadístico'

EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Profesional', 'Registro de Diagnóstico Médico'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Profesional', 'Cancelación de Turno'

EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Afiliado', 'Compra de Bono'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Afiliado', 'Pedido de Turno'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Afiliado', 'Cancelación de Turno'

SET NOCOUNT OFF;