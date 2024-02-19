from main import Mysql


class PetShop(Mysql):
    def create_shop(self):
        query = "CREATE DATABASE IF NOT EXISTS shop"
        self.query(query)
        query = "USE shop"
        self.query(query)
        query = "CREATE TABLE IF NOT EXISTS pets (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), price INT)"
        self.query(query)

    def add_item(self, name, price):
        query = f"INSERT INTO pets (name, price) VALUES ('{name}', {price});"
        self.query(query)
        query = f"SELECT id, name FROM pets WHERE name='{name}'"
        res = self.query(query)
        ids = []
        for id_name in res:
            if id_name[1] == name:
                ids.append(id_name[0])
        return ids

    def delete_item(self, name):
        query = f"DELETE FROM pets WHERE name='{name}';"
        return self.query(query)

    def delete_item_by_id(self, id):
        query = f"DELETE FROM pets WHERE id='{id}';"
        return self.query(query)
    
    def delete_shop(self):
        self.query("DROP TABLE pets")
