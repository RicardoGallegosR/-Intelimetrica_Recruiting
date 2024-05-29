--DROP DATABASE Intelimetrica
CREATE DATABASE Intelimetrica
COLLATE SQL_Latin1_General_CP1_CI_AI;
GO

USE Intelimetrica;
GO
CREATE SCHEMA Activos;
GO
CREATE SCHEMA Restaurant;
GO
CREATE SCHEMA Administrador;
GO


-- drop table Activos.Activo
CREATE TABLE Activos.Activo (
    ActivoId TINYINT IDENTITY(0,1) NOT NULL,
	 tipo_Activo NVARCHAR(30) NOT NULL, 
    PRIMARY KEY (ActivoId),
);

-- Tomamos precauciones al llenar la BDD
DECLARE
    @ErrorMessage NVARCHAR(4000),
    @ErrorSeverity INT,
    @ErrorState INT

BEGIN TRY
    BEGIN TRANSACTION
        INSERT INTO Intelimetrica.Activos.Activo (tipo_Activo)
        VALUES	('INACTIVO'),
				('ACTIVO')
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        SET @ErrorMessage = 'Error en el procedimiento almacenado Insertar Certificado: ' + @ErrorMessage +
                    '. Error en la l�nea: ' + CAST(ERROR_LINE() AS NVARCHAR(10))
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    ROLLBACK TRANSACTION;
END CATCH

select * from Intelimetrica.Activos.Activo;


GO

--Drop table Restaurant.Restaurants
CREATE TABLE Restaurant.Restaurants (
   RestaurantsId INT IDENTITY(0,1) NOT NULL,
   Id UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
   Rating TINYINT CHECK (Rating BETWEEN 0 AND 4),
   [Name] VARCHAR(40), -- Name of the restaurant
   WebSite VARCHAR(40), -- Url of the restaurant
   email VARCHAR(45),
   phone VARCHAR(15), -- por los numeros internacionales,10 para los nacionales
   street VARCHAR(35),
   city VARCHAR(50),
   [State] VARCHAR(30),
   lat FLOAT, 
   lng FLOAT,
   ActivoId TINYINT DEFAULT 1,
   PRIMARY KEY (RestaurantsId) 
);

ALTER TABLE Restaurant.Restaurants
ADD CONSTRAINT FK_Activos_Restaurants
FOREIGN KEY (ActivoId) REFERENCES Intelimetrica.Activos.Activo(ActivoId);




DECLARE
    @ErrorMessage NVARCHAR(4000),
    @ErrorSeverity INT,
    @ErrorState INT

