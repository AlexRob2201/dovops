from telebot import types, TeleBot
from currency_API import Currency

bot = TeleBot("781768335:AAHBlKVNqQWgSTIU2OmkzuBlF3ydfYqXrv0")

@bot.message_handler(commands=['start'])
def send_welcome(message):
    welcome_message = "Вітаю, напишіть індикатор валюти з 3-х символів, який вас цікавить."
    bot.send_message(message.from_user.id, welcome_message)


@bot.message_handler(content_types=['text'])
def get_text_message(message):
    markup = types.ReplyKeyboardMarkup(resize_keyboard=True)
    if message.text.strip():
        currency = Currency()
        test = currency.get_responce(message.text)
        
        if test is not None:
            bot.reply_to(message, f"1 гривня відносно {message.text} дорівнює: {test}")
        else:
            bot.reply_to(message, f"Не вдалося отримати курс для {message.text}")
    else:
        bot.reply_to(message, "Please say something normal bastard!")


bot.infinity_polling()