require 'telegram/bot'
require 'dotenv/load'
require 'httparty'
require_relative '../lib/jokes'
require_relative '../lib/quotes'

token = ENV['TELEGRAM_API']
$joke_request = nil
def bot_commands(bot, message)
  case message.text
  when '/help'
    greet = "Hi, #{message.from.first_name} I am a chatbot and my name is FELIX
    \n Commands:
    \n /start: Greets the user.
    \n /help: Displays the list of acceptable commands.
    \n /hi: The bot says hello.
    \n /hello: The bot says hi.
    \n /quote: Displays quote.
    \n /joke: Asks for your name and cretes a joke with it.
    \n /bye: Says goodbye "
    bot.api.send_message(chat_id: message.chat.id, text: "Hello, wlecome to telebot #{greet}")
  when '/start'
    bot.api.send_message(chat_id: message.chat.id, text: "Hello, wlecome to telebot #{message.from.first_name}")
  when '/hi'
    bot.api.send_message(chat_id: message.chat.id, text: 'Hello')
  when '/hello'
    bot.api.send_message(chat_id: message.chat.id, text: 'Hi')
  when '/bye'
    bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
  when '/quote'
    quote = Quote.new.display_quote
    bot.api.send_message(chat_id: message.chat.id, text: "#{quote['text']} \n By: #{quote['author']}")
  when '/joke'
    $joke_request = true
    bot.api.send_message(chat_id: message.chat.id, text: 'What is your name?')
end

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    bot_commands(bot, message)
  end
end