# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "user#{n}@italent.com"}
	password "i"*8
  end

  factory :invalid_user, parent: :user do
  	email nil
  	password nil
  end
end