BEGIN TRY
    BEGIN TRANSACTION
       INSERT INTO Restaurant.Restaurants (Id, Rating, [Name], WebSite, Email, Phone, Street, City, [State], Lat, Lng)
       VALUES 
		('851f799f-0852-439e-b9b2-df92c43e7672',1,'Barajas, Bahena and Kano','https://federico.com','Anita_Mata71@hotmail.com','5534814204','82247 Mariano Entrada','M�rida Alfredotown','Durango',19.4400570537131,-99.1270470974249),
		('4e17896d-a26f-44ae-a8a4-5fbd5cde79b0',0,'Hern�ndez - Lira','http://graciela.com.mx','Brandon_Vigil@hotmail.com','5570746998','93725 Erick Arroyo','Mateofurt','Hidalgo',19.437904276995,-99.1286576775023),
		('c0ffd058-e773-47f1-974b-42d41cb555bf',3,'Rend�n - Elizondo','https://cristina.mx','Hugo.Casanova49@gmail.com','5866337812','5518 Monserrat Explanada','Chignahuapan Mar�a','Sinaloa',19.4360705910348,-99.1297865731994),
		('c29082c4-4352-4517-9b4b-c45f86fc1830',2,'N�jera - Ch�vez','https://pedro.gob.mx','Carlota31@hotmail.com','5532129406','79224 Mariano Traves�a','Nezahualc�yotl Timoteo','Coahuila',19.4424869116657,-99.1238332599196),
		('2b8f5a44-1e8b-44ec-9b25-0edc5b64b7e6',3,'Hurtado, Rol�n and Segovia','https://elias.org','RosaMara_Figueroa@corpfolder.com','5559867074','039 Susana Pol�gono','Marco Antonioland','Colima',19.433497663015,-99.1285135065721),
		('ddb77425-2c3f-435c-8391-021b40010b0d',0,'Serrato Hermanos','https://octavio.org','Yamileth_Lugo28@corpfolder.com','5571744718','14476 Delgadillo Partida','Nev�rezfort','Michoacan',19.4347042254875,-99.1263817815393),
		('7b845a5f-94d4-4d52-bbb7-838839a180d6',1,'Saiz, Aponte and Mu�oz','https://homero.com','Carolina_Merino@nearbpo.com','5584212054','563 Verduzco V�a P�blica','Nuevo Laredo Alejandrahaven','San Luis Potos�',19.4414878243213,-99.1274899318585),
		('030eaf75-da6e-4748-9727-f2704f831498',2,'Ni�o - Negrete','https://elizabeth.gob.mx','Luz_Sevilla@gmail.com','5178668409','3041 Gael Torrente','Quer�taro Saratown','Oaxaca',19.4416814748901,-99.1265732438097),
		('1ce4a7f8-ff21-4450-9107-f4f952f39f99',4,'Kortajarena - Rangel','http://debora.gob.mx','Brandon_Quiros@gmail.com','5560092151','59897 Esquivel Aldea','Monterrey Dulce Mar�a','Quer�taro',19.440701969313,-99.1260149339613),
		('9f98fad3-ecd6-421b-ba8c-2bd63340473d',2,'Mac�as S.L.','http://miguel.com.mx','Jazmin_Santiago7@yahoo.com','5508272671','1736 Adela Urbanizaci�n','Puerto Vallarta Dorotea','Baja California Sur',19.4369257779145,-99.1315607513514),
		('38c965f9-74b0-4d8e-9cc2-2e457a1ebb83',3,'Arreola Hermanos','https://alejandra.com.mx','Ximena_Domnquez62@yahoo.com','5531757355','9061 Fernando Puente','Campeche Mercedes','Guanajuato',19.4349888225906,-99.1263073477967),
		('4501fb34-eefe-4f63-90c9-a9a1272df71d',0,'Gallardo - Angulo','https://jose-antonio.mx','Brandon34@gmail.com','5191333084','7229 Villarreal Gran Subida','Campeche Daniela','Quintana Roo',19.4341320322948,-99.1326235608364),
		('d04fd5aa-4a56-43a6-91c9-35edaaadadc9',0,'Calvillo S.L.','https://martin.info','JuanPablo.Cervntez@nearbpo.com','5501812092','38836 Emilio Partida','Rub�nchester','Tabasco',19.4423931664932,-99.126576982844),
		('a850ff07-516e-44e4-acd7-26fa0c12f4fc',1,'Palomo - Cardona','http://marco-antonio.org','Lizbeth.Laboy@hotmail.com','5508505560','5588 Leticia Torrente','Tetela de Ocampo Silviafurt','Colima',19.4348698630608,-99.1280895220492),
		('7173d827-3308-46d8-9b9e-86306ec64f78',3,'Carre�n e Hijos','http://dolores.org','Benjamn.Arenas27@yahoo.com','5572204703','7124 Granado Parcela','Celaya Carlos','Puebla',19.4405543555394,-99.1268034744616),
		('d6782cfc-29ef-4241-985b-0a6ff6cf4c64',4,'Mungu�a S.L.','https://emmanuel.com.mx','Yaretzi_Saldivar28@yahoo.com','5573429070','05203 Mart�n Lado','Le�n C�sarland','Guerrero',19.4388920409004,-99.1303342703873),
		('dd56e1e9-bd67-41cd-baac-a8f9f47ad5c8',4,'Fuentes, Porras and Barajas','http://ariadna.com.mx','Jimena25@hotmail.com','5087469378','81414 Luz Ferrocarril','Paolabury','Michoacan',19.439351178762,-99.1330661270515),
		('ac3bafbe-ea67-47cb-af99-63d945f71bf5',1,'Ledesma, V�lez and Mat�as','https://miranda.mx','Amalia27@gmail.com','5593520541','7630 Collado Huerta','Irapuato Carolina','Jalisco',19.442714750418,-99.1272541693695),
		('3e26a92c-defb-4475-8c23-450750556fb9',4,'Galarza, Griego and Orozco','https://jose-luis.com.mx','JosEduardo_Narvez@nearbpo.com','5177114746','0785 Jos� Luis Mercado','Tampico-P�nuco Mercedes','Guerrero',19.4353118112828,-99.1309174043316),
		('6b7cd221-7859-4ece-8ed6-fd79283f0e65',2,'Hurtado, Armijo and Soto','https://iker.org','Patricio.Alonso52@gmail.com','5234475063','830 Valent�n Colonia','La Laguna Ana Mar�amouth','Tabasco',19.4334338750765,-99.1304472538227),
		('d7888ed4-52f0-4be8-a210-f0d28ce0e565',0,'Paredes - Montero','http://abraham.com.mx','Vanessa_Quinterodelacruz84@hotmail.com','5783052043','237 Regina Jardines','Pilarshire','Nuevo Le�n',19.4392401826759,-99.1331904409434),
		('e6c4bf95-dba4-44b5-af90-b0ab7214146e',0,'Zavala - Chavarr�a','https://ignacio.mx','Jernimo_Armas@nearbpo.com','5588078464','019 Arag�n Urbanizaci�n','Carrasquillobury','Yucat�n',19.4332403037143,-99.1322942363824),
		('1d7e6cac-013e-404b-8d93-19d838ef30e1',1,'Padilla, Mata and Posada','https://gabriel.com.mx','Josefina_Cano@corpfolder.com','5554352295','0658 Espino Conjunto','M�rida Emilio','Guerrero',19.4391502709296,-99.1241315374085),
		('811fa2fc-f29c-4152-a821-7c2a67ab5d21',4,'Gallegos, Anguiano and Jurado','http://eduardo.com','Carla.Ramn81@corpfolder.com','5572745754','2179 Jos� Plaza','Sofiaville','Durango',19.4340626239805,-99.123802582133),
		('6e658154-be6f-409c-9c38-b53cc38c2705',3,'Figueroa e Hijos','http://maria-cristina.org','FernandoJavier.Batista@nearbpo.com','5576091302','166 Gaona Ferrocarril','Tetela de Ocampo Ester','Yucat�n',19.4341630436042,-99.1306978434607),
		('40424cd9-a4ff-466f-bea9-51cacb2dd2d5',3,'Cruz, Korta hernandez and Y��ez','http://pedro.info','Jorge.Carrion@gmail.com','5551482751','684 Barrientos Monte','Orizaba Nataliahaven','Estado de M�xico',19.4420366147771,-99.1327560682552),
		('ed23040e-6d68-4211-b31c-62e2f36d120a',3,'Casanova - Jaramillo','http://brayan.com','Valentina_Gracia59@nearbpo.com','5573342065','220 �ngel Gabriel Solar','Canc�n Yaretzi','Durango',19.4338099754932,-99.1293445790167),
		('8e086874-60ff-44d5-a327-e4bccf3a90ed',2,'Moya - Cepeda','https://claudia.info','Silvia20@hotmail.com','5592612849','28658 Jos� Antonio Aldea','Guardadoview','Chihuahua',19.4419745943281,-99.1321057228515),
		('5675b76e-738a-4f6f-9adc-2a1b708b67fc',1,'Yanes S.A.','http://ruben.info','MaraLuisa_Amador@nearbpo.com','5555572993','358 Mar�a Soledad Arrabal','Tlalnepantla Cristobal','Baja California Sur',19.4392354955343,-99.1289326011347),
		('c4965d5d-4c08-4806-8cfc-77099379ce4e',1,'Rael, Mota and Cintr�n','https://francisco.org','Miguelngel4@corpfolder.com','5511280590','821 Lorena Ramal','Tula Ad�nville','Chihuahua',19.4415982312132,-99.1263520866613),
		('da7c9bad-6036-4a3a-8873-81dfaa585b26',0,'Hinojosa Hermanos','https://erick.mx','XimenaGuadalupe.Mireles@nearbpo.com','5382692003','8772 Marrero Huerta','Zaragozafort','Morelos',19.4371094580814,-99.1292572617558),
		('71795f1c-4ca0-4ec7-b925-5b906711329b',3,'Zamudio S.L.','http://cecilia.com.mx','Estela.Quinta80@hotmail.com','5590101852','928 Benav�dez Municipio','Terrazasside','Baja California Sur',19.436545609192,-99.1255914573305),
		('556091ed-3047-4f07-a2e3-1abbb37ff1bd',4,'Kamat S.L.','http://melissa.mx','Eva88@corpfolder.com','5756043582','4820 Gurule Rambla','Le�n Kimberlyland','Aguascalientes',19.4402502573403,-99.129177464601),
		('87b35453-f063-461a-b17b-9173f7f09805',0,'Arevalo - Res�ndez','http://esteban.info','Valeria.Espinal@yahoo.com','5560091544','481 Raquel Huerta','R�oshaven','Guanajuato',19.4362662910558,-99.1329428029646),
		('8d567e51-e73c-47b3-ad15-9ca14c32da14',0,'�a�ez S.L.','http://cristobal.mx','Eduardo_Montes75@nearbpo.com','5506416955','705 Gloria Avenida','Armijomouth','Tabasco',19.4348031353559,-99.1248489134273),
		('84314586-29fb-420f-95e5-f15fbe7a619c',0,'Mayorga S.L.','https://eva.com.mx','Melissa51@corpfolder.com','5521791308','4152 Karem Mercado','Coatzacoalcos Nicol�sstad','Baja California Norte',19.4396650326257,-99.1324215899109),
		('1b413a3a-e894-4142-a954-37176f12003b',1,'B�ez, Karan and Armijo','https://fernando.info','Alexa.Ortega@yahoo.com','5545520700','08030 Juan Manuel Torrente','Uruapan del Progreso Juan Pabloland','Tabasco',19.4336995689413,-99.1310921118645),
		('15c7fea0-89e8-4539-8632-46a619ef4ce9',1,'Garc�a e Hijos','http://victor-manuel.gob.mx','JosEmilio31@corpfolder.com','5250478668','3239 Apodaca Parque','Campeche Ramiroborough','Puebla',19.4329125180636,-99.1312079178662),
		('073aa6dc-3363-417c-b3f4-eba74fb75de8',3,'Palacios, Moreno and Bustamante','http://bernardo.mx','Luis.Anaya25@corpfolder.com','5581978966','37097 Florencia Senda','Octavioville','Chiapas',19.4345657240534,-99.1324248464642),
		('36d43234-edd6-4680-8054-f2f6e4e4ab47',3,'Polanco - Rodr�guez','http://paola.gob.mx','Mayte.Camacho@nearbpo.com','5778085952','31916 Daniel Glorieta','Zitacuaro Monserratchester','Sinaloa',19.4345222724234,-99.1268400906496),
		('7b97ebd0-6c61-43b1-80c6-bdc88846c727',3,'Arag�n, Robles and Echevarr�a','https://mario.org','MaradeJess32@gmail.com','5558191752','5983 Tapia Lado','Juanaborough','Baja California Sur',19.4369541201093,-99.1300720732733),
		('58c0549f-4b2c-43d4-af8d-d4641ffa9f66',4,'Zabaleta S.A.','http://sofia.com','Bernardo.Yebra48@hotmail.com','5538173475','65562 Olivas Rinc�n','Durango Elizabethchester','Campeche',19.4353102945797,-99.1292043829922),
		('5dccd552-2941-485c-a80d-8a769f4df5c5',0,'Pelayo, Puente and Echevarr�a','https://homero.gob.mx','Eva.Ferrer47@hotmail.com','5568360596','96024 Ana Sof�a Pol�gono','Chetumal Liliafort','Tlaxcala',19.4407029973394,-99.1274806865075),
		('6308a2f2-6719-4ff6-818e-4e62f41a5296',4,'Ben�tez - Carbajal','https://jaime.com.mx','Eva_Faras11@corpfolder.com','5566384264','795 Gayt�n Colonia','Nicol�sview','Durango',19.4392862624074,-99.1315240351859),
		('72cc52c1-7aa5-4098-a391-5a713e2d9781',0,'Lozada, Ch�vez and Guerrero','https://estefania.mx','Victoria.Valadez@corpfolder.com','5567287108','66998 Tejada Colegio','Isabelbury','Oaxaca',19.4386676858929,-99.1258376904511),
		('601c7236-e03c-4ba1-beb5-38fbc09108f9',1,'Mesa e Hijos','http://sofia.org','Julia_Chavarra@nearbpo.com','5565772068','6236 Axel Mas�a','Francisco Javierland','Baja California Sur',19.4332135495246,-99.1317243400941),
		('3e21e0c4-3f89-42fb-8676-8350b95883e2',3,'Mu�oz, Armend�riz and Moya','https://abraham.com.mx','Emilio.Kortahernandez@nearbpo.com','5500103302','626 Adriana Ramal','Rochaport','Veracruz',19.4347243681182,-99.124112030466),
		('8b8af894-bc42-4664-b08c-6cf4ef28081f',3,'Delgadillo - Escobar','http://cristian.mx','JosLuis.Valds86@yahoo.com','5325988654','73621 Gloria Colegio','Delgadilloshire','Michoacan',19.4349934102413,-99.1317232767496),
		('0b9447e8-6253-4337-b9a0-d6573149fde0',1,'Palomino - Vargas','http://abigail.mx','Cecilia_Zabaleta76@nearbpo.com','5566689802','396 Abreu Bloque','Kortajarenaside','Quintana Roo',19.4344720539688,-99.1317786295296),
		('cc9c245d-8b02-44c3-868e-90a3149edd5b',2,'Vallejo, Jim�nez and Jaimes','https://alfredo.gob.mx','Ramn_Campos@nearbpo.com','5534642223','9775 Amaya Cuesta','Valle de M�xico Juanborough','Tlaxcala',19.4356576463445,-99.125283200194),
		('b6c3a6d0-4082-4353-926a-b903132b29f4',4,'Ram�n Hermanos','http://gloria.gob.mx','Abril.Yez@yahoo.com','5526705438','41601 Lucia Manzana','Vallechester','Quintana Roo',19.4373485952783,-99.1278959822006),
		('32084e1d-41b9-4dc8-9b8a-83b5003302c1',2,'S�enz - Romo','https://juan.gob.mx','Pablo_Alicea@yahoo.com','5523671866','65816 Sergio Parque','Becerraport','Sonora',19.439706773805,-99.1294421685118),
		('5b04ad6d-54c1-419c-b8cd-69090fee4e76',0,'Ramos S.L.','https://matias.gob.mx','Daniela_Castillo26@yahoo.com','5565166901','919 Salvador Colonia','�ngel Gabrielfurt','Chiapas',19.4328546478255,-99.1334435543724),
		('fdc12e77-af11-496a-846b-94068dcded56',2,'Arag�n, Herrera and Cortez','https://camila.com.mx','Victoria14@hotmail.com','5359320036','18089 Ram�rez Partida','Los Mochis Carlachester','Jalisco',19.4373096016916,-99.1316867379894),
		('39292d20-d201-4f0f-91a2-58e0f38fb2a2',0,'Carrillo - Ozuna','https://carlos.mx','Armando82@yahoo.com','5515577461','18190 Villag�mez Ronda','Reynosa-R�o Bravo Sofia','Colima',19.4426364027457,-99.1282194494786),
		('84572f5a-ea3d-4800-930c-5799a897b06c',1,'Khalid - Cort�s','https://rosa-maria.mx','Alan.Escobar@corpfolder.com','5191038970','225 Cort�s Mas�a','Ixtapaluca Mar�a de Jes�smouth','Veracruz',19.4387030534986,-99.1266594672533),
		('3765054a-c706-4dcd-8424-aa8db4e5a4bd',4,'Cas�rez S.L.','https://julio-cesar.gob.mx','Isaac86@gmail.com','5567057696','808 Noriega Pasaje','La Paz Lucasbury','Jalisco',19.4354772960097,-99.1257455545481),
		('beef488c-7f32-4a35-8469-89f5c6277972',4,'Cordero, Chapa and Lomeli','https://erick.org','Elisa.Orozco1@gmail.com','5577596369','70658 Arredondo Extrarradio','Torre�n Tadeochester','Veracruz',19.4412851137021,-99.1308549949321),
		('fe82f695-e437-4f42-9a69-d3a451c4a1d0',0,'Jaramillo - Narv�ez','https://raul.org','scar_Olivo@yahoo.com','5591730248','0112 Jaime Apartamento','Comit�n de Dominguez Gregorio','Jalisco',19.4403016289445,-99.1262358490707),
		('b464014b-44ca-43e3-ba27-7477c8af2a53',0,'Carrero Hermanos','http://luz.info','Adn.valos@corpfolder.com','5562179920','7383 Hinojosa Huerta','Carlahaven','Hidalgo',19.4331364103761,-99.1239206144939),
		('8e5f2c9c-7a25-4cc0-a4fa-306c1a6e2d91',2,'Sedillo - M�rquez','https://maria-teresa.org','DulceMara98@nearbpo.com','5452478262','4279 Tadeo Parcela','Lozanoshire','Chiapas',19.4345106458622,-99.133588671354),
		('83967700-00d9-4d8e-8b5d-dd72f4fba3e5',0,'Bueno, Crespo and Rodr�gez','https://gonzalo.com','Toms.Sols@gmail.com','5578929369','6347 Reina Salida','Roybalfort','Zacatecas',19.4414123829808,-99.1285456725889),
		('650156a1-081b-4760-b438-0cee445be58e',3,'Reyna S.A.','https://soledad.gob.mx','XimenaGuadalupe.Alaniz@nearbpo.com','5518264968','895 Xenia Prolongaci�n','Mazatl�n Antoniamouth','Morelos',19.4391381510049,-99.1331929757194),
		('b2ca0188-62c0-4bba-b20c-62bc2d4ba192',4,'Rubio S.A.','http://victor.info','Hugo.Casrez2@hotmail.com','5471253103','119 Polanco Colegio','Vicentechester','Morelos',19.4364424457615,-99.1264581487192),
		('cb0e214f-b0e4-496a-8164-eac6105b2d35',0,'Valles, Tamez and Duarte','https://marta.com','Anita_Crdova@gmail.com','5574635517','16737 Garrido Rampa','Piedras Negras Martaport','Campeche',19.4336349655599,-99.133191981167),
		('b8b03b3d-4c06-4d91-b895-5d8dc85cbb2e',2,'Venegas S.L.','http://maria-guadalupe.com.mx','Dbora.Delgado66@gmail.com','5810547684','776 Burgos Plaza','Karantown','Quintana Roo',19.441435397794,-99.1330114246513),
		('9e71243d-3b46-45de-9f1f-019b1bfe6bac',1,'Romo, Olmos and Calder�n','https://valeria.gob.mx','Emilio29@corpfolder.com','5510186181','67576 Cab�n Chalet','Nicol�sfurt','Jalisco',19.4409545181696,-99.1246169936148),
		('59cddeed-fbea-425f-8181-4bd1354b4dfe',1,'Arias S.L.','https://alejandro.com.mx','Axel.Zavala60@hotmail.com','5537651378','739 Ortiz Manzana','Abrahamfurt','Baja California Norte',19.433120066708,-99.1278492816332),
		('39be48e9-ec92-4ce5-8c90-768dfe20fc37',1,'Almaraz, Narv�ez and Ur�as','https://sebastian.com.mx','Lola32@nearbpo.com','5500100614','684 Rol�n Apartamento','Karanmouth','Oaxaca',19.4403983376366,-99.1311737788635),
		('80537b08-6bae-444b-9564-98731e680f59',0,'Alaniz - Aponte','https://ariadna.com.mx','Mara26@corpfolder.com','5524823622','750 Alberto Escalinata','Tehuantepec-Salina Cruz Mauriciostad','Hidalgo',19.4328851082879,-99.1264391826167),
		('714ce590-f302-4453-895b-aa2992c2fa2c',1,'Armend�riz S.A.','https://eloisa.org','Regina35@yahoo.com','5542891822','821 Agust�n Quinta','Piedras Negras Jes�sberg','Chiapas',19.4365512864902,-99.1330232850163),
		('ecbdb52a-4263-4bf1-87fb-8d9d809ea6aa',4,'Soliz Hermanos','http://roberto.gob.mx','Mercedes_Lugo@hotmail.com','5537295998','440 Ceballos Huerta','Oaxaca Sara','Aguascalientes',19.4350203104182,-99.1272196445501),
		('596081be-67c8-4c47-8c56-e2611cd4fa32',2,'Olivo, Santana and Elizondo','http://victor-manuel.gob.mx','Emmanuel_Rosas56@nearbpo.com','5545851405','4409 Jos� Luis Rampa','Elizabethtown','Durango',19.4349571052152,-99.1273542526554),
		('8a5aefe2-8d0c-45b6-aab2-4da2769e10fa',4,'V�zquez, Espinal and Cerv�ntez','http://mariana.gob.mx','Leticia.Hidalgo@nearbpo.com','5528679468','055 Julio Lugar','Zacatlan Jos� Emilioside','Guanajuato',19.4384168098522,-99.1275969855933),
		('c9186202-30a4-48e7-b20b-c56d733fa76a',1,'Viera S.L.','http://ximena.gob.mx','Benjamn26@yahoo.com','5518272168','675 Kamal Chalet','Guanajuato Tadeoview','Estado de M�xico',19.4422736535412,-99.1293520211967),
		('32b74fb4-1911-4db9-9646-f5ce4663ff1c',0,'Alicea - Casta�eda','https://gustavo.org','Gerardo_Ozuna32@yahoo.com','5599747935','5702 Yamileth Terrenos','Coronadoview','Zacatecas',19.4394962074356,-99.1264430870515),
		('e5f21255-2dde-469e-bff8-4ea81d6fca27',3,'Medrano - Chavarr�a','http://julia.org','Kevin.Longoria68@nearbpo.com','5568061069','0302 �guilar Terrenos','Ocotl�n Maricarmenstad','Tabasco',19.436839996763,-99.1278302262401),
		('3b84c87a-1cf9-40e8-81ff-19669240ce9b',2,'Naranjo, Galarza and �guilar','https://juan-pablo.com','Monserrat.Lozano77@corpfolder.com','5588438707','9390 Manuel Sector','Cuernavaca Aliciachester','Puebla',19.4353167526405,-99.1330388682153),
		('d3df42be-c6ff-43f6-8226-066140ab1b01',0,'Kanzaki e Hijos','http://ivanna.info','Eva_Guerra48@gmail.com','5487547323','8465 Jorge Luis Aldea','Saizside','Quer�taro',19.434062387208,-99.1290043474481),
		('35b9efad-5168-419e-96bc-0535e5e5d2f9',1,'Villarreal - Gayt�n','http://yolanda.info','Camila.Castellanos@corpfolder.com','5344687599','00698 Vallejo Ferrocarril','Arriagabury','Veracruz',19.4371300218306,-99.1285803138142),
		('9c6f0247-d128-4396-b80c-8f9648928ec0',4,'Salcedo Hermanos','https://marco-antonio.org','Victoria.Lucero@corpfolder.com','5573413844','7688 Puga Entrada','Gonzaloborough','Sinaloa',19.4406955632526,-99.1321159016228),
		('937518f0-a27f-491e-8788-ae9be0c65b31',2,'Gonzales, Valladares and Espinal','https://carlota.org','Dolores.Mercado64@corpfolder.com','5528685947','30474 Montez Mercado','Jos� Luisstad','Sinaloa',19.4373070507688,-99.1280911153489),
		('534d5669-c0d4-4fe1-805e-7f836eb80e0f',1,'Zayas - Loya','https://javier.com','Teresa_Miramontes@nearbpo.com','5523743315','9119 Lorenzo Riera','Tulancingo Zoe','Tlaxcala',19.4409621455642,-99.1257052728607),
		('72bd30eb-192f-4f5a-bda2-bde3ae0844c2',1,'Huerta e Hijos','https://esteban.com.mx','Gloria_Robledo73@nearbpo.com','5509051989','93160 Xairo Belmonte V�a','Ciudad Obreg�n Emmanuel','Zacatecas',19.439100216425,-99.1246991701265),
		('5e238917-a1e1-408a-93d5-0c1bcb3361bc',0,'Carranza e Hijos','http://diana.org','Teresa_Domnquez39@corpfolder.com','5545204593','19099 Isabel Bloque','Tlaxcala-Apizaco Juan Manuel','Sinaloa',19.4397348136227,-99.1323492884756),
		('4e20f081-3095-4918-88f8-9591991b017f',4,'V�lez - Maldonado','http://jose-eduardo.org','Diego16@gmail.com','5516205131','5206 Ju�rez Salida','Manuelaburgh','Puebla',19.437768497719,-99.1286486584673),
		('74c9182c-9ec1-47cb-8271-50729ae7f95d',3,'Sol�s, Valles and Collado','http://mariana.com','Mario_Arreola51@gmail.com','5917337221','638 Sedillo Urbanizaci�n','Concepci�nside','Quintana Roo',19.4411028197343,-99.1292894373791),
		('19e1837a-c9ad-49d8-8d6d-7cb1d2ee0700',0,'�guilar - Matos','https://eloisa.com.mx','LuisMiguel.Godnez83@yahoo.com','5616561563','319 Dolores Rampa','Coatzacoalcos Gonzalo','Oaxaca',19.4371495033689,-99.1265104266516),
		('6589e471-ae41-4e6b-83b8-9654d6fc71ea',1,'Peres, Meraz and Pe�a','http://esteban.com.mx','Luisngel.Gmez50@nearbpo.com','5581479974','134 Hidalgo Avenida','Ojo de agua Luis �ngelport','Campeche',19.4329329697467,-99.1312921006981),
		('58131b8b-1b93-495f-b7a1-0e2e1b93633d',2,'Meraz e Hijos','http://ximena.gob.mx','Isabela.Briones11@gmail.com','5495151485','10411 Pagan Salida','Ciudad de M�xico Carlota','Aguascalientes',19.4386824334767,-99.1289113955692),
		('097f66dd-ca33-4f30-88e4-33193fcf8cda',1,'Brise�o - Rodarte','https://fernando-javier.com','Mario84@yahoo.com','5256976186','780 Medina Terrenos','Madridland','Sonora',19.4338572792132,-99.1254273785957),
		('fcb9b113-49f5-4119-8016-c7357ac135fc',0,'Briones S.A.','http://maria-de-jesus.com','Emilio_Abeyta@yahoo.com','5539404967','375 Puente Puente','Tulancingo de Bravo Margarita','Zacatecas',19.4397584721567,-99.1261198391815),
		('0c91a515-2be1-4e8b-a4b0-be4f0ed1cce1',0,'Pedroza, Heredia and Lebr�n','https://zoe.com','Teodoro_Zelaya@gmail.com','5932627483','69201 D�vila Edificio','Julioview','Baja California Norte',19.4338683815538,-99.1265759170152),
		('7ef3ed97-ebd6-4114-b2c1-af664534df79',1,'J�quez, Jim�nez and Yami','http://dulce-maria.org','Ivan_Delro32@gmail.com','5555522401','057 Mel�ndez Aldea','Zacatlan Claudia','Baja California Sur',19.4417827101103,-99.1295518319173),
		('3eb803d7-445a-43cd-9d08-2c3bd1c56148',1,'Esquivel S.L.','https://abigail.com','Norma40@corpfolder.com','5552972577','66678 Andr�s Salida','Zacatlan Berta','Baja California Sur',19.4380931173689,-99.1334110923394),
		('24345eda-0451-4225-a6d0-17365f746afc',3,'Jaramillo - Flores','http://jose-antonio.com.mx','Patricia.Noriega75@yahoo.com','5520411112','2399 Esquibel Partida','Culiac�n Cristianport','Chihuahua',19.4419967206293,-99.1243064222698),
		('1ce2e219-d0e5-4f88-85f9-c152485ec7ab',0,'Matos S.L.','https://ricardo.info','JosEmilio.Cotto69@corpfolder.com','5502208117','69982 Luis Gabino Terrenos','Canc�n Estefan�ahaven','Hidalgo',19.4420166275981,-99.1313996519641),
		('04e43341-64c0-4f66-822f-f2c0ef02e6bc',0,'Barela e Hijos','https://timoteo.gob.mx','Soledad.Brito7@yahoo.com','5500281343','8758 Alondra Romina Parcela','Guadalupeside','Tamaulipas',19.4416139456541,-99.1336614550933),
		('f73cfbce-60b8-4e2c-9ec7-de8dbb5e0a49',1,'Palacios - Montez','https://felipe.org','Rosalia.Estvez@nearbpo.com','5590666046','7676 Raquel Solar','Marco Antonioton','Michoacan',19.4410634069499,-99.1304676964673),
		('edb50561-46f9-4541-9c04-8de82401cc13',4,'Pedraza - Ni�o','http://jose-eduardo.gob.mx','Irene_Rojas95@nearbpo.com','5537531201','207 Chavarr�a Lado','Franciscohaven','Baja California Norte',19.4426838205224,-99.1250245928884)

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        SET @ErrorMessage = 'Error en el procedimiento almacenado Insertar Certificado: ' + @ErrorMessage +
                    '. Error en la l�nea: ' + CAST(ERROR_LINE() AS NVARCHAR(10))
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    ROLLBACK TRANSACTION;
END CATCH




