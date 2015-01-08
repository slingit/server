require "rails_helper"

describe ErrorHandling, type: :controller_concern do
  controller do
    def create
      Device.create(id: Device.first.id, secret: SecureRandom.uuid)
      render nothing: true
    end

    def nothing
      render nothing: true
    end
  end

  context "when creating a duplicate record" do
    it "responds with 422 Unprocessable Entity" do
      FactoryGirl.create(:device)
      response = request(:create)
      expect(response.status).to eq 422
    end
  end

  context "when doing nothing" do
    it "responds with 200 OK" do
      expect(request(:nothing).status).to eq 200
    end
  end
end
