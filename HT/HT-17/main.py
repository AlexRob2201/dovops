import json
import requests
import logging


class LinkParser():
    def __init__(self, verbose=False):
        self.content = None
        self.data = {}
        self.verbose = verbose

        logging.basicConfig(level=logging.INFO)
        self.logger = logging.getLogger(__name__)
        

    def get_content(self, link):
        self.content = requests.get(link)
        if self.verbose:
            self.logger.debug(f"Response from {link}: {self.content.content}")

    def get_json(self):
        todos = json.loads(self.content.text)
        return todos

    def save_to_my_destination(self, destination):
        try:
            json_data = self.get_data_from_json()
            with open(destination, 'w') as destination_file:
                json.dump(json_data, destination_file, indent=2)
            self.logger.info(f"Data successfully saved to {destination}")
        except Exception as e:
            self.logger.error(f"Error: {e}")

    def get_data_from_json(self):
        json_data = self.get_json()
        for data in json_data:
            user_id = data.get('userId')
            if user_id is not None:
                self.data[f"User : {user_id}"] = str(user_id)
                if self.verbose:
                    self.logger.debug(f"Found userId: {user_id}")
        return self.data

if __name__ == "__main__":
    parser = LinkParser(verbose=False)  # Передаємо verbose=True, щоб увімкнути режим логування
    parser.get_content('https://jsonplaceholder.typicode.com/posts')
    parser.save_to_my_destination('destination.json')