SELECT * FROM  Restaurant.Restaurants

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
GO
-- DROP PROCEDURE Restaurant.sp_insert
CREATE PROCEDURE Restaurant.sp_insert(
   @Rating TINYINT,
   @Name VARCHAR(40), 
   @WebSite VARCHAR(40),
   @email VARCHAR(45),
   @phone VARCHAR(15), 
   @street VARCHAR(35),
   @city VARCHAR(50),
   @State VARCHAR(30),
   @lat FLOAT, 
   @lng FLOAT,
   @Id UNIQUEIDENTIFIER
   )
AS
BEGIN
    DECLARE
        @ErrorMessage NVARCHAR(4000),
        @ErrorSeverity INT,
        @ErrorState INT

    SET NOCOUNT ON;

    -- Validar si ya existe el id
    IF EXISTS (SELECT TOP 1 Id FROM Restaurant.Restaurants WHERE Id = @Id)
    BEGIN
        RAISERROR('El registro con el Id  ya existe.', 16, 1);
        RETURN;
    END
		
	-- Asignar un nuevo Id si no se proporciona uno
    IF @Id IS NULL
    BEGIN
        SET @Id = NEWID();
    END
	
    -- Validar si está en intervalo
    IF @Rating < 0 OR @Rating > 4
    BEGIN
        RAISERROR('El valor de Rating debe estar entre 0 y 4.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO Restaurant.Restaurants (Rating, [Name], WebSite, Email, Phone, Street, City, [State], Lat, Lng, Id)
            VALUES  (@Rating, @Name, @WebSite, @email, @phone, @street, @city, @State, @lat, @lng, @Id);
        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        SET @ErrorMessage = 'Error en el procedimiento almacenado Insertar Certificado: ' + @ErrorMessage +
                    '. Error en la línea: ' + CAST(ERROR_LINE() AS NVARCHAR(10))
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        ROLLBACK TRANSACTION;
    END CATCH

    SELECT @Id AS NewRestaurantID;
    SET NOCOUNT OFF;
END;
GO

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

































-------------------------------------------------------------------

-- CREATE TABLE Intelimetrica.ADMINISTRADOR.Esquemas
GO
CREATE TABLE Intelimetrica.ADMINISTRADOR.Esquemas (
    SchemaId TINYINT IDENTITY(0,1) PRIMARY KEY NOT NULL,
	Schema_nombre NVARCHAR(30) NOT NULL, 
	ActivoId TINYINT DEFAULT 1 NOT NULL
);

ALTER TABLE Intelimetrica.ADMINISTRADOR.Esquemas
ADD CONSTRAINT FK_Activos_Esquemas
FOREIGN KEY (ActivoId) REFERENCES Intelimetrica.Activos.Activo(ActivoId);


GO
BEGIN TRY
    BEGIN TRANSACTION
        INSERT INTO Intelimetrica.ADMINISTRADOR.Esquemas (Schema_nombre)
        VALUES	('DESCONOCIDO'),
				('Activos'),
				('Restaurant'),
				('Administrador')
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    DECLARE
        @ErrorMessage NVARCHAR(4000),
        @ErrorSeverity INT,
        @ErrorState INT
    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        SET @ErrorMessage = 'Error en el procedimiento almacenado Insertar Certificado: ' + @ErrorMessage +
                    '. Error en la l�nea: ' + CAST(ERROR_LINE() AS NVARCHAR(10))
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    ROLLBACK TRANSACTION;
END CATCH

select * from Intelimetrica.ADMINISTRADOR.Esquemas




-------------------------------------------------------------------
-------------------------------------------------------------------
GO
CREATE TABLE Intelimetrica.ADMINISTRADOR.Tablas (
    TableId SMALLINT IDENTITY(0,1) PRIMARY KEY NOT NULL,
    SchemaId TINYINT DEFAULT 0,
	Table_nombre NVARCHAR(30) NOT NULL, 
	ActivoId TINYINT DEFAULT 1 NOT NULL
);

ALTER TABLE Intelimetrica.ADMINISTRADOR.Tablas
ADD CONSTRAINT FK_Activos_Tablas
FOREIGN KEY (ActivoId) REFERENCES Intelimetrica.Activos.Activo(ActivoId);


BEGIN TRY
    BEGIN TRANSACTION
        INSERT INTO Intelimetrica.ADMINISTRADOR.Tablas (SchemaId,Table_nombre)
        VALUES
				(0,'Activo'),
				(1,'Restaurants'),
				(3,'Esquemas'),
				(3,'Tablas'),
				(3,'RowChangeLog'),
				(3,'TipoAccion'),
				(3,'RowChangeLog'),
				(3,'TipoAccion')
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    DECLARE
        @ErrorMessage NVARCHAR(4000),
        @ErrorSeverity INT,
        @ErrorState INT
    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        SET @ErrorMessage = 'Error en el procedimiento almacenado Insertar Certificado: ' + @ErrorMessage +
                    '. Error en la l�nea: ' + CAST(ERROR_LINE() AS NVARCHAR(10))
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    ROLLBACK TRANSACTION;
END CATCH

SELECT * FROM [Administrador].[Tablas]





---------------------------------------------------------------------------
---------------------------------------------------------------------------

CREATE TABLE Intelimetrica.ADMINISTRADOR.TipoAccion (
    ActionTypeId TINYINT IDENTITY(0,1) PRIMARY KEY, 
    ActionType NVARCHAR(12) NOT NULL, -- Tipo de acci�n:'DESCONOCIDO', 'INSERT', 'UPDATE', 'DELETE'
    );

INSERT INTO Intelimetrica.ADMINISTRADOR.TipoAccion (ActionType)
VALUES ('INSERT'),('UPDATE'),('DELETE')

SELECT * FROM Intelimetrica.ADMINISTRADOR.TipoAccion
---------------------------------------------------------------------------
---------------------------------------------------------------------------



CREATE TABLE Intelimetrica.ADMINISTRADOR.RowChangeLog (
    LogID INT IDENTITY(0,1) PRIMARY KEY,			-- ID de registro �nico (clave primaria)
    ActionTypeId TINYINT DEFAULT 0 NOT NULL, 
    TableId SMALLINT DEFAULT 0 NOT NULL,			-- Nombre de la tabla afectada
    [RowCount] INT NOT NULL,							-- Cantidad de filas cambiadas
    UserName NVARCHAR(128) NOT NULL,				-- Nombre del usuario que realiz� la acci�n
    [TIMESTAMP] DATETIME DEFAULT GETDATE() NOT NULL,	-- Marca de tiempo de la acci�n
	Authorized BIT DEFAULT 0						-- Cambio Authorizado
);


ALTER TABLE Intelimetrica.ADMINISTRADOR.RowChangeLog
ADD CONSTRAINT FK_RowChangeLog_TipoAccion
FOREIGN KEY (ActionTypeId) REFERENCES Intelimetrica.ADMINISTRADOR.TipoAccion(ActionTypeId);


ALTER TABLE Intelimetrica.ADMINISTRADOR.RowChangeLog
ADD CONSTRAINT FK_RowChangeLog_TableId
FOREIGN KEY (TableId) REFERENCES Intelimetrica.ADMINISTRADOR.Tablas(TableId);


INSERT INTO Intelimetrica.ADMINISTRADOR.Tablas (SchemaId,Table_nombre)
VALUES 	(3,'RowChangeLog'),	(3,'TipoAccion')
-------------------------------------------------------------------
-------------------------------------------------------------------

CREATE LOGIN API_Intelimetrica 
WITH PASSWORD = 'Pass.1234';
GO

CREATE USER API_Intelimetrica 
FOR LOGIN API_Intelimetrica;


-- Negar  todos los permisos de los esquemas menos el esquema Restaurant
DECLARE @SchemaName NVARCHAR(MAX);
DECLARE cur CURSOR FOR 
    SELECT name FROM sys.schemas WHERE name NOT IN ('Restaurant');

OPEN cur;
    FETCH NEXT FROM cur INTO @SchemaName;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            EXEC('DENY SELECT, UPDATE, DELETE ON SCHEMA::[' + @SchemaName + '] TO API_Intelimetrica;');
            FETCH NEXT FROM cur INTO @SchemaName;
        END
CLOSE cur;

DEALLOCATE cur;
    IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'Restaurant')
        BEGIN
            GRANT SELECT, UPDATE, DELETE ON SCHEMA :: Restaurant TO API_Intelimetrica;
        END
    ELSE
        BEGIN
            PRINT 'El esquema Restaurant no existe en la base de datos.';
        END
    GO

