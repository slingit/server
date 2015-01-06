require "rails_helper"

describe "exist_in_database matcher" do
  it "passes when a record exists" do
    expect do
      expect(FactoryGirl.create(:device)).to exist_in_database
    end.not_to raise_error
  end

  it "fails when a record does not exist" do
    expect do
      expect(FactoryGirl.build(:device)).to exist_in_database
    end.to raise_error RSpec::Expectations::ExpectationNotMetError
  end

  it "fails when record is nil" do
    expect do
      expect(nil).to exist_in_database
    end.to raise_error RSpec::Expectations::ExpectationNotMetError
  end
end
