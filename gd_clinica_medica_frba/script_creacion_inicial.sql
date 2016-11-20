USE [GD2C2016]
GO

SET NOCOUNT ON;
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
	[hora_fecha] [varchar](255) NULL,
	[hora_inicio] [varchar](255) NULL,
	[hora_fin] [varchar](255) NULL,
	[hora_turno] [numeric](18, 0)
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

IF OBJECT_ID ('LOS_TRIGGERS.usuario_login') is not null DROP PROCEDURE LOS_TRIGGERS.usuario_login
GO	
CREATE PROC LOS_TRIGGERS.usuario_login (@user_name varchar(30), @user_password varchar(30), @rol varchar(30), @resultado int OUTPUT)
AS
BEGIN
DECLARE @intentos_fallidos numeric(1), @password varbinary(300), @num_afiliado numeric(18), @num_profesional numeric(18), @num_administrador numeric(18)

SELECT @password = user_password,@intentos_fallidos=user_intentos_fallidos_login,
@num_afiliado = user_afiliado, @num_profesional = user_profesional, @num_administrador = user_administrador
FROM LOS_TRIGGERS.Usuario where user_name = @user_name
IF (@password = HASHBYTES('SHA2_256', CONVERT(varchar(255), CONVERT(int, @user_password))))
	BEGIN
		SET @resultado = 1
		UPDATE LOS_TRIGGERS.Usuario SET user_intentos_fallidos_login = 0  WHERE user_name = @user_name 
		IF (@intentos_fallidos > 2)
		BEGIN
			SET @resultado = 2
			IF (@rol='Afiliado')
				UPDATE LOS_TRIGGERS.Afiliado set afil_habilitacion = 1
				where  @num_afiliado = afil_numero
			IF (@rol='Administrador')
				UPDATE LOS_TRIGGERS.Administrador set admi_habilitacion = 1
				where @num_administrador = admi_id
			IF (@rol='Profesional')
				UPDATE LOS_TRIGGERS.Profesional set prof_habilitacion = 1
				where @num_profesional = prof_id
		END

	END	
ELSE
IF (@password is not null)
	BEGIN
		SET @resultado = 0
		IF (@intentos_fallidos >= 2)
			BEGIN
				UPDATE LOS_TRIGGERS.Usuario SET user_intentos_fallidos_login = user_intentos_fallidos_login + 1 WHERE user_name = @user_name 
				IF (@rol='Afiliado' and @intentos_fallidos = 2)
					UPDATE LOS_TRIGGERS.Afiliado set afil_habilitacion = 0 where  @num_afiliado = afil_numero
				IF (@rol='Administrador' and @intentos_fallidos = 2)
					UPDATE LOS_TRIGGERS.Administrador set admi_habilitacion = 0 where @num_administrador = admi_id
				IF (@rol='Profesional' and @intentos_fallidos = 2)
					UPDATE LOS_TRIGGERS.Profesional set prof_habilitacion = 0 where @num_profesional = prof_id
			END 
		ELSE
			UPDATE LOS_TRIGGERS.Usuario SET user_intentos_fallidos_login = user_intentos_fallidos_login + 1	WHERE user_name = @user_name
	END
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.usuario_traer_ID_rol') is not null DROP PROCEDURE LOS_TRIGGERS.usuario_traer_ID_rol
GO	
CREATE PROC LOS_TRIGGERS.usuario_traer_ID_rol(
	@usuario nvarchar(255), @rol nvarchar(255), @nro numeric(18) OUTPUT)
AS 
BEGIN
	SELECT @nro=CASE @rol WHEN 'Afiliado' THEN user_afiliado
				 WHEN 'Profesional' THEN user_profesional
				 WHEN 'Administrativo' THEN user_administrador
				 END
		FROM LOS_TRIGGERS.Usuario
		WHERE @usuario = user_name
	IF (@nro is null) set @nro = 0
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.usuario_tiene_permiso') is not null DROP PROCEDURE LOS_TRIGGERS.usuario_tiene_permiso
GO
CREATE PROC LOS_TRIGGERS.usuario_tiene_permiso(
	@rol nvarchar(255), @funcionalidad nvarchar(255), @resultado bit OUTPUT)
AS
BEGIN
	IF @rol='Afiliado'
		(SELECT * FROM LOS_TRIGGERS.Funcionalidad AS f 
		JOIN LOS_TRIGGERS.Funcionalidad_Rol AS fr on f.func_id = fr.funcionalidad
		WHERE f.func_nombre = @funcionalidad and fr.afiliado is not null)
	IF @rol = 'Administrador'
		(SELECT * FROM LOS_TRIGGERS.Funcionalidad AS f 
		JOIN LOS_TRIGGERS.Funcionalidad_Rol AS fr on f.func_id = fr.funcionalidad
		WHERE f.func_nombre = @funcionalidad and fr.administrador is not null)
	IF @rol='Profesional'
		(SELECT * FROM LOS_TRIGGERS.Funcionalidad AS f 
		JOIN LOS_TRIGGERS.Funcionalidad_Rol AS fr on f.func_id = fr.funcionalidad
		WHERE f.func_nombre = @funcionalidad and fr.profesional is not null)
	IF (@@ROWCOUNT = 0)
		SET @RESULTADO =0	
	ELSE
		SET @RESULTADO =1	
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

