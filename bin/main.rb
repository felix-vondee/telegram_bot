require 'telegram/bot'
require 'dotenv/load'
require 'httparty'
require_relative '../lib/jokes'
require_relative '../lib/quotes'

# rubocop: disable Metrics/CyclomaticComplexity

token = ENV['TELEGRAM_API']
class Bot
  def initialize
    @joke_request = nil
  end

  def variables(bot, message)
    @bot = bot
    @message = message
    bot_commands
  end

  def bot_commands
    case @message.text
    when '/help'
      help
    when '/init'
      init
    when '/how_ya'
      how_ya
    when '/hey'
      hey
    when '/bye'
      bye
    when '/rdm_quote'
      rdm_quote
    when '/rdm_joke'
      rdm_joke
    else
      check_new_text
    end
  end

  def help
    greet = "Hi #{@message.from.first_name}, I am a chatbot. My name is felix379
    \n Commands:
    \n /init: Welcomes the user.
    \n /help: Displays the list of commands.
    \n /how_ya: The bot says 'I am great, what about you {Your Name}'.
    \n /hey: The bot says 'Hello, {Your Name}'.
    \n /rdm_quote: Shows a random quote.
    \n /rdm_joke: Asks for your name and creates a random joke with it.
    \n /bye: Says goodbye "
    @bot.api.send_message(chat_id: @message.chat.id, text: "Hello and welcome. #{greet}")
  end

  def init
    @bot.api.send_message(chat_id: @message.chat.id, text: "Hello and welcome #{@message.from.first_name}")
  end

  def how_ya
    bot.api.send_message(chat_id: @message.chat.id, text: "I am great, what about you #{@message.from.first_name}")
  end

  def hey
    @bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
  end

  def bye
    @bot.api.send_message(chat_id: @message.chat.id, text: "Bye, #{@message.from.first_name}")
  end

  def rdm_quote
    quote = Quote.new.display_quote
    @bot.api.send_message(chat_id: @message.chat.id, text: "#{quote['text']} \n By: #{quote['author']}")
  end

  def rdm_joke
    @joke_request = true
    @bot.api.send_message(chat_id: @message.chat.id, text: 'What is your name?')
  end

  def check_new_text
    if @joke_request
      name = @message.text
      joke = Joke.new.display_joke(name)
      @joke_request = false
      @bot.api.send_message(chat_id: @message.chat.id, text: joke)
    else
      @bot.api.send_message(chat_id: @message.chat.id, text: 'This command is not valid, please try again')
    end
  end
end

new_bot = Bot.new
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    new_bot.variables(bot, message)
  end
end

# rubocop: enable Metrics/CyclomaticComplexity
