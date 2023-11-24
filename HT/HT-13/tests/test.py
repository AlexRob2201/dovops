import unittest
from main import add_numbers

class TestAddNumbers(unittest.TestCase):

    def test_add_positive_numbers(self):
        result = add_numbers(3, 5)
        self.assertEqual(result, 8)

    def test_add_negative_numbers(self):
        result = add_numbers(-3, -5)
        self.assertEqual(result, -8)

    def test_add_mixed_numbers(self):
        result = add_numbers(10, -3)
        self.assertEqual(result, 7)

if __name__ == '__main__':
    unittest.main()
