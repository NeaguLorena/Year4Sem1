-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters
-- command (Ctrl-Shift-M) to fill in the parameter
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
-- todo: implement;
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

create FUNCTION Standings
(
	-- Add the parameters for the function here
	@year int,
	@round int
)
RETURNS TABLE
AS
RETURN
(
	-- Add the SELECT statement with parameter references here
	SELECT TOP 10 formula1.drivers.surname, formula1.drivers.forename, formula1.driver_standings.points, formula1.driver_standings.wins FROM formula1.races
	INNER JOIN formula1.driver_standings ON driver_standings.raceId = races.raceId
	INNER JOIN formula1.drivers ON driver_standings.driverId = drivers.driverId
	WHERE races.year = @year AND races.round = @round
	ORDER BY  driver_standings.points DESC
)
GO

SELECT * from Standings ('2015', 3)