IF OBJECT_ID ('LOS_TRIGGERS.AltaRolAdministrador') is not null DROP PROCEDURE LOS_TRIGGERS.AltaRolAdministrador
GO
CREATE PROC LOS_TRIGGERS.AltaRolAdministrador AS
	BEGIN
		IF OBJECT_ID ('LOS_TRIGGERS.Administrador') IS NOT NULL DROP TABLE LOS_TRIGGERS.Administrador
		CREATE TABLE [LOS_TRIGGERS].[Administrador](
			[admi_id] [numeric](18, 0) IDENTITY(1,1) NOT NULL primary key,
			[admi_habilitacion] [bit] NULL,
			[nombre_rol] [varchar](255) NULL
		);
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
		IF (@func_id IS NOT NULL)
			BEGIN
				IF (@rol='Afiliado' AND NOT EXISTS (select func_rol_id from LOS_TRIGGERS.Funcionalidad_Rol where funcionalidad=@func_id AND afiliado is not null))
					insert into LOS_TRIGGERS.Funcionalidad_Rol(funcionalidad, afiliado) select @func_id, afil_numero from LOS_TRIGGERS.Afiliado
				ELSE IF (@rol='Administrador' AND NOT EXISTS (select func_rol_id from LOS_TRIGGERS.Funcionalidad_Rol where funcionalidad=@func_id AND administrador is not null))
					insert into LOS_TRIGGERS.Funcionalidad_Rol(funcionalidad, administrador) select @func_id, admi_id from LOS_TRIGGERS.Administrador
				ELSE IF (@rol='Profesional' AND NOT EXISTS (select func_rol_id from LOS_TRIGGERS.Funcionalidad_Rol where funcionalidad=@func_id AND profesional is not null))
					insert into LOS_TRIGGERS.Funcionalidad_Rol(funcionalidad, profesional) select @func_id, prof_id from LOS_TRIGGERS.Profesional
			END
		ELSE PRINT 'La funcionalidad '+@funcionalidad+' no pertence al sistema.'
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.QuitarFuncionalidadAUnRol') is not null DROP PROCEDURE LOS_TRIGGERS.QuitarFuncionalidadAUnRol
GO
CREATE PROC LOS_TRIGGERS.QuitarFuncionalidadAUnRol (@rol varchar(255), @funcionalidad varchar(255)) AS
BEGIN
		declare @func_id as numeric(18,0)
		set @func_id = (select func_id from LOS_TRIGGERS.Funcionalidad where func_nombre=@funcionalidad)

		IF (@rol='Afiliado')
			delete from LOS_TRIGGERS.Funcionalidad_Rol where funcionalidad=@func_id AND afiliado IN (select afil_numero from LOS_TRIGGERS.Afiliado)
		ELSE IF (@rol='Administrador')
			delete from LOS_TRIGGERS.Funcionalidad_Rol where funcionalidad=@func_id AND administrador IN (select admi_id from LOS_TRIGGERS.Administrador)
		ELSE IF (@rol='Profesional')
			delete from LOS_TRIGGERS.Funcionalidad_Rol where funcionalidad=@func_id AND profesional IN (select prof_id from LOS_TRIGGERS.Profesional)
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
CREATE PROC LOS_TRIGGERS.ModificarAfiliadoPlanMedico(@afiliado numeric(18,0), @nuevo_plan numeric(18,0), @motivo varchar(255), @fecha_sistema datetime) AS
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

