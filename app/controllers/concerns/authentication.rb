module Authentication
  extend ActiveSupport::Concern
  include AbstractController::Rendering
  include ActionView::Layouts
  include ActionController::Rendering
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  attr :authenticated_device

  def authenticate
    @authenticated_device = authenticate_with_http_basic do |id, secret|
      Device.find_by(id: id).try(:authenticate, secret)
    end

    unless @authenticated_device
      render nothing: true, status: 401
    end
  end
end
