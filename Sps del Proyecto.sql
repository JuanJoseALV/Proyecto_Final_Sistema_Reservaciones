USE [PV_ProyectoFinal]
/*************************************************************************** SP Consultar bitacora *****************************************************************/

Create  PROCEDURE [dbo].[spConsultar_Bitacora]
	@id_Reservacion INT
AS	
BEGIN
	SELECT
		b.idBitacora,
		b.fechaDeLaAccion,
		b.accionRealizada,
		p.nombreCompleto
	FROM Bitacora b INNER JOIN Persona p on b.idPersona = p.idPersona	
	WHERE b.idReservacion = @id_Reservacion
	order by b.idBitacora desc;
END

/*************************************************************************** SP Consultar  habitaciones *****************************************************************/

CREATE PROCEDURE [dbo].[spConsultar_Habitaciones]
AS
BEGIN
	SELECT
		h.idHabitacion,
		h.idHotel,
		h.numeroHabitacion,
		h.capacidadMaxima,
		h.descripcion,
		h.estado,
		ho.nombre,
		ho.direccion
	FROM dbo.Habitacion h inner join Hotel ho on h.idHotel=ho.idHotel
	order by ho.nombre asc
END

/*************************************************************************** SP Consultar Hoteles *****************************************************************/


Create PROCEDURE [dbo].[spConsultar_Hoteles]
AS
BEGIN
	SELECT
		h.idHotel,
		h.nombre,
		h.direccion,
		h.costoPorCadaAdulto,
		h.costoPorCadaNinho
	FROM dbo.Hotel h
	order by  h.nombre asc;
END

/*************************************************************************** SP Consultar Hoteles Id *****************************************************************/

Create PROCEDURE [dbo].[spConsultar_Hoteles_Id]
@id_Hotel int
AS
BEGIN
	SELECT
		h.idHotel,
		h.nombre,
		h.direccion,
		h.costoPorCadaAdulto,
		h.costoPorCadaNinho
	FROM dbo.Hotel h
where h.idHotel=@id_Hotel;
END

/*************************************************************************** SP Consultar Mis Reservaciones *****************************************************************/

Create PROCEDURE [dbo].[spConsultar_Mis_Reservaciones]
	@id_Persona INT
AS	
BEGIN
	SELECT
		r.idReservacion,
		r.fechaEntrada,
		r.fechaSalida,
		r.costoTotal,
		r.estado,
		ho.nombre
	FROM Persona pe INNER JOIN Reservacion r on pe.idPersona = r.idPersona
						INNER JOIN Habitacion h on r.idHabitacion = h.idHabitacion
						INNER JOIN Hotel ho on h.idHotel = ho.idHotel 	
	WHERE pe.idPersona = @id_Persona
	order by r.idReservacion desc;
	
END


/*************************************************************************** SP Consultar Reservaciones ID *****************************************************************/

CREATE PROCEDURE [dbo].[spConsultar_Reservaciones_ID]
    @id_Reservacion INT
AS    
BEGIN
    SELECT
        r.idReservacion,
        ho.nombre,
        h.numeroHabitacion,
        pe.nombreCompleto,
        r.fechaEntrada,
        r.fechaSalida,
        r.numeroNinhos,
        r.numeroAdultos,
        r.costoTotal,
        r.estado

    FROM Persona pe INNER JOIN Reservacion r on pe.idPersona = r.idPersona
                        INNER JOIN Habitacion h on r.idHabitacion = h.idHabitacion
                        INNER JOIN Hotel ho on h.idHotel = ho.idHotel     
    WHERE r.idReservacion = @id_Reservacion
END

/*************************************************************************** SP Consultar Habitaciones Id *****************************************************************/

CREATE PROCEDURE [dbo].[spConsultar_Habitaciones_Id]
@id_Habitacion int
AS
BEGIN
	SELECT
		h.idHabitacion,
		h.idHotel,
		h.numeroHabitacion,
		h.capacidadMaxima,
		h.descripcion,
		h.estado,
		ho.nombre,
		ho.direccion

	FROM dbo.Habitacion h inner join Hotel ho on h.idHotel=ho.idHotel

	where h.idHabitacion = @id_Habitacion;
END
/*************************************************************************** SP Consultar Usuarios *****************************************************************/

CREATE PROCEDURE [dbo].[spConsultar_Usuarios]
AS
BEGIN
	SELECT
	p.nombreCompleto,
	p.idPersona,
	p.estado,
	p.esEmpleado,
	p.email,
	p.clave
	FROM dbo.Persona p
END

/*************************************************************************** SP Crear Bitacora *****************************************************************/

Create PROCEDURE [dbo].[spCrear_Bitacora]
	 @id_Reservacion int,
	 @id_Persona int,
	 @Accion varchar(25),
	 @fecha datetime 
As
BEGIN
	INSERT INTO dbo.Bitacora(idReservacion,idPersona,accionRealizada,fechaDeLaAccion)
	VALUES (@id_Reservacion,@id_Persona,@Accion,@fecha)
	
