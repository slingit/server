require 'rails_helper'

RSpec.describe DevicesController, :type => :controller do
  describe "POST #create" do
    context "with valid data" do
      before do
        @id = SecureRandom.uuid
        @secret = SecureRandom.uuid
        post :create, devices: { id: @id, secret: @secret }
      end

      it "responds with 201 Created" do
        expect(response).to have_http_status 201
      end

      it "assigns data" do
        expect(assigns(:device).id).to eq @id
        expect(assigns(:device)).to be_valid_secret @secret
      end

      it "creates device" do
        expect(Device).to be_exists assigns(:device).id
      end
    end

    context "with insufficient data" do
      before do
        @id = SecureRandom.uuid
        post :create, devices: { id: @id }
      end

      it "responds with 422 Unprocessable Entity" do
        expect(response).to have_http_status 422
      end

      it "does not create device" do
        expect(Device).not_to be_exists assigns(:device).id
      end
    end

    context "with unpermitted data" do
      before do
        @id = SecureRandom.uuid
        @digest = "$2a$10$2MNELztoaC3Snzw9kbp8ou9p8PAlDwhOGWIJuqVsFWhK3.qNm8nnm"
        post :create, devices: { id: @id, password_digest: @digest }
      end

      it "does not assign unpermitted data" do
        expect(assigns(:device).id).to eq @id
        expect(assigns(:device).password_digest).to be_nil
      end
    end
  end
end
