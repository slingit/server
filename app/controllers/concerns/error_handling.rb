module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from "ActiveRecord::RecordNotUnique" do |error|
      render nothing: true, status: 422
    end
  end
end
