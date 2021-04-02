require 'telegram/bot'
require 'dotenv/load'
require 'httparty'
require_relative '../lib/jokes'
require_relative '../lib/quotes'

# rubocop: disable Metrics/CyclomaticComplexity,Metrics/MethodLength,Style/GlobalVars,Metrics/AbcSize

token = ENV['TELEGRAM_API']
$joke_request = nil
def bot_commands(bot, message)
  case message.text
  when '/help'
    greet = "Hi #{message.from.first_name}, I am a chatbot. My name is felix379
    \n Commands:
    \n /init: Welcomes the user.
    \n /help: Displays the list of commands.
    \n /how_ya: The bot says 'I am great, what about you {Your Name}'.
    \n /hey: The bot says 'Hello, {Your Name}'.
    \n /rdm_quote: Shows a random quote.
    \n /rdm_joke: Asks for your name and creates a random joke with it.
    \n /bye: Says goodbye "
    bot.api.send_message(chat_id: message.chat.id, text: "Hello and welcome. #{greet}")
  when '/init'
    bot.api.send_message(chat_id: message.chat.id, text: "Hello and welcome #{message.from.first_name}")
  when '/how_ya'
    bot.api.send_message(chat_id: message.chat.id, text: "I am great, what about you #{message.from.first_name}")
  when '/hey'
    bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
  when '/bye'
    bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
  when '/rdm_quote'
    quote = Quote.new.display_quote
    bot.api.send_message(chat_id: message.chat.id, text: "#{quote['text']} \n By: #{quote['author']}")
  when '/rdm_joke'
    $joke_request = true
    bot.api.send_message(chat_id: message.chat.id, text: 'What is your name?')
  else
    if $joke_request
      name = message.text
      joke = Joke.new.display_joke(name)
      $joke_request = false
      bot.api.send_message(chat_id: message.chat.id, text: joke)
    else
      bot.api.send_message(chat_id: message.chat.id, text: 'This command is not valid, please try again')
    end
  end
end

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    bot_commands(bot, message)
  end
end

# rubocop: enable Metrics/CyclomaticComplexity,Metrics/MethodLength,Style/GlobalVars,Metrics/AbcSize
