# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_invitation do
    association :invitee, factory: :user
    association :event, factory: :event
    status 0
  end
end
