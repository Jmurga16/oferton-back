                   
CREATE PROCEDURE [dbo].[USP_MNT_Orden]
	
	@nIdProducto INT = 0,
	@sNombre	 VARCHAR(MAX)='',
	@sCorreo	 VARCHAR(MAX)='',
	@sDireccion	 VARCHAR(MAX)=''
                          
AS

DECLARE @nStockActual INT
DECLARE @nIdCliente INT
DECLARE @bEstado BIT

BEGIN
            
	BEGIN TRAN --Inicio de Transaccion
		BEGIN TRY --Inicio del manejador de erorres
			BEGIN
				--VERIFICAR STOCK
				SET @nStockActual = (SELECT TOP 1 nStock FROM Producto)
				
				IF(@nStockActual >0)
					SET @bEstado = 1 
				ELSE
					SET @bEstado = 0
					
				--INSERTAR CLIENTE
				INSERT INTO [Customer]
						(sNombre,  sCorreo,  sDireccion)
				VALUES	(@sNombre, @sCorreo, @sDireccion)

				--NUEVO CLIENTE
				SET @nIdCliente = @@IDENTITY

				--GUARDAR ORDEN
				INSERT INTO [Order]
						(nIdProducto,  nIdCliente, bEstado)
				VALUES	(@nIdProducto, @nIdCliente, @bEstado)
				
				--ACTUALIZAR STOCK
				SET @nStockActual = (@nStockActual - 1)

				UPDATE [Product]
				SET 
					nStock = @nStockActual
				WHERE
					nIdProducto = @nIdProducto
					
			END
	COMMIT TRAN
		SELECT @nStockActual
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		PRINT ERROR_MESSAGE();
		SELECT -1 --Devuelvo -1 para mostrar el mensaje de error
	END CATCH
		
END;
