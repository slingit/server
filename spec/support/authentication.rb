module AuthenticationHelper
  # returns a hash that can be merged with other headers
  def authenticate(id, secret)
    { "HTTP_AUTHORIZATION" => "Basic " + Base64.encode64("#{id}:#{secret}") }
  end

  # applies authentication hash to request
  def authenticate!(id, secret)
    request.headers.merge! authenticate(id, secret)
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelper
end
