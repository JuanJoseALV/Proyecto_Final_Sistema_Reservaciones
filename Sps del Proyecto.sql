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

USE [PV_ProyectoFinal]
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