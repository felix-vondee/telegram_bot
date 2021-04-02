
require_relative '../lib/jokes'

describe Joke do
  let(:joke) { Joke.new }
  
  it 'should return a joke that contains the name given' do
    name = 'jordan'
    res = joke.display_joke(name)
    expect((res.include? name)).to be true
  end
end