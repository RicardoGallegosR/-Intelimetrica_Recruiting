# Intelimetrica_Recruiting
Quiz Back-End Developer


## Summary

We are expecting to receive a simple application that shows your programming skills and knowledge. We consider that the average time to implement this project is about 5 hours but because we understand you are a busy person you have a maximum of 48 hours after you receive the test to send us your answer.


We will evaluate the following:

- REST API with CRUD operations.
- Link to the repository (Github, Render, Bitbucket or Railway).

**Important Instructions**

Please ensure that your application meets the following requirements:
- Add a README file.
- Complete your test using the cloud platform of your choice, Railway, Render and/or Dockerize our application.



## Assignment Description

You are working for a startup called Melp, which has a revolutionary idea about building an app that will provide useful information about restaurants to users. You were provided with a CSV which contains raw data about the restaurants. 


### Task 1

The first task consists in importing the raw data into a relational database and exposing a REST API that implements CRUD (Create, Read, Update, Delete) operations.

The Restaurants table needs to have the following schema:

 ```
Restaurants (
id TEXT PRIMARY KEY, -- Unique Identifier of Restaurant
            rating INTEGER, -- Number between 0 and 4
            name TEXT, -- Name of the restaurant
            site TEXT, -- Url of the restaurant
            email TEXT,
            phone TEXT,
            street TEXT,
            city TEXT,
            state TEXT,
            lat FLOAT, -- Latitude
            lng FLOAT) -- Longitude
```
You can find the CSV with the raw data at the following link (it contains dummy data): https://recruiting-datasets.s3.us-east-2.amazonaws.com/restaurantes.csv


### Task 2

The second task consists in implementing the following endpoint:

- `/restaurants/statistics?latitude=x&longitude=y&radius=z`


It receives a latitude and a longitude as parameters, which correspond to the center of a circle, and a third parameter that corresponds to a radius in METERS.

___
* Hint: A tool like PostGIS or equivalent may help you with the spatial queries ;)
___
 

This endpoint needs to return a JSON with the following data:
```
{
         count: Count of restaurants that fall inside the circle with center [x,y] and radius z,
         avg: Average rating of restaurant inside the circle,
         std: Standard deviation of rating of restaurants inside the circle
}
```


Once deployed, please send us the following:
Link  to the repository.
A Postman collection (https://www.getpostman.com/docs/collections) to test your API.

 
Bonus Points:
- Good use of Git.
- Documentation of the API.
- Correct use of HTTP verbs.
- Good programming practices.

 
# Sin más por el momento, agarrence que vamos recios :D
Puedes utilizar el lenguaje con el que te sientas más cómodo. Sin embargo, te recomendamos usar Python.
Asimismo, te pedimos por favor nos confirmes que recibiste este correo.

Quedamos atentos a cualquier duda o comentario.