-------------------------------------------------------------------
-------------------------------------------------------------------

CREATE TRIGGER trg_Audit_Activo
   ON Activos.Activo
   AFTER INSERT, UPDATE, DELETE
   AS
      BEGIN
          SET NOCOUNT ON;
          DECLARE @ActionTypeId TINYINT;
          DECLARE @TableId SMALLINT;
          DECLARE @RowCount INT;
          DECLARE @UserName NVARCHAR(128);
          DECLARE @ActionType NVARCHAR(12);

          IF EXISTS (SELECT 1 FROM inserted)
          BEGIN
              IF EXISTS (SELECT 1 FROM deleted)
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'UPDATE');
              ELSE
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'INSERT');
          END
          ELSE IF EXISTS (SELECT 1 FROM deleted)
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DELETE');
             END
          ELSE
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DESCONOCIDO');
             END
    
          SET @TableId = 0; 
          SET @RowCount = (SELECT COUNT(*) FROM inserted) + (SELECT COUNT(*) FROM deleted);
          SET @UserName = SYSTEM_USER;

          INSERT INTO Intelimetrica.ADMINISTRADOR.RowChangeLog (ActionTypeId, TableId, [RowCount], UserName)
          VALUES (@ActionTypeId, @TableId, @RowCount, @UserName);
      END;






