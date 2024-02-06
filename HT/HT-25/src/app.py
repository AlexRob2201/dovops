#!/usr/bin/python3
import mysql.connector
import time

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
            print(f'Connected to database {database} successfully')
            time.sleep(30)
        except mysql.connector.Error as e:
            print(f'Error during connection: {e}')
            time.sleep(30)

if __name__ == "__main__":
    host = 'mysql_application'
    user = 'root'
    password = 'password'
    database = 'app'

    while True:
        try:
            db = MySql(host, user, password, database)
                        
        except Exception as e:
            print(f'Wait for SQL: {e}')

