FactoryGirl.define do
  factory :device do
    secret SecureRandom.uuid
  end
end
