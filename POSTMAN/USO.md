# Tuto de como usar la Rest API
- Abra postman y cree un nueva conexion 
- Seleccione HTTP
- Asegurece que el metodo GET este seleccionado 
- Debajo del metodo GET esta la `Autorization` ingrezamos con la `Basic Auth`  e ingresamos las credenciales de la API, 
    - `API_Intelimetrica`
    - `Pass.1234`

![ejecucion](img\1.png)

- Ingrese la url `http://127.0.0.1:5000/restaurants/statistics?`
- En la Pestaña `Params` ingrese la **_latitude_**, **_longitude_** y **_radius_** como `Key`  y en `Value` ingrese sus respectivos Valores.

**_NOTA:_** recuerde que el parametro radius esta en [metros]
Una vez concluido los pasos anteriores obrima el boton **_Send_** para obtener el query con los valores correspondientes.