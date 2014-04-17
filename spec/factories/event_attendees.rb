# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_attendee do
  	status 1
  	association :attendee, factory: :user
  	association :event
  end
end
