# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    name "MyTag"
    num_subscribers 0
  end
end
