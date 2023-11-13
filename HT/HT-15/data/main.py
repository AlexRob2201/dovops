import mysql.connector

class MySql:
    def __init__(self, host, user, password, database):
        try:
            self.mysql_connect = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database
            )
            self.mysql_cursor = self.mysql_connect.cursor()
            print(f'Connect to database {database} successfully')
        except Exception as e:
            print(f'Error during connection: {e}')
