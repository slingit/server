module ForceJSON
  extend ActiveSupport::Concern

  included do
    before_action :set_format
  end

  private

  def set_format
    request.format = :json
  end
end
