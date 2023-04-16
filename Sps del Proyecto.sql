USE [PV_ProyectoFinal]
GO
/****** Object:  StoredProcedure [dbo].[spConsultar_Bitacora]    Script Date: 7/4/2023 13:21:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spConsultar_Bitacora]
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

GO
/****** Object:  StoredProcedure [dbo].[spConsultar_Mis_Reservaciones]    Script Date: 7/4/2023 13:21:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  StoredProcedure [dbo].[spConsultar_Reservaciones_ID]    Script Date: 7/4/2023 13:21:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spConsultar_Reservaciones_ID]
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

GO
/****** Object:  StoredProcedure [dbo].[spValidar_Reservaciones_Persona]    Script Date: 7/4/2023 13:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[spLogin]    Script Date: 7/4/2023 13:23:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

GO
/****** Object:  StoredProcedure [dbo].[spGestionar_Reservaciones_ID]    Script Date: 7/4/2023 13:23:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  StoredProcedure [dbo].[spGestionar_Reservaciones_ID]    Script Date: 7/4/2023 13:46:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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


GO
/****** Object:  StoredProcedure [dbo].[spConsultar_Usuarios]    Script Date: 9/4/2023 12:54:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

GO
/****** Object:  StoredProcedure [dbo].[spConsultar_Hoteles]    Script Date: 13/4/2023 10:47:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spConsultar_Habitaciones]
AS
BEGIN
	SELECT
		h.idHabitacion,
		h.idHotel,
		h.numeroHabitacion,
		h.capacidadMaxima,
		h.descripcion,
		h.estado
	FROM dbo.Habitacion h
END

Create PROCEDURE [dbo].[spCrear_Reservacion]
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
	--Paso 5: Update estado habitacion
	UPDATE Habitacion SET Estado = 'I' WHERE IdHabitacion = @idHabitacion
END

/****** Object:  StoredProcedure [dbo].[spConsultar_Hoteles_Id]    Script Date: 13/4/2023 18:02:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

GO
/****** Object:  StoredProcedure [dbo].[spCrear_Bitacora]    Script Date: 15/4/2023 17:44:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[spObtener_Id_Reservacion_Creada]    Script Date: 13/4/2023 18:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spObtener_Id_Reservacion_Creada]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT MAX(idReservacion) AS idReservacion
    FROM Reservacion;
END

GO
/****** Object:  StoredProcedure [dbo].[spConsultar_Hoteles]    Script Date: 13/4/2023 18:37:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

GO
/****** Object:  StoredProcedure [dbo].[spEditar_Reservacion]    Script Date: 15/4/2023 13:13:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[spCrear_Reservacion]    Script Date: 15/4/2023 12:51:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