IF OBJECT_ID ('LOS_TRIGGERS.DarDeBajaUnAfiliado') is not null DROP PROCEDURE LOS_TRIGGERS.DarDeBajaUnAfiliado
GO
CREATE PROC LOS_TRIGGERS.DarDeBajaUnAfiliado(@afiliado numeric(18,0), @fecha_sistema datetime) AS
	BEGIN
		update LOS_TRIGGERS.Afiliado set afil_habilitacion = 0 where afil_numero = @afiliado
		delete from LOS_TRIGGERS.Turno where turn_afiliado = @afiliado AND NOT EXISTS (select * from LOS_TRIGGERS.Consulta_Medica where cons_turno=turn_numero)
		insert into LOS_TRIGGERS.Baja_Afiliado(baja_afiliado, baja_fecha) values (@afiliado, @fecha_sistema)
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
		ELSE IF(@relacionConTitular = 'Hijo/a') set @numeroAfiliado = ISNULL((select TOP 1 afil_numero from LOS_TRIGGERS.Afiliado where afil_titular_grupo_familiar=@numeroDelTitular AND afil_relacion_con_titular='Hijo/a' order by afil_numero DESC), @numeroDelTitular+1) + 1
		
		RETURN @numeroAfiliado
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.DarDeAltaUnAfiliado') is not null DROP PROCEDURE LOS_TRIGGERS.DarDeAltaUnAfiliado
GO
CREATE PROC LOS_TRIGGERS.DarDeAltaUnAfiliado(@usuario numeric(18,0), @dni numeric(18,0), @titularNumero numeric(18,0), @estadoCivil varchar(255), @plan numeric(18,0), @familiaresACargo numeric(2,0), @relacionConTitular varchar(255)) AS
	SET IDENTITY_INSERT LOS_TRIGGERS.Afiliado ON
	BEGIN
		insert into LOS_TRIGGERS.Afiliado(afil_numero, afil_estado_civil, afil_habilitacion, nombre_rol, afil_plan_medico, afil_cant_consultas_realizadas, afil_cant_familiares_a_cargo, afil_titular_grupo_familiar, afil_relacion_con_titular) 
			values (LOS_TRIGGERS.CalcularNumeroAfiliado(@dni,@titularNumero,@relacionConTitular), @estadoCivil, 1, 'Afiliado', @plan, 0, @familiaresACargo, @titularNumero, @relacionConTitular) 
		
		update LOS_TRIGGERS.Usuario set user_afiliado = (select SCOPE_IDENTITY()) where user_id=@usuario

		IF(@relacionConTitular='Hijo/a' OR @relacionConTitular='Cónyuge')
			update LOS_TRIGGERS.Afiliado set afil_cant_familiares_a_cargo = afil_cant_familiares_a_cargo +1 where afil_numero = @titularNumero
	
	SET IDENTITY_INSERT LOS_TRIGGERS.Afiliado OFF
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
		set @monto = (select plan_precio_bono_consulta from LOS_TRIGGERS.Afiliado, LOS_TRIGGERS.Plan_Medico where afil_numero = @afiliado AND plan_id = afil_plan_medico) * @cantidad
		
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
				SET IDENTITY_INSERT LOS_TRIGGERS.Bono ON
				set @i = 1
				WHILE (@i <= @cantBonos)
				BEGIN
					insert into LOS_TRIGGERS.Bono(bono_compra, bono_plan_medico, bono_fecha_impresion)
						values(@numeroCompra, (select afil_plan_medico from LOS_TRIGGERS.Afiliado where afil_numero = @afiliado), @fecha_sistema)
					set @i = @i+1
				END
				SET IDENTITY_INSERT LOS_TRIGGERS.Bono OFF
			END
		ELSE PRINT 'El afiliado indicado no se encuentra activo.'
	END;
GO

--- << Pedido de Turno >> ---

IF OBJECT_ID ('LOS_TRIGGERS.ComboEspecialidades') is not null DROP VIEW LOS_TRIGGERS.ComboEspecialidades
GO
CREATE VIEW LOS_TRIGGERS.ComboEspecialidades AS
	select espe_codigo, espe_descripcion from LOS_TRIGGERS.Especialidad
WITH CHECK OPTION
GO


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
			select distinct(hora_fecha), hora_nombre_dia from LOS_TRIGGERS.Horario_Atencion
			where hora_especialidad_profesional=(select espe_prof_id from LOS_TRIGGERS.Especialidad_Profesional where profesional=@profesional AND especialidad=@especialidad)
				AND hora_fecha>=@fecha_sistema AND hora_turno IS NULL
				AND NOT EXISTS (select * from LOS_TRIGGERS.Cancelacion_Turno where  canc_emisor_profesional=@profesional AND canc_fecha_turno=hora_fecha AND canc_hora_turno=hora_inicio)
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.HorariosDisponiblesTurno') is not null DROP PROCEDURE LOS_TRIGGERS.HorariosDisponiblesTurno
GO
CREATE PROC LOS_TRIGGERS.HorariosDisponiblesTurno (@profesional numeric(18,0), @especialidad numeric(18,0), @fecha datetime, @fecha_sistema datetime) AS
	BEGIN
		select hora_id, hora_inicio from LOS_TRIGGERS.Horario_Atencion
		where hora_especialidad_profesional=(select espe_prof_id from LOS_TRIGGERS.Especialidad_Profesional where profesional=@profesional AND especialidad=@especialidad)
			AND hora_fecha>=@fecha_sistema AND hora_turno IS NULL
			AND NOT EXISTS (select * from LOS_TRIGGERS.Cancelacion_Turno where  canc_emisor_profesional=@profesional AND canc_fecha_turno=hora_fecha AND canc_hora_turno=hora_inicio)
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.PedirTurno') is not null DROP PROCEDURE LOS_TRIGGERS.PedirTurno
GO
CREATE PROC LOS_TRIGGERS.PedirTurno (@afiliado numeric(18,00), @profesional numeric(18,00), @especialidad numeric(18,0), @fecha date, @hora varchar(255)) AS
BEGIN
		IF (NOT EXISTS (select turn_numero from LOS_TRIGGERS.Turno where CAST(turn_fecha as date)=@fecha AND turn_hora_inicio=@hora)
			AND NOT EXISTS (select canc_id from LOS_TRIGGERS.Cancelacion_Turno where CAST(canc_fecha_turno as date)=@fecha AND canc_hora_turno=@hora))
			BEGIN	
				insert into LOS_TRIGGERS.Turno (turn_afiliado, turn_especialidad_profesional, turn_fecha, turn_nombre_dia, turn_hora_inicio, turn_hora_fin)
					select @afiliado, (select espe_prof_id from LOS_TRIGGERS.Especialidad_Profesional where profesional=@profesional AND especialidad=@especialidad), cast(@fecha as datetime)+cast(@hora as datetime),
						datename(weekday, @fecha), @hora, format(dateadd(minute, 30, cast(@hora as datetime)), 'HH:mm')

				update LOS_TRIGGERS.Horario_Atencion set hora_turno=(select SCOPE_IDENTITY())
				where hora_especialidad_profesional=(select espe_prof_id from LOS_TRIGGERS.Especialidad_Profesional where profesional=@profesional AND especialidad=@especialidad)
					AND hora_fecha=@fecha AND hora_inicio=@hora
			END
		ELSE PRINT 'Ya hay un turno asignado para ese horario.'
