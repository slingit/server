require "rails_helper"

describe Authentication, type: :controller_concern do
  controller do
    include AbstractController::Callbacks

    before_action :authenticate

    def auth
      render text: authenticated_device.id
    end
  end

  context "when no authentication is supplied" do
    it "responds with 401 Unauthorized" do
      expect(request(:auth).status).to eq 401
    end
  end

  context "when correct authentication is supplied" do
    let!(:secret) { SecureRandom.uuid }
    let!(:device) { create(:device, secret: secret) }
    let!(:response) { request(:auth, authenticate(device.id, secret)) }

    it "responds with 200 OK" do
      expect(response.status).to eq 200
    end

    it "finds device ID" do
      expect(response.body.chomp).to eq device.id
    end
  end

  context "when incorrect authentication is supplied" do
    it "responds with 401 Unauthorized" do
      authentication = authenticate(SecureRandom.uuid, SecureRandom.uuid)
      response = request(:auth, authentication)
      expect(response.status).to eq 401
    end
  end
end