END

/*************************************************************************** SP Crear habitacion *****************************************************************/

Create PROCEDURE [dbo].[spCrear_Habitacion]
	 @id_Hotel int,
	 @numero_Hotel varchar(10),
	 @Capacidad_Max int,
	 @Descripcion varchar(500),
	 @Estado varchar(1)
As
BEGIN
	INSERT INTO dbo.Habitacion(idHotel, numeroHabitacion, capacidadMaxima, descripcion, estado)
     VALUES(@id_Hotel, @numero_Hotel, @Capacidad_Max, @Descripcion, @Estado)
	
END

/*************************************************************************** SP Crear Reservacion *****************************************************************/

CREATE PROCEDURE [dbo].[spCrear_Reservacion]
	  @numPersonas INT,
	  @idHotel INT,
	  @idPersona int,
	  @fechaEntrada datetime,
	  @fechaSalida datetime,
	  @numeroAdultos int,
	  @numeroNinhos int,
	  @totalDiasReservacion int,
	  @costoPorCadaAdulto numeric(10,2),
	  @costoPorCadaNinho numeric(10,2),
	  @costoTotal numeric(14,2),
	  @fechaCreacion datetime,
	  @estado varchar(1)
As
BEGIN
	 SET NOCOUNT ON;
	 DECLARE @capacidad INT
	 SET @capacidad = @numPersonas
 -- Paso 2: Consultar las habitaciones disponibles que tienen capacidad suficiente
	SELECT TOP 1 H.IdHabitacion, COUNT(R.IdReservacion) AS NumReservaciones FROM Habitacion H
    LEFT JOIN Reservacion R ON H.IdHabitacion = R.IdHabitacion
    WHERE H.Estado = 'A' AND H.CapacidadMaxima >= @capacidad AND H.IdHotel = @idHotel
    GROUP BY H.IdHabitacion
    ORDER BY NumReservaciones ASC

	 -- Paso 3: Contar la cantidad de reservaciones para la habitación seleccionada
    DECLARE @idHabitacion int
    SET @idHabitacion  = (SELECT TOP 1 IdHabitacion FROM Habitacion WHERE Estado = 'A' AND CapacidadMaxima >= @capacidad AND IdHotel = @idHotel)

	
	--Paso 4: hacer el insert
	INSERT INTO dbo.Reservacion (idPersona, idHabitacion, fechaEntrada, fechaSalida, numeroAdultos, numeroNinhos, totalDiasReservacion, costoPorCadaAdulto, costoPorCadaNinho, costoTotal, fechaCreacion, estado)
	VALUES (@idPersona, @idHabitacion, @fechaEntrada, @fechaSalida, @numeroAdultos, @numeroNinhos, @totalDiasReservacion, @costoPorCadaAdulto, @costoPorCadaNinho, @costoTotal, @fechaCreacion, @estado)
END

/*************************************************************************** SP Editar Habitacion *****************************************************************/

Create PROCEDURE [dbo].[spEditar_Habitacion]
	  @id_Habitacion int,
	  @Numero_Habitacion varchar(10),
	  @Capacidad_Maxima int,
	  @Descripcion varchar (500)
As
BEGIN
UPDATE Habitacion
   SET
      numeroHabitacion = @Numero_Habitacion,
      capacidadMaxima = @Capacidad_Maxima,
      descripcion = @Descripcion 
 WHERE idHabitacion=@id_Habitacion;
 END

/*************************************************************************** SP Editar Reservacion *****************************************************************/

Create PROCEDURE [dbo].[spEditar_Reservacion]
	  @id_Reservacion int,
	  @fechaEntrada datetime,
	  @fechaSalida datetime,
	  @numeroAdultos int,
	  @numeroNinhos int,
	  @totalDiasReservacion int,
	  @costoTotal numeric(14,2),
	  @fechaModificacion datetime
As
BEGIN
	 UPDATE Reservacion
   SET
      fechaEntrada = @fechaEntrada,
      fechaSalida = @fechaSalida,
      numeroAdultos = @numeroAdultos,
      numeroNinhos = @numeroNinhos,
      totalDiasReservacion = @totalDiasReservacion,
      costoTotal = @costoTotal,
      fechaModificacion = @fechaModificacion
 WHERE idReservacion = @id_Reservacion
END

/*************************************************************************** SP Eliminar Reservacion *****************************************************************/

Create PROCEDURE [dbo].[spEliminar_Reservacion]
	  @id_Reservacion int,
	  @estado varchar(1),
	  @fechaModificacion datetime
	 
As
BEGIN
	 UPDATE Reservacion
   SET
      estado = @estado,
	  fechaModificacion = @fechaModificacion
 WHERE idReservacion = @id_Reservacion
END

/*************************************************************************** SP Filtro Gestionar Reservaciones *****************************************************************/

Create PROCEDURE [dbo].[spFiltro_Gestionar_Reservaciones]
	@Nombre_Persona varchar(50),
	@Fecha_Entrada datetime,
	@Fecha_Salida datetime
