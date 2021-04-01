require_relative 'help'

class Joke
  def initialize
    @joke = ''
  end

  def display_joke(name)
    get_joke(name)
    joke
  end

  private

  attr_accessor :joke

  def get_joke(name)
    api = "https://api.chucknorris.io/jokes/random?name=#{name}"
    res = Request.new_request(api)
    @joke = res['value']
  end
end