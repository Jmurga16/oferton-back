                   
CREATE PROCEDURE [dbo].[USP_GET_Producto]          
                                
AS

BEGIN
              
	--CONSULTAR TODO	
	BEGIN

		SELECT
			nIdProducto,
			sNombreProducto,
			sDescripcion,
			nCalificacion,
			nPrecio,
			nStock,
			sRutaImagen
		FROM Product
	                                                                             
	END;                                     

END;
