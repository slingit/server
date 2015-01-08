module ControllerConcernHelper
  module ClassMethods
    def controller(&block)
      before { controller(&block) }
    end
  end

  def controller(&block)
    @controller ||= begin
      concern = described_class
      Class.new(ActionController::Base) do
        include concern
      end
    end
    @controller.class_eval(&block) if block
    @controller
  end

  def request(action_name = :test_action, options = {})
    action = controller.action(action_name)
    request = Rack::MockRequest.new(action)
    request.get("/", options)
  end
end

RSpec.configure do |config|
  config.include ControllerConcernHelper, type: :controller_concern
  config.extend ControllerConcernHelper::ClassMethods, type: :controller_concern
end
