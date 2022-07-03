USE [DB_SISGAPO]
GO
/****** Object:  StoredProcedure [dbo].[USP_MNT_Zonas]    Script Date: 22/08/2021 19:55:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
                                   
CREATE PROCEDURE [dbo].[USP_MNT_Zonas]          
            
@sOpcion VARCHAR(2)= '',   
@nIdZona INT = 0,
@sNombre VARCHAR(100)='',
@sRutaImagen VARCHAR(MAX)
                                 
AS

BEGIN
              
  IF @sOpcion = '01'   --CONSULTAR TODO
  BEGIN

       SELECT *	FROM TBL_Zona
	                                                                             
  END;                                     


  IF @sOpcion = '02'   --CONSULTAR UNICO
  BEGIN	
	    SELECT
        *
      FROM TBL_Zona
      WHERE
        nIdZona=@nIdZona    
  END;


  IF @sOpcion = '03'  --INSERTAR                                                      
  BEGIN	

	IF((SELECT COUNT(*) FROM [TBL_ZONA] WHERE sNombre=LOWER(@sNombre))=0)
	BEGIN

	  INSERT INTO TBL_Zona (sNombre,sRutaImagen)
	   VALUES (@sNombre,@sRutaImagen);     

	END

  END

END;
