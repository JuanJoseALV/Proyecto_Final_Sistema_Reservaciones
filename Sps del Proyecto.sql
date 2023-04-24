USE [PV_ProyectoFinal]
/*************************************************************************** SP Consultar bitacora *****************************************************************/

/*El Stored Procedure recibe un parámetro y retorna la bitácora de acciones para una reservación específica, 
  ordenada por el identificador de la bitácora en orden descendente. Utiliza INNER JOIN para unir la tabla Bitacora con Persona
  usando idPersona como clave de unión. La consulta selecciona 4 columnas: idBitacora, fechaDeLaAccion, accionRealizada y nombreCompleto (de la tabla Persona).*/

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

/*Este es un Stored Procedure en SQL Server que no recibe parámetros y retorna una consulta que muestra información
de todas las habitaciones de los hoteles en la base de datos. La consulta SELECT utiliza INNER JOIN para unir la tabla
Habitacion con la tabla Hotel, utilizando el idHotel de ambas tablas como clave de unión. 
Se seleccionan ocho columnas: idHabitacion, idHotel, numeroHabitacion, capacidadMaxima, descripcion, estado, nombre y direccion,
donde nombre y direccion son columnas de la tabla Hotel. La consulta se ordena por nombre de hotel en orden ascendente.*/

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

/*Este es un Stored Procedure en SQL Server que muestra información de todos los hoteles registrados en la
base de datos, ordenados alfabéticamente por el nombre del hotel.*/

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

/*Este es un Stored Procedure en SQL Server que recibe un parámetro @id_Hotel de tipo INT y
retorna una consulta que muestra información detallada sobre un hotel específico que coincide con el id proporcionado.*/

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

/*Este es un Stored Procedure en SQL Server que recibe un parámetro @id_Persona de tipo INT y retorna una
consulta que muestra las reservaciones asociadas a una persona específica, incluyendo el identificador de la reservación,
fechas de entrada y salida, costo total, estado y nombre del hotel donde se realizó la reserva. La consulta utiliza INNER
JOIN para unir las tablas Persona, Reservacion, Habitacion y Hotel, utilizando los identificadores de persona, habitación y
hotel como claves de unión. La consulta se ordena por el identificador de la reservación en orden descendente.*/

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

/*Este Stored Procedure en SQL Server recibe un parámetro @id_Reservacion de tipo INT y retorna una consulta que muestra los detalles
de una reservación específica, incluyendo el identificador de la reservación, el nombre del hotel, el número de habitación, el nombre completo
de la persona que hizo la reservación, las fechas de entrada y salida, el número de niños y adultos, el costo total y el estado de la reservación.*/

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

/*Este Stored Procedure en SQL Server recibe un parámetro de entrada @id_Habitacion de tipo INT y retorna una consulta que muestra
la información de una habitación específica, utilizando INNER JOIN para unir la tabla Habitacion con la tabla Hotel mediante la clave
de unión idHotel. Se seleccionan ocho columnas: idHabitacion, idHotel, numeroHabitacion, capacidadMaxima, descripcion, estado, nombre y direccion,
donde nombre y direccion son dos columnas de la tabla Hotel.*/

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

/*Este es un procedimiento almacenado de SQL Server que selecciona y devuelve información sobre todos los usuarios
en la tabla Persona. La instrucción SELECT recupera columnas para el nombre, ID, estado, estado del empleado,
correo electrónico y contraseña de cada usuario. */

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

/*Este procedimiento almacenado se utiliza para crear un nuevo registro en la tabla "Bitacora". Recibe cuatro parámetros:
@id_Reservacion (int), @id_Persona (int), @Accion (varchar(25)) y @fecha (datetime). Estos parámetros representan el ID de la reserva,
el ID de la persona que realizó la acción, la descripción de la acción y la fecha y hora en que se realizó la acción, respectivamente.*/

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