-------------------------------------------------------------------
-------------------------------------------------------------------
GO
CREATE TRIGGER trg_Audit_Administrador_Esquemas
   ON Administrador.Esquemas--, Administrador.RowChangeLog, Administrador.Tablas, Administrador.TipoAccion
   AFTER INSERT, UPDATE, DELETE
   AS
      BEGIN
          SET NOCOUNT ON;
          DECLARE @ActionTypeId TINYINT;
          DECLARE @TableId SMALLINT;
          DECLARE @RowCount INT;
          DECLARE @UserName NVARCHAR(128);
          DECLARE @ActionType NVARCHAR(12);

          IF EXISTS (SELECT 1 FROM inserted)
          BEGIN
              IF EXISTS (SELECT 1 FROM deleted)
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'UPDATE');
              ELSE
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'INSERT');
          END
          ELSE IF EXISTS (SELECT 1 FROM deleted)
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DELETE');
             END
          ELSE
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DESCONOCIDO');
             END
    
          SET @TableId = 0; 
          SET @RowCount = (SELECT COUNT(*) FROM inserted) + (SELECT COUNT(*) FROM deleted);
          SET @UserName = SYSTEM_USER;

          INSERT INTO Intelimetrica.ADMINISTRADOR.RowChangeLog (ActionTypeId, TableId, [RowCount], UserName)
          VALUES (@ActionTypeId, @TableId, @RowCount, @UserName);
      END;