END
GO

--- << Cancelación de Turno(s) >> ---

IF OBJECT_ID ('LOS_TRIGGERS.TurnosAsignadosAUnAfiliado') is not null DROP PROCEDURE LOS_TRIGGERS.TurnosAsignadosAUnAfiliado
GO
CREATE PROC LOS_TRIGGERS.TurnosAsignadosAUnAfiliado (@afiliado numeric(18,0), @fecha_sistema datetime) AS
	BEGIN
		select turn_numero, user_apellido+', '+user_nombre as profesional, espe_descripcion, CONVERT(date, turn_fecha) as fecha, turn_nombre_dia, turn_hora_inicio
		from LOS_TRIGGERS.Turno, LOS_TRIGGERS.Usuario, LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Especialidad
		where turn_afiliado=@afiliado AND turn_fecha >= CAST(@fecha_sistema as date) AND espe_prof_id=turn_especialidad_profesional AND espe_codigo=especialidad AND user_profesional=profesional
		order by turn_fecha, turn_hora_inicio
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.CancelarTurnoAfiliado') is not null DROP PROCEDURE LOS_TRIGGERS.CancelarTurnoAfiliado
GO
CREATE PROC LOS_TRIGGERS.CancelarTurnoAfiliado (@afiliado numeric(18,0), @turno numeric(18,0), @tipo_canc numeric(18,0), @motivo varchar(255), @fecha_sistema datetime) AS
BEGIN
	IF EXISTS (select * from LOS_TRIGGERS.Turno where turn_numero=@turno)
		BEGIN
			insert into LOS_TRIGGERS.Cancelacion_Turno (canc_afiliado, canc_emisor_afiliado, canc_especialidad_profesional, canc_fecha_turno, canc_hora_turno, canc_fecha_y_hora, canc_tipo, canc_motivo)
				select @afiliado, @afiliado, turn_especialidad_profesional, turn_fecha, turn_hora_inicio, @fecha_sistema, @tipo_canc, @motivo
				from LOS_TRIGGERS.Turno where turn_numero=@turno

			update LOS_TRIGGERS.Horario_Atencion set hora_turno=null where hora_turno=@turno

			delete from LOS_TRIGGERS.Turno where turn_numero=@turno

		END
	ELSE PRINT 'El turno indicado ya ha sido cancelado.'
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.CancelarTurnoProfesionalDiaParticular') is not null DROP PROCEDURE LOS_TRIGGERS.CancelarTurnoProfesionalDiaParticular
GO
CREATE PROC LOS_TRIGGERS.CancelarTurnoProfesionalDiaParticular (@profesional numeric(18,0), @turno numeric(18,0), @tipo_canc numeric(18,0), @motivo varchar(255), @fecha_sistema datetime) AS
BEGIN
	IF EXISTS (select * from LOS_TRIGGERS.Turno where turn_numero=@turno)
		BEGIN
			insert into LOS_TRIGGERS.Cancelacion_Turno (canc_afiliado, canc_emisor_profesional, canc_especialidad_profesional, canc_fecha_turno, canc_hora_turno, canc_fecha_y_hora, canc_tipo, canc_motivo)
				select turn_afiliado, @profesional, turn_especialidad_profesional, turn_fecha, turn_hora_inicio, @fecha_sistema, @tipo_canc, @motivo
				from LOS_TRIGGERS.Turno where turn_numero=@turno

			delete from LOS_TRIGGERS.Turno where turn_numero=@turno
		END
	ELSE PRINT 'El turno indicado ya ha sido cancelado.'
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.CancelarTurnosProfesionalPeriodo') is not null DROP PROCEDURE LOS_TRIGGERS.CancelarTurnosProfesionalPeriodo
GO
CREATE PROC LOS_TRIGGERS.CancelarTurnosProfesionalPeriodo (@profesional numeric(18,0), @desde date, @hasta date, @tipo_canc numeric(18,0), @motivo varchar(255), @fecha_sistema datetime) AS
BEGIN
	declare @turno as numeric(18,0)
	declare CANCELACIONES cursor for select turn_numero from LOS_TRIGGERS.Turno, LOS_TRIGGERS.Especialidad_Profesional
									where espe_prof_id=turn_especialidad_profesional AND profesional=@profesional AND (turn_fecha BETWEEN @desde AND @hasta)
	OPEN CANCELACIONES
	FETCH NEXT FROM CANCELACIONES INTO @turno
	WHILE @@fetch_status = 0
	BEGIN
			EXEC LOS_TRIGGERS.CancelarTurnoProfesionalDiaParticular @profesional, @turno, @tipo_canc,@motivo, @fecha_sistema

		FETCH NEXT FROM CANCELACIONES INTO @turno
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
SET @ultimo_dia = DATEADD(d, 365, @primer_dia)

