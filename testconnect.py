import pyodbc

server = 'localhost'
database = 'LeagueManageSystem'
username = 'SA'
password = 'Abdu420?'

conn = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};SERVER=' + server + ';DATABASE=' + database + ';UID=' + username + ';PWD=' + password)
cursor = conn.cursor()
cursor.execute("SELECT * FROM player")
for row in cursor:
    print(row)
conn.close()
