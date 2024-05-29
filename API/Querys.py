def get_Restaurants (Lat:float, Lng:float, radius:float)->str:
    return f"EXEC sp_getRestaurant @Lat = {Lat}, @Lng = {Lng}, @radius = {radius};"