WHILE @primer_dia <= @ultimo_dia
	BEGIN
		insert into [LOS_TRIGGERS].[Calendario] (dia_del_año)
			select @primer_dia SET @primer_dia = DATEADD(dd, 1, @primer_dia)
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.EstaEnRangoDeLaClinica') is not null DROP FUNCTION LOS_TRIGGERS.EstaEnRangoDeLaClinica
GO
CREATE FUNCTION LOS_TRIGGERS.EstaEnRangoDeLaClinica(@dia varchar(255), @inicio varchar(255), @fin varchar(255))
	RETURNS bit
	AS
	BEGIN
		DECLARE @resultado bit, @inicio_clin varchar(255), @fin_clin varchar(255)
		set @inicio_clin = (select dia_hora_inicio from LOS_TRIGGERS.Dia_Atencion where dia_clinica is not null AND dia_nombre_dia=@dia)
		set @fin_clin = (select dia_hora_fin from LOS_TRIGGERS.Dia_Atencion where dia_clinica is not null AND dia_nombre_dia=@dia)

		IF(CAST(@inicio as time) <= CAST(@inicio_clin as time) AND CAST(@fin as time) <= CAST(@fin_clin as time)) set @resultado = 1  
		ELSE set @resultado = 0
		
		RETURN @resultado
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.RegistrarDiaAtencionProfesional') is not null DROP PROCEDURE LOS_TRIGGERS.RegistrarDiaAtencionProfesional
GO
CREATE PROC LOS_TRIGGERS.RegistrarDiaAtencionProfesional (@profesional numeric(18,0), @especialidad numeric(18,0), @dia varchar(255), @inicio varchar(255), @fin varchar(255)) AS
BEGIN
	declare @horas_acumuladas as int
	set @horas_acumuladas = (select prof_horas_laborales from LOS_TRIGGERS.Profesional where prof_id=@profesional) + DATEDIFF(hour, @fin, @inicio)
	
	IF (LOS_TRIGGERS.EstaEnRangoDeLaClinica(@dia, @inicio, @fin) = 1)
		IF (@horas_acumuladas <= 48)
			BEGIN
				insert into LOS_TRIGGERS.Dia_Atencion(dia_nombre_dia, dia_hora_fin, dia_hora_inicio, dia_especialidad_profesional)
					select @dia, @inicio, @fin, (select espe_prof_id from LOS_TRIGGERS.Especialidad_Profesional where profesional=@profesional AND especialidad=@especialidad)

				update LOS_TRIGGERS.Profesional
					set prof_horas_laborales = CONVERT(numeric(2,0), @horas_acumuladas)
			END
		ELSE PRINT 'El profesional no puede sumar más de 48 hs laborales.'
	ELSE PRINT 'El rango horario indicado no pertence al de la Clínica.'
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.RegistrarAgendaProfesional') is not null DROP PROCEDURE LOS_TRIGGERS.RegistrarAgendaProfesional
GO
CREATE PROC LOS_TRIGGERS.RegistrarAgendaProfesional (@profesional numeric(18,0), @especialidad numeric(18,0), @desde date, @hasta date, @fecha_sistema datetime) AS
BEGIN
	declare @espe_prof as numeric(18,0)
	set @espe_prof=(select espe_prof_id from Especialidad_Profesional where profesional=@profesional AND especialidad=@especialidad)

	IF NOT EXISTS (select * from LOS_TRIGGERS.Horario_Atencion where hora_especialidad_profesional=@espe_prof)
	BEGIN
		IF (@desde >= cast(@fecha_sistema as date) AND @desde < @hasta AND @hasta <= CONVERT(date, DATEADD(yy, DATEDIFF(yy,0,GETDATE())+ 1, -1)))
			BEGIN
				update LOS_TRIGGERS.Especialidad_Profesional
					set disponible_desde_fecha = @desde, disponible_hasta_fecha = @hasta
					where espe_prof_id=@espe_prof
			END
		ELSE PRINT 'El rango horario es inválido o no está dentro del resto de este año.'

		declare @inicio as varchar(255), @fin as varchar(255), @nombre_dia as varchar(255), @fecha as date
		declare AGENDA cursor for select dia_nombre_dia, dia_hora_inicio, dia_hora_fin, dia_del_año
							from LOS_TRIGGERS.Dia_Atencion, LOS_TRIGGERS.Calendario
							where dia_especialidad_profesional=@espe_prof AND dia_del_año>=@fecha_sistema AND datename(weekday, dia_del_año)=dia_nombre_dia
		OPEN AGENDA
		FETCH NEXT FROM AGENDA INTO @nombre_dia, @inicio, @fin, @fecha
		WHILE @@fetch_status = 0
			BEGIN
				WHILE(@inicio<@fin AND @fecha<=@hasta)
					BEGIN
						insert into LOS_TRIGGERS.Horario_Atencion(hora_especialidad_profesional, hora_fecha, hora_nombre_dia, hora_inicio, hora_fin)
							values(@espe_prof, @fecha, @nombre_dia, @inicio, FORMAT(DATEADD(MINUTE, 30, @inicio), 'HH:mm'))
					
						set @inicio = FORMAT(DATEADD(MINUTE, 30, @inicio), 'HH:mm')
					END;

				FETCH NEXT FROM AGENDA INTO @nombre_dia, @inicio, @fin, @fecha
			END
		CLOSE AGENDA
		DEALLOCATE AGENDA
		END
		ELSE PRINT 'Ya se ha cargado la Agenda para la Especialidad-Profesional y esta es inalterable.'
