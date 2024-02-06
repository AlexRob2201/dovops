import unittest
from shop import PetShop


class TestMysql(unittest.TestCase):
    def setUp(self):
        self.shop = PetShop("localhost", "root", "password")
        print("Connected!!!!!!!!!!!!!!!!!!!!")
    
    def test_create_item(self):
        self.shop.create_shop()
        res = self.shop.add_item("test pet1", 20)
        print(f"RES: {res}")
        self.assertTrue(len(res) > 0)
    
    def tearDown(self):
        self.shop.delete_shop()


if __name__ == "__main__":
    print("Start unit test!!!!!!!!!!!!!!!!!!!!!!!")
    unittest.main()
