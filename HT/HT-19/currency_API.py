import requests

class Currency():
    def __init__(self) -> None:
        self.base_currency = 'UAH'
    
    def get_responce(self, target_currency):
        api_key = "87895c55f1f9d0335a9b44cf"  
        url = "https://open.er-api.com/v6/latest/UAH"  

        response = requests.get(url, params={"apikey": api_key})
        data = response.json()
        
        if "rates" in data and target_currency in data["rates"]:
            exchange_rate = data["rates"][target_currency]
            return exchange_rate
        else:
            return None
        

# if __name__ == "__main__":
#     ex = Currency()
#     ex.get_responce('USD')
#     ex.test()