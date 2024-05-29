import pyodbc
import CREDENCIALES as cr


def cnx()->str:
    SERVER =cr.SERVER()  
    DATABASE = cr.DATABASE()
    return f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={SERVER};DATABASE={DATABASE};Trusted_Connection=yes;'

def getDataSet(query:str)->list:
    ratings = []
    try:
        connection = pyodbc.connect(cnx())
        cursor = connection.cursor()
        cursor.execute(query)
        row = cursor.fetchone()
        while row:
            ratings.append(row[0])
            row = cursor.fetchone()
        cursor.close()
        connection.close()

    except pyodbc.Error as e:
        print("Error al conectar a SQL Server:", e)
    return ratings