-------------------------------------------------------------------
-------------------------------------------------------------------
GO
CREATE TRIGGER trg_Audit_Administrador_RowChangeLog
   ON Administrador.RowChangeLog--, Administrador.Tablas, Administrador.TipoAccion
   AFTER INSERT, UPDATE, DELETE
   AS
      BEGIN
          SET NOCOUNT ON;
          DECLARE @ActionTypeId TINYINT;
          DECLARE @TableId SMALLINT;
          DECLARE @RowCount INT;
          DECLARE @UserName NVARCHAR(128);
          DECLARE @ActionType NVARCHAR(12);

          IF EXISTS (SELECT 1 FROM inserted)
          BEGIN
              IF EXISTS (SELECT 1 FROM deleted)
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'UPDATE');
              ELSE
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'INSERT');
          END
          ELSE IF EXISTS (SELECT 1 FROM deleted)
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DELETE');
             END
          ELSE
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DESCONOCIDO');
             END
    
          SET @TableId = 0; 
          SET @RowCount = (SELECT COUNT(*) FROM inserted) + (SELECT COUNT(*) FROM deleted);
          SET @UserName = SYSTEM_USER;

          INSERT INTO Intelimetrica.ADMINISTRADOR.RowChangeLog (ActionTypeId, TableId, [RowCount], UserName)
          VALUES (@ActionTypeId, @TableId, @RowCount, @UserName);
      END;





