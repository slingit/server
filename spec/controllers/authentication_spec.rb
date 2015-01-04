require "rails_helper"

RSpec.describe DevicesController, type: :controller do
  describe "authentication" do
    let!(:device) { FactoryGirl.create(:device) }

    context "when valid" do
      before do
        secret = SecureRandom.uuid
        device.update(secret: secret)
        authenticate! device.id, secret
        get :show, id: device.id
      end

      it "responds with 200 OK" do
        expect(response).to have_http_status 200
      end

      it "finds the authenticated device" do
        expect(assigns(:authenticated_device).id).to eq device.id
      end
    end

    context "when invalid" do
      it "responds with 401 Unauthorized" do
        auth_string = "Basic " + Base64.encode64("#{device.id}:foo")
        request.headers["HTTP_AUTHORIZATION"] = auth_string
        get :show, id: device.id
        expect(response).to have_http_status 401
      end
    end
  end
end