END;
GO

--- << Consulta Médica y Diagnóstico >> ---

IF OBJECT_ID ('LOS_TRIGGERS.registro_llegada') is not null DROP PROCEDURE LOS_TRIGGERS.registro_llegada
GO			
CREATE PROC LOS_TRIGGERS.registro_llegada (
	@turn_numero numeric(18,0), @bono_numero numeric(18,0), @afiliado numeric(18,0), @fecha datetime)
AS
BEGIN
	UPDATE LOS_TRIGGERS.Turno SET turn_fecha_y_hora_asistencia = convert(datetime,@fecha)
		WHERE turn_numero = @turn_numero
	INSERT INTO LOS_TRIGGERS.Diagnostico (diag_fecha_y_hora,diag_sintomas,diag_descripcion)
		VALUES (null,null,null)
	INSERT INTO LOS_TRIGGERS.Consulta_Medica (cons_diagnostico,cons_turno) 
		VALUES (@@IDENTITY,@turn_numero)
	UPDATE LOS_TRIGGERS.Bono SET bono_afiliado = @afiliado, bono_consulta_medica = @@IDENTITY
		WHERE bono_numero = @bono_numero
END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.registro_resultado') is not null DROP PROCEDURE LOS_TRIGGERS.registro_resultado
GO				
CREATE PROC LOS_TRIGGERS.registro_resultado (
	@turn_numero numeric(18,0), @fecha_y_hora datetime, @diag_sintomas varchar(255), @diag_descripcion varchar(255))
AS
BEGIN
	DECLARE @ID_DIAGNOSTICO NUMERIC(18,0)
	SELECT @ID_DIAGNOSTICO=cons_diagnostico FROM LOS_TRIGGERS.Consulta_Medica 
	WHERE cons_turno = @turn_numero
	UPDATE LOS_TRIGGERS.Diagnostico SET diag_fecha_y_hora = @fecha_y_hora, diag_sintomas = @diag_sintomas, diag_descripcion = @diag_descripcion
	WHERE diag_id = @ID_DIAGNOSTICO
END;
GO

--- << Listado Estadístico >> ---

IF OBJECT_ID ('LOS_TRIGGERS.EspecialidadesConMasCancelaciones') is not null DROP PROCEDURE LOS_TRIGGERS.EspecialidadesConMasCancelaciones
GO
CREATE PROC LOS_TRIGGERS.EspecialidadesConMasCancelaciones (@anio int, @semestre int) AS
	BEGIN
		declare @mes as int
		IF (@semestre = 1) set @mes = 1
		ELSE IF (@semestre = 2) set @mes = 7

		select TOP 5 espe_codigo, espe_descripcion, ISNULL(COUNT(canc_id), 0) as cantidad_cancelaciones
		from LOS_TRIGGERS.Cancelacion_Turno, LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Especialidad
		where espe_prof_id=canc_especialidad_profesional AND espe_codigo=especialidad
			AND year(canc_fecha_y_hora)=@anio AND (month(canc_fecha_y_hora) BETWEEN @mes AND @mes+5)
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

select TOP 5 profesional, user_apellido+', '+user_nombre as "nombre y apellido", ISNULL(COUNT(cons_numero), 0) as "cantidad de consultas realizadas", especialidad, espe_descripcion
from LOS_TRIGGERS.Afiliado, LOS_TRIGGERS.Turno, LOS_TRIGGERS.Usuario, LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Especialidad, LOS_TRIGGERS.Consulta_Medica
where afil_plan_medico = @plan AND afil_numero = turn_afiliado AND cons_turno = turn_numero AND turn_especialidad_profesional = espe_prof_id AND profesional = user_profesional AND especialidad = espe_codigo
		AND year(turn_fecha)=@anio AND (month(turn_fecha) BETWEEN @mes AND @mes+5)
