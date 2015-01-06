RSpec::Matchers.define :exist_in_database do
  match do |actual|
  	actual && actual.class.exists?(actual.id)
  end
end