
require_relative '../lib/quotes'

describe Quote do
  let(:quote) { Quote.new }

  it 'should return a joke' do
    res = quote.display_quote
    expect(res).to be_a Hash
  end

  it 'should return a quote with text as string' do
    res = quote.display_quote
    expect((res['text'])).to be_a String
  end
end