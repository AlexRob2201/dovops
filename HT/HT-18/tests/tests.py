import unittest
from main import MySql


class TestMySql(unittest.TestCase):
    def setUp(self):
        self.mysqlclass = MySql()
        
    def test_create(self):
        try:
            _query = "CREATE TABLE IF NOT EXISTS shop (id INT AUTO_INCREMENT PRIMARY KEY, item VARCHAR(255), price INT)"
            self.mysqlclass(_query)
            print('Таблиця успішно створена')
        except Exception:
            print(f'Помилка при створенні таблиці {Exception}')
        _query = "USE shop"
        self.mysqlclass(_query)
        _query = "INSERT INTO shop (item, price) VALUES ('Test', 100)"
        self.mysqlclass(_query)
    
if __name__ == "__main__":
    unittest.main()
