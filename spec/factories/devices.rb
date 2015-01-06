FactoryGirl.define do
  factory :device do
    secret { SecureRandom.uuid }

    factory :device_with_group do
      group_id { SecureRandom.uuid }
    end
  end
end
