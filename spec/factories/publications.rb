# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :publication do
    sequence(:text) { |n| "Publication #{n}" }
    tags {[create(:tag)]}
    association :creator
  end

  factory :invalid_publication, parent: :publication do
  	text "A"*151
  	creator nil
  end
end
