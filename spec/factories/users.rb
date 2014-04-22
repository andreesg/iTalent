# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@italent.com"
  end

  factory :user, aliases: [:creator] do
    email
    password "123456789"

    #used for authentication in tests
    factory :regular_user do
      email "user@italent.com"
      password "i"*8
      password_confirmation "i"*8
    end

    factory :invalid_user do
      email nil
      password nil
    end
  end

end
