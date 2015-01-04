require "rails_helper"

RSpec.describe "GET /" do
  it "responds with No Content" do
    get "/"
    expect(response).to have_http_status 204
    expect(response.body).to be_empty
  end
end