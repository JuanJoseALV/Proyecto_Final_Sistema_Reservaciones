USE [PV_ProyectoFinal]
GO
/****** Object:  StoredProcedure [dbo].[spConsultar_Reservaciones_ID]    Script Date: 6/4/2023 16:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spConsultar_Reservaciones_ID_Persona]
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

Go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spConsultar_Bitacora]
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
/****** Object:  StoredProcedure [dbo].[spConsultar_Reservaciones]    Script Date: 6/4/2023 18:01:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spConsultar_Reservaciones]
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
/****** Object:  StoredProcedure [dbo].[spConsultar_Reservaciones_ID]    Script Date: 6/4/2023 18:03:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Alter PROCEDURE [dbo].[spConsultar_Reservaciones_ID]
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
/****** Object:  StoredProcedure [dbo].[spConsultar_Usuarios]    Script Date: 6/4/2023 18:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spConsultar_Usuarios]
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
/****** Object:  StoredProcedure [dbo].[spGestionar_Reservaciones]    Script Date: 6/4/2023 18:04:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spGestionar_Reservaciones]
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

