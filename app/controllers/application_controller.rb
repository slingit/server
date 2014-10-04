class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected

  def current_device
  	b64 = request.headers["HTTP_AUTHORIZATION"].to_s.sub(/\ABasic /, "")
  	authstring = Base64.decode64(b64)
  	username, password = authstring.try(:split, ?:, 2)
  	Device.find_by_id(password)
  end
end