group by profesional, user_apellido+', '+user_nombre, especialidad, espe_descripcion
order by 3 DESC
		
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.ProfesionalesConMenosHorasTrabajadas') is not null DROP PROCEDURE LOS_TRIGGERS.ProfesionalesConMenosHorasTrabajadas
GO
CREATE PROC LOS_TRIGGERS.ProfesionalesConMenosHorasTrabajadas (@anio int, @semestre int, @plan numeric(18,0), @especialidad numeric(18,0)) AS
	BEGIN
		declare @mes as int
		IF (@semestre = 1) set @mes = 1
		ELSE IF (@semestre = 2) set @mes = 7

		select TOP 5 profesional, user_apellido+', '+user_nombre as nombre_y_apellido, ISNULL((COUNT(turn_numero)*30)/60, 0) as cantidad_horas_trabajadas
		from  LOS_TRIGGERS.Consulta_Medica, LOS_TRIGGERS.Turno, LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Usuario, LOS_TRIGGERS.Afiliado, LOS_TRIGGERS.Plan_Medico
		where cons_numero=turn_numero AND espe_prof_id=turn_especialidad_profesional AND especialidad=@especialidad
			AND user_profesional=profesional AND afil_numero=turn_afiliado AND afil_plan_medico=@plan
			AND year(turn_fecha)=@anio AND (month(turn_fecha) BETWEEN @mes AND @mes+5)
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

		select TOP 5 afil_numero as afiliado , user_apellido+', '+user_nombre as "nombre y apellido", ISNULL(SUM(comp_cantidad), 0) as "cantidad de bonos comprados",
			"pertenece a grupo familiar" = CASE 
				WHEN (afil_titular_grupo_familiar = afil_numero AND (afil_cant_familiares_a_cargo is null OR afil_cant_familiares_a_cargo = 0)) THEN 'NO'
				WHEN (afil_titular_grupo_familiar = afil_numero AND afil_cant_familiares_a_cargo <> 0) THEN 'SI'
				WHEN (afil_titular_grupo_familiar is not null AND afil_titular_grupo_familiar <> afil_numero) THEN 'SI'
				WHEN (afil_titular_grupo_familiar is null) THEN 'NO'
				ELSE 'NO'
				END
		from LOS_TRIGGERS.Afiliado, LOS_TRIGGERS.Compra_Bono, LOS_TRIGGERS.Usuario
		where afil_numero = comp_afiliado AND user_afiliado = afil_numero
			AND year(comp_fecha_y_hora)=@anio AND (month(comp_fecha_y_hora) BETWEEN @mes AND @mes+5)
		group by afil_numero, user_apellido+', '+user_nombre, afil_cant_familiares_a_cargo, afil_titular_grupo_familiar
		order by 3 DESC		
	END;
GO

IF OBJECT_ID ('LOS_TRIGGERS.EspecialidadesConMasBonosUtilizados') is not null DROP PROCEDURE LOS_TRIGGERS.EspecialidadesConMasBonosUtilizados
GO
CREATE PROC LOS_TRIGGERS.EspecialidadesConMasBonosUtilizados (@anio int, @semestre int) AS
	BEGIN
		declare @mes as int
		IF (@semestre = 1) set @mes = 1
		ELSE IF (@semestre = 2) set @mes = 7

		select TOP 5 espe_codigo, espe_descripcion, ISNULL(COUNT(cons_numero), 0) as bonos_consulta_utilizados
		from LOS_TRIGGERS.Consulta_Medica, LOS_TRIGGERS.Turno, LOS_TRIGGERS.Especialidad_Profesional, LOS_TRIGGERS.Especialidad
		where turn_numero=cons_turno AND espe_prof_id=turn_especialidad_profesional AND espe_codigo=especialidad
			AND year(turn_fecha)=@anio AND (month(turn_fecha) BETWEEN @mes AND @mes+5)
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
declare AFILIADOS cursor for select distinct (Paciente_Dni), Paciente_Direccion, Paciente_Mail, Paciente_Nombre, Paciente_Apellido, Paciente_Fecha_Nac, Paciente_Telefono, Plan_Med_Codigo
							from gd_esquema.Maestra where Paciente_Dni is not null
OPEN AFILIADOS
FETCH NEXT FROM AFILIADOS INTO @dni, @direccion, @mail, @nombre, @apellido, @nacimiento, @telefono, @plan
WHILE @@fetch_status = 0
	BEGIN
		set @nro_afiliado = CONVERT(numeric(18,0), CAST(@dni as varchar) + '01')
		insert into LOS_TRIGGERS.Afiliado (afil_numero, afil_habilitacion, afil_cant_consultas_realizadas, afil_plan_medico, afil_titular_grupo_familiar, nombre_rol)
			values (@nro_afiliado, 1, 0, @plan, @nro_afiliado, 'Afiliado')
	
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
select distinct(Especialidad_Codigo), CONVERT(numeric(18,0), CAST(Medico_Dni as varchar) + '99')
from gd_esquema.Maestra where Medico_Dni is not null
PRINT '6. Tabla Especialidad_Profesional OK'
GO

--- << Bonos y Compras de Bonos >>
SET IDENTITY_INSERT LOS_TRIGGERS.Bono ON
declare @bono as numeric(18,0), @fecha_impr as datetime, @afiliado as numeric(18,0), @plan as numeric(18,0), @precio as numeric(18,0), @fecha_compra as datetime
declare BONOS cursor for select distinct(Bono_Consulta_Numero), Bono_Consulta_Fecha_Impresion, Paciente_Dni, Plan_Med_Codigo, Plan_Med_Precio_Bono_Consulta, Compra_Bono_Fecha
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
declare @turno as numeric(18,0), @fecha_turno as datetime, @sintomas as varchar(255), @descripcion as varchar(255), @bono as numeric(18,0), @profesional as numeric(18,0), @especialidad as numeric(18,0)
declare TURNOS cursor for select distinct (Turno_Numero), Turno_Fecha, Consulta_Sintomas, Consulta_Enfermedades, Bono_Consulta_Numero, Medico_Dni, Especialidad_Codigo
							from gd_esquema.Maestra where Turno_Numero is not null AND Bono_Consulta_Numero is not null