-------------------------------------------------------------------
-------------------------------------------------------------------
GO
CREATE TRIGGER trg_Audit_Administrador_Tablas
   ON  Administrador.Tablas--, Administrador.TipoAccion
   AFTER INSERT, UPDATE, DELETE
   AS
      BEGIN
          SET NOCOUNT ON;
          DECLARE @ActionTypeId TINYINT;
          DECLARE @TableId SMALLINT;
          DECLARE @RowCount INT;
          DECLARE @UserName NVARCHAR(128);
          DECLARE @ActionType NVARCHAR(12);

          IF EXISTS (SELECT 1 FROM inserted)
          BEGIN
              IF EXISTS (SELECT 1 FROM deleted)
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'UPDATE');
              ELSE
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'INSERT');
          END
          ELSE IF EXISTS (SELECT 1 FROM deleted)
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DELETE');
             END
          ELSE
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DESCONOCIDO');
             END
    
          SET @TableId = 0; 
          SET @RowCount = (SELECT COUNT(*) FROM inserted) + (SELECT COUNT(*) FROM deleted);
          SET @UserName = SYSTEM_USER;

          INSERT INTO Intelimetrica.ADMINISTRADOR.RowChangeLog (ActionTypeId, TableId, [RowCount], UserName)
          VALUES (@ActionTypeId, @TableId, @RowCount, @UserName);
      END;





-------------------------------------------------------------------
-------------------------------------------------------------------
GO
CREATE TRIGGER trg_Audit_Administrador_TipoAccion
   ON Administrador.TipoAccion
   AFTER INSERT, UPDATE, DELETE
   AS
      BEGIN
          SET NOCOUNT ON;
          DECLARE @ActionTypeId TINYINT;
          DECLARE @TableId SMALLINT;
          DECLARE @RowCount INT;
          DECLARE @UserName NVARCHAR(128);
          DECLARE @ActionType NVARCHAR(12);

          IF EXISTS (SELECT 1 FROM inserted)
          BEGIN
              IF EXISTS (SELECT 1 FROM deleted)
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'UPDATE');
              ELSE
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'INSERT');
          END
          ELSE IF EXISTS (SELECT 1 FROM deleted)
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DELETE');
             END
          ELSE
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DESCONOCIDO');
             END
    
          SET @TableId = 0; 
          SET @RowCount = (SELECT COUNT(*) FROM inserted) + (SELECT COUNT(*) FROM deleted);
          SET @UserName = SYSTEM_USER;

          INSERT INTO Intelimetrica.ADMINISTRADOR.RowChangeLog (ActionTypeId, TableId, [RowCount], UserName)
          VALUES (@ActionTypeId, @TableId, @RowCount, @UserName);
      END;


-------------------------------------------------------------------
-------------------------------------------------------------------
GO
CREATE TRIGGER trg_Audit_Restaurant_Restaurants
   ON Restaurant.Restaurants
   AFTER INSERT, UPDATE, DELETE
   AS
      BEGIN
          SET NOCOUNT ON;
          DECLARE @ActionTypeId TINYINT;
          DECLARE @TableId SMALLINT;
          DECLARE @RowCount INT;
          DECLARE @UserName NVARCHAR(128);
          DECLARE @ActionType NVARCHAR(12);

          IF EXISTS (SELECT 1 FROM inserted)
          BEGIN
              IF EXISTS (SELECT 1 FROM deleted)
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'UPDATE');
              ELSE
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'INSERT');
          END
          ELSE IF EXISTS (SELECT 1 FROM deleted)
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DELETE');
             END
          ELSE
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DESCONOCIDO');
             END
    
          SET @TableId = 0; 
          SET @RowCount = (SELECT COUNT(*) FROM inserted) + (SELECT COUNT(*) FROM deleted);
          SET @UserName = SYSTEM_USER;
          IF @UserName <> 'API_Intelimetrica'
             BEGIN
                 INSERT INTO Intelimetrica.ADMINISTRADOR.RowChangeLog (ActionTypeId, TableId, [RowCount], UserName)
                 VALUES (@ActionTypeId, @TableId, @RowCount, @UserName);
             END
      END;

