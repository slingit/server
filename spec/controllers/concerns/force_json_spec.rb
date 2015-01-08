require "rails_helper"

describe ForceJSON, type: :controller_concern do
  controller do
    def json
      render text: request.format
    end
  end

  it "sets request format to JSON" do
    expect(request(:json).body).to eq "application/json"
  end
end
