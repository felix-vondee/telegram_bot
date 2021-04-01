require 'telegram/bot'
require 'dotenv/load'
require 'httparty'

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
end

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    bot_commands(bot, message)
  end
end