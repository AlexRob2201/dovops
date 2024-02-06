from shop import PetShop
import sys


host = sys.argv[1]
user = sys.argv[2]
password = sys.argv[3]

petshop = PetShop(host, user, password)
petshop.create_shop()
ids = petshop.add_item("Mikky mouse", 100)
print(ids)
for id in ids:
    res = petshop.delete_item_by_id(id)
