module AuthenticationHelper
  # returns a hash that can be merged with other headers
  def authenticate(id = nil, secret = nil)
    unless id || secret
      secret = SecureRandom.uuid
      id = create(:device, secret: secret).id
    end
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