/*Este procedimiento almacenado se utiliza para crear un nuevo registro en la tabla "Habitación" de una habitación de hotel con los parámetros dados.
Toma como parámetros de entrada el ID del hotel, número de habitación, capacidad máxima, descripción y estado de la habitación, e inserta un nuevo registro
con estos valores en la tabla "Habitación".*/

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

/*Este procedimiento almacenado crea una reserva para una habitación de hotel dada la cantidad de personas, la identificación del hotel,
la identificación de la persona, las fechas de entrada y salida, la cantidad de adultos, la cantidad de niños, el costo por adulto, el costo por niño,
el costo total, fecha de creación y estado de la reserva.*/

/*Toma parámetros de entrada para el número de personas, identificación del hotel, identificación de la persona, fechas de entrada y salida, número de adultos,
número de niños, costo por adulto, costo por niño, costo total, fecha de creación y estado de la reserva.

Selecciona la primera habitación de hotel disponible que tenga capacidad suficiente para el número de personas y esté ubicada en el hotel especificado.
Si hay varias habitaciones disponibles, selecciona la que tiene menos reservas.

Cuenta el número de reservas para la habitación de hotel seleccionada.

Crea una reserva con los parámetros de entrada y la habitación de hotel seleccionada.*/

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

/*Este procedimiento almacenado actualiza los valores de una habitación existente en la tabla "Habitacion". Toma cuatro parámetros de entrada:
el "id_Habitacion" de la habitación a actualizar, el nuevo valor "Numero_Habitacion", el nuevo valor "Capacidad_Maxima" y el nuevo valor "Descripcion".*/

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

/*Este procedimiento almacenado actualiza los detalles de la reserva de una reserva dada en la base de datos. Toma como parámetros de entrada el ID de la reserva,
las nuevas fechas, el número de adultos y niños, el total de días de reserva, el costo total y la fecha de modificación. Actualiza los campos correspondientes en la
Reservaciontabla para el ID de reserva dado.*/

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

/*El procedimiento simplemente realiza una operación de actualización en la Reservaciontabla, configurando las columnas estadoy fechaModificacionen
los valores proporcionados para la fila con el id_Reservacion.*/

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

/*Este procedimiento almacenado permite el filtrado de reservas según el nombre de la persona que realizó la reserva y las fechas de la reserva.
Aquí hay un desglose de los parámetros y las declaraciones SQL utilizadas:*/

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
	WHERE pe.nombreCompleto = @Nombre_Persona or r.fechaEntrada >= @Fecha_Entrada And r.fechaSalida <= @Fecha_Salida
	order by r.idReservacion desc;
END

/*************************************************************************** SP Gestionar Reservaciones id *****************************************************************/

/*Este procedimiento almacenado recuperara una lista de reservas para todas las personas excepto la que tiene el especificado id_Persona.*/

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

/*Este procedimiento almacenado actualiza el estado de una habitación a "inactivo" configurando la columna "estado" en el valor especificado*/

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

/*Este procedimiento almacenado es un procedimiento de inicio de sesión que recupera la información del usuario de la tabla "Persona"
en función de los parámetros de correo electrónico y contraseña (clave) proporcionados.*/

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

/*Este procedimiento almacenado devuelve el id de la reservacion mas reciente, que es esencialmente el ID de la última reserva creada.
Este procedimiento almacenado devuelve el máximo idReservacionde la Reservaciontabla, que es esencialmente el ID de la última reserva creada.*/

Create PROCEDURE [dbo].[spObtener_Id_Reservacion_Creada]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT MAX(idReservacion) AS idReservacion
    FROM Reservacion;
END

/*************************************************************************** SP Validar Habitaciones *****************************************************************/

/*Este procedimiento almacenado está diseñado para validar la disponibilidad de habitaciones en un hotel para un número determinado de personas. */

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

/*Este procedimiento almacenado parece estar validando un específica habitacion ver si actualmente está reservado o no.*/

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

/*Este procedimiento almacenado valida que las reservaciones sean de la persona que esta generando la consulta */

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