AS	
BEGIN
	SELECT
		r.idReservacion,
		ho.nombre,
		h.numeroHabitacion,
		pe.nombreCompleto,
		r.fechaEntrada,
		r.fechaSalida,
		r.numeroNinhos,
		r.numeroAdultos,
		r.costoTotal,
		r.estado
	FROM Persona pe inner JOIN Reservacion r on pe.idPersona = r.idPersona
						inner JOIN Habitacion h on r.idHabitacion = h.idHabitacion
						inner JOIN Hotel ho on h.idHotel = ho.idHotel 	
	WHERE pe.nombreCompleto = @Nombre_Persona or r.fechaEntrada BETWEEN @Fecha_Entrada AND @Fecha_Salida And r.fechaSalida BETWEEN @Fecha_Entrada AND @Fecha_Salida
	order by r.idReservacion desc;
END

/*************************************************************************** SP Gestionar Reservaciones id *****************************************************************/

Create PROCEDURE [dbo].[spGestionar_Reservaciones_ID]
	@id_Persona INT
AS	
BEGIN
	SELECT
		r.idReservacion,
		ho.nombre,
		h.numeroHabitacion,
		pe.nombreCompleto,
		r.fechaEntrada,
		r.fechaSalida,
		r.numeroNinhos,
		r.numeroAdultos,
		r.costoTotal,
		r.estado
	FROM Persona pe inner JOIN Reservacion r on pe.idPersona = r.idPersona
						inner JOIN Habitacion h on r.idHabitacion = h.idHabitacion
						inner JOIN Hotel ho on h.idHotel = ho.idHotel 	
	WHERE pe.idPersona != @id_Persona 
	order by r.idReservacion desc;
END

/*************************************************************************** SP inactivar Habitacion *****************************************************************/

CREATE PROCEDURE [dbo].[spInactivar_Habitacion]
	  @id_Habitacion int,
	  @Estado varchar (1)
	
As
BEGIN
UPDATE Habitacion
   SET 
      estado = @Estado
 WHERE idHabitacion=@id_Habitacion
END

/*************************************************************************** SP login *****************************************************************/

Create PROCEDURE [dbo].[spLogin]
	@Email varchar(50),
	@Clave varchar(50)

AS
BEGIN
	SELECT
		p.idPersona,
		p.nombreCompleto,
		p.estado,
		p.esEmpleado,
		p.email,
		p.clave
	FROM dbo.Persona p
	WHERE p.clave= @Clave and p.email=@Email and p.estado='A'
END

/*************************************************************************** SP Obtener Id Reservacion Creada *****************************************************************/

Create PROCEDURE [dbo].[spObtener_Id_Reservacion_Creada]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT MAX(idReservacion) AS idReservacion
    FROM Reservacion;
END

/*************************************************************************** SP Validar Habitaciones *****************************************************************/

Create PROCEDURE [dbo].[spValidar_Habitaciones]
	@id_Hotel INT,
	@Cantidad_Personas int
AS	
BEGIN
	SELECT
		h.idHotel,
		ha.idHabitacion
	FROM Hotel h inner join Habitacion ha on ha.idHotel=h.idHotel
	WHERE h.idHotel = @id_Hotel and ha.capacidadMaxima >= @Cantidad_Personas;

END

/*************************************************************************** SP Validar Habitaciones_Reservacion *****************************************************************/

CREATE PROCEDURE [dbo].[spValidar_Habitaciones_Reservaciones]
@id_Habitacion int
AS
BEGIN
	SELECT
		h.idHabitacion,
		h.idHotel,
		h.numeroHabitacion,
		h.capacidadMaxima,
		h.descripcion,
		h.estado,
		ho.nombre,
		ho.direccion,
		r.fechaEntrada,
		r.fechaSalida
	FROM dbo.Habitacion h inner join Hotel ho on h.idHotel=ho.idHotel
	inner join Reservacion r on h.idHabitacion=r.idHabitacion
	where h.idHabitacion = @id_Habitacion;
END

/*************************************************************************** SP Validar Reservaciones Persona*****************************************************************/

Create PROCEDURE [dbo].[spValidar_Reservaciones_Persona]
	@id_Reservacion INT,
	@Nombre_Usuario varchar(50)
AS	
BEGIN
	SELECT
		r.idReservacion,
		ho.nombre,
		h.numeroHabitacion,
		pe.nombreCompleto,
		r.fechaEntrada,
		r.fechaSalida,
		r.numeroNinhos,
		r.numeroAdultos,
		r.costoTotal
		
	FROM Persona pe INNER JOIN Reservacion r on pe.idPersona = r.idPersona
						INNER JOIN Habitacion h on r.idHabitacion = h.idHabitacion
						INNER JOIN Hotel ho on h.idHotel = ho.idHotel 	
	WHERE r.idReservacion = @id_Reservacion and pe.nombreCompleto=@Nombre_Usuario
END