OPEN TURNOS
FETCH NEXT FROM TURNOS INTO @turno, @fecha_turno, @sintomas, @descripcion, @bono, @profesional, @especialidad
WHILE @@fetch_status = 0
	BEGIN
			insert into LOS_TRIGGERS.Turno (turn_numero, turn_fecha, turn_nombre_dia, turn_hora_inicio, turn_hora_fin, turn_especialidad_profesional)
				select @turno, @fecha_turno, datename(weekday, @fecha_turno), FORMAT(@fecha_turno, 'HH:mm'), FORMAT(dateadd(minute, 30, @fecha_turno), 'HH:mm'), espe_prof_id
				from LOS_TRIGGERS.Especialidad_Profesional where especialidad=@especialidad AND profesional=CONVERT(numeric(18,0), CAST(@profesional as varchar) + '99')
			
			insert into LOS_TRIGGERS.Diagnostico (diag_sintomas, diag_descripcion) values(@sintomas, @descripcion)
				
			insert into LOS_TRIGGERS.Consulta_Medica (cons_diagnostico, cons_turno) values ((select SCOPE_IDENTITY()), @turno)
				
			update LOS_TRIGGERS.Bono
				set bono_consulta_medica=(select SCOPE_IDENTITY()) where bono_numero=@bono

		FETCH NEXT FROM TURNOS INTO @turno, @fecha_turno, @sintomas, @descripcion, @bono, @profesional, @especialidad
	END
CLOSE TURNOS
DEALLOCATE TURNOS
SET IDENTITY_INSERT LOS_TRIGGERS.Turno OFF
PRINT '8. Tabla Turno OK'
GO

-- << Afiliados y Profesionales en Turnos >>
declare @turno as numeric(18,0), @afiliado as numeric(18,0), @profesional as numeric(18,0), @especialidad as numeric(18,0)
declare TURNOS cursor for select distinct (Turno_Numero), Paciente_Dni, Medico_Dni, Especialidad_Codigo from gd_esquema.Maestra where Turno_Numero is not null
OPEN TURNOS
FETCH NEXT FROM TURNOS INTO @turno, @afiliado, @profesional, @especialidad
WHILE @@fetch_status = 0
	BEGIN
			update LOS_TRIGGERS.Turno
				set turn_afiliado=CONVERT(numeric(18,0), CAST(@afiliado as varchar) + '01'), turn_especialidad_profesional=(select espe_prof_id from LOS_TRIGGERS.Especialidad_Profesional where profesional=CONVERT(numeric(18,0), CAST(@profesional as varchar) + '99') AND especialidad=@especialidad)
				where turn_numero=@turno

		FETCH NEXT FROM TURNOS INTO @turno, @afiliado, @profesional, @especialidad
	END
CLOSE TURNOS
DEALLOCATE TURNOS
PRINT '9. Carga Profesionales y Afiliados en Turnos OK'
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
PRINT '10. Consultas realizadas por Afiliados OK'
GO

-- << Rango de atención de la Clínica >>
declare @clinica as numeric(18,0)
insert into LOS_TRIGGERS.Clinica (clin_nombre) values('Clinica Medica FRBA')
set @clinica = (select SCOPE_IDENTITY())
insert into LOS_TRIGGERS.Dia_Atencion(dia_nombre_dia, dia_hora_fin, dia_hora_inicio, dia_clinica) values('Lunes', '07:00', '20:00', @clinica)
insert into LOS_TRIGGERS.Dia_Atencion(dia_nombre_dia, dia_hora_fin, dia_hora_inicio, dia_clinica) values('Martes', '07:00', '20:00', @clinica)
insert into LOS_TRIGGERS.Dia_Atencion(dia_nombre_dia, dia_hora_fin, dia_hora_inicio, dia_clinica) values('Miércoles', '07:00', '20:00', @clinica)
insert into LOS_TRIGGERS.Dia_Atencion(dia_nombre_dia, dia_hora_fin, dia_hora_inicio, dia_clinica) values('Jueves', '07:00', '20:00', @clinica)
insert into LOS_TRIGGERS.Dia_Atencion(dia_nombre_dia, dia_hora_fin, dia_hora_inicio, dia_clinica) values('Viernes', '07:00', '20:00', @clinica)
insert into LOS_TRIGGERS.Dia_Atencion(dia_nombre_dia, dia_hora_fin, dia_hora_inicio, dia_clinica) values('Sábado', '10:00', '15:00', @clinica)
PRINT '11. Rango de Atención de la Clínica OK'
GO

-- << Tipos de Cancelaciones de Turno >>
insert into LOS_TRIGGERS.Tipo_Cancelacion (tipo_descripcion)
	values ('Ya no necesito el servicio'),
			('He encontrado otro servicio alternativo que cubre mejor mis necesidades'),
			('La atención al cliente no ha cubierto mis expectativas'),
			('No puedo asistir debido a un problema personal'),
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
PRINT '13.  Funcionalidades del Sistema OK'
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
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'Registro de Diagnóstico Médico'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'Pedido de Turno'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'Cancelación de Turno'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'Compra de Bono'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Administrador', 'Listado Estadístico'

EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Profesional', 'Registro de Agenda Profesional'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Profesional', 'Registro de Consulta Médica'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Profesional', 'Registro de Diagnóstico Médico'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Profesional', 'Cancelación de Turno'

EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Afiliado', 'Compra de Bono'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Afiliado', 'Pedido de Turno'
EXEC LOS_TRIGGERS.AgregarFuncionalidadAUnRol 'Afiliado', 'Cancelación de Turno'

SET NOCOUNT OFF;