--*******************************************************************************************************************
--*******************************************************************************************************************


GO
--DROP PROCEDURE Restaurant.sp_insert_Restaurant
CREATE PROCEDURE Restaurant.sp_insert_Restaurant(
   @Id UNIQUEIDENTIFIER,
   @Rating TINYINT,
   @Name VARCHAR(40), 
   @WebSite VARCHAR(40),
   @email VARCHAR(45),
   @phone VARCHAR(15), 
   @street VARCHAR(35),
   @city VARCHAR(50),
   @State VARCHAR(30),
   @lat FLOAT, 
   @lng FLOAT
   )
AS
BEGIN
    DECLARE
        @ErrorMessage NVARCHAR(4000),
        @ErrorSeverity INT,
        @ErrorState INT

    SET NOCOUNT ON;

    -- Validar si ya existe el id
    IF EXISTS (SELECT TOP 1 Id FROM Restaurant.Restaurants WHERE Id = @Id)
    BEGIN
        RAISERROR('El registro con el Id  ya existe.', 16, 1);
        RETURN;
    END
	
	
	-- Asignar un nuevo Id si no se proporciona uno
    IF @Id IS NULL
    BEGIN
        SET @Id = NEWID();
    END
	
    -- Validar si está en intervalo
    IF @Rating < 0 OR @Rating > 4
    BEGIN
        RAISERROR('El valor de Rating debe estar entre 0 y 4.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO Restaurant.Restaurants (Rating, [Name], WebSite, Email, Phone, Street, City, [State], Lat, Lng, Id)
            VALUES  (@Rating, @Name, @WebSite, @email, @phone, @street, @city, @State, @lat, @lng, @Id);
        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        SET @ErrorMessage = 'Error en el procedimiento almacenado Insertar Certificado: ' + @ErrorMessage +
                    '. Error en la línea: ' + CAST(ERROR_LINE() AS NVARCHAR(10))
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        ROLLBACK TRANSACTION;
    END CATCH

    SELECT @Id AS NewRestaurantID;
    SET NOCOUNT OFF;
END;
GO
---------------------------------------------------------------------------------------------------------
CREATE PROCEDURE Restaurant.sp_delete_Restaurant
    @RestaurantsId INT = NULL,
    @Id UNIQUEIDENTIFIER = NULL
AS
BEGIN
    DECLARE
        @ErrorMessage NVARCHAR(4000),
        @ErrorSeverity INT,
        @ErrorState INT;

    SET NOCOUNT ON;

    -- Validar que al menos uno de los parámetros sea proporcionado
    IF @RestaurantsId IS NULL AND @Id IS NULL
    BEGIN
        RAISERROR('Debe proporcionar al menos RestaurantsId o Id para realizar la eliminación.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        IF @RestaurantsId IS NOT NULL
        BEGIN
            IF EXISTS (SELECT TOP 1 Id FROM Restaurant.Restaurants WHERE RestaurantsId = @RestaurantsId)
            BEGIN
                RAISERROR('RestaurantsId ya ha sido eliminado o no existe.', 16, 1);
                RETURN;
            END

            DELETE FROM Restaurant.Restaurants
            WHERE RestaurantsId = @RestaurantsId;
        END
        ELSE
        BEGIN
            IF EXISTS (SELECT TOP 1 Id FROM Restaurant.Restaurants WHERE Id = @Id)
            BEGIN
                RAISERROR('Id ya ha sido eliminado o no existe.', 16, 1);
                RETURN;
            END

            DELETE FROM Restaurant.Restaurants
            WHERE Id = @Id;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        SET @ErrorMessage = 'Error en el procedimiento almacenado sp_delete_Restaurant: ' + @ErrorMessage +
                    '. Error en la línea: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        
        ROLLBACK TRANSACTION;
    END CATCH;

    SET NOCOUNT OFF;
END;
GO
-----------------------------------------------------------------------------------------------------------


CREATE PROCEDURE Restaurant.sp_update_Restaurant
    @RestaurantsId INT = NULL,
    @Id UNIQUEIDENTIFIER = NULL,
    @Rating TINYINT = NULL,
    @Name VARCHAR(40) = NULL,
    @WebSite VARCHAR(40) = NULL,
    @Email VARCHAR(45) = NULL,
    @Phone VARCHAR(15) = NULL,
    @Street VARCHAR(35) = NULL,
    @City VARCHAR(50) = NULL,
    @State VARCHAR(30) = NULL,
    @Lat FLOAT = NULL,
    @Lng FLOAT = NULL
AS
BEGIN
    DECLARE
        @ErrorMessage NVARCHAR(4000),
        @ErrorSeverity INT,
        @ErrorState INT;

    SET NOCOUNT ON;

    -- Validar que al menos RestaurantsId o Id sea proporcionado
    IF @RestaurantsId IS NULL AND @Id IS NULL
    BEGIN
        RAISERROR('Debe proporcionar al menos RestaurantsId o Id para realizar la actualización.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        IF @RestaurantsId IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT TOP 1 Id FROM Restaurant.Restaurants WHERE RestaurantsId = @RestaurantsId)
            BEGIN
                RAISERROR('RestaurantsId no existe.', 16, 1);
                RETURN;
            END

            UPDATE Restaurant.Restaurants
            SET Rating = ISNULL(@Rating, Rating),
                [Name] = ISNULL(@Name, [Name]),
                WebSite = ISNULL(@WebSite, WebSite),
                Email = ISNULL(@Email, Email),
                Phone = ISNULL(@Phone, Phone),
                Street = ISNULL(@Street, Street),
                City = ISNULL(@City, City),
                [State] = ISNULL(@State, [State]),
                Lat = ISNULL(@Lat, Lat),
                Lng = ISNULL(@Lng, Lng)
            WHERE RestaurantsId = @RestaurantsId;
        END
        ELSE
        BEGIN
            IF NOT EXISTS (SELECT TOP 1 Id FROM Restaurant.Restaurants WHERE Id = @Id)
            BEGIN
                RAISERROR('Id no existe.', 16, 1);
                RETURN;
            END

            UPDATE Restaurant.Restaurants
            SET Rating = ISNULL(@Rating, Rating),
                [Name] = ISNULL(@Name, [Name]),
                WebSite = ISNULL(@WebSite, WebSite),
                Email = ISNULL(@Email, Email),
                Phone = ISNULL(@Phone, Phone),
                Street = ISNULL(@Street, Street),
                City = ISNULL(@City, City),
                [State] = ISNULL(@State, [State]),
                Lat = ISNULL(@Lat, Lat),
                Lng = ISNULL(@Lng, Lng)
            WHERE Id = @Id;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        SET @ErrorMessage = 'Error en el procedimiento almacenado sp_update_Restaurant: ' + @ErrorMessage +
                    '. Error en la línea: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        
        ROLLBACK TRANSACTION;
    END CATCH;

    SET NOCOUNT OFF;
END;
GO