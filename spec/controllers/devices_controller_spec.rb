require 'rails_helper'

RSpec.describe DevicesController, :type => :controller do
  describe "GET #index" do
    let!(:secret) { SecureRandom.uuid }
    let!(:device) { FactoryGirl.create(:device_with_group, secret: secret) }
    let!(:included) do
      [FactoryGirl.create(:device, group_id: device.group_id)]
    end
    let!(:excluded) do
      [FactoryGirl.create(:device_with_group), FactoryGirl.create(:device)]
    end
    before do
      authenticate! device.id, secret
      get :index
    end

    it { is_expected.to render_template :index }

    it "responds with 200 OK" do
      expect(response).to have_http_status 200
    end

    it "includes correct devices" do
      expect(assigns(:devices) & included).to eq included
      expect(assigns(:devices) & excluded).to be_empty
    end
  end

  describe "GET #show" do
    let!(:secret) { SecureRandom.uuid }
    let!(:id) { FactoryGirl.create(:device, secret: secret).id }
    before { authenticate! id, secret }

    context "with a valid device ID" do
      before { get :show, id: id }

      it "responds with 200 OK" do
        expect(response).to have_http_status 200
      end
    end

    context "with an invalid device ID" do
      before { get :show, id: SecureRandom.uuid }

      it "responds with 404 Not Found" do
        expect(response).to have_http_status 404
      end
    end
  end

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
        assert assigns(:device).authenticate(@secret)
      end

      it "creates device" do
        expect(assigns(:device)).to exist_in_database
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
        expect(assigns(:device)).not_to exist_in_database
      end
    end

    context "with optional data" do
      let!(:id) { SecureRandom.uuid }
      let!(:secret) { SecureRandom.uuid }
      let!(:group_id) { SecureRandom.uuid }
      before do
        post :create, devices: {
          id: id,
          secret: secret,
          links: { group: group_id }
        }
      end

      it "responds with 201 Created" do
        expect(response).to have_http_status 201
      end

      it "assigns group id" do
        expect(assigns(:device).group.id).to eq group_id
      end
    end

    context "with duplicate id" do
      let!(:id) { FactoryGirl.create(:device).id }
      let!(:secret) { SecureRandom.uuid }
      before { post :create, devices: { id: id, secret: secret } }

      it "responds with 422 Unprocessable Entity" do
        expect(response).to have_http_status 422
      end

      it "does not create device" do
        expect(assigns(:device)).to exist_in_database
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

  describe "PUT #update" do
    let!(:device) { FactoryGirl.create(:device) }

    context "when group id is nil" do
      before do
        put :update, id: device.id, devices: { links: { group: nil } }
      end

      it "updates group id" do
        expect(assigns(:device).group).to be_nil
      end
    end

    context "when group id is a UUID" do
      let!(:group_id) { SecureRandom.uuid }
      before do
        put :update, id: device.id, devices: { links: { group: group_id } }
      end

      it "updates group id" do
        expect(assigns(:device).group.id).to eq group_id
      end
    end
  end
end
