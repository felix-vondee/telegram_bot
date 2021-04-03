require 'httparty'

module Request
  def self.new_request(api)
    res = HTTParty.get(api)
    JSON.parse(res.body)
  end
end
