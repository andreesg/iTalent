# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_statistic do
    number_events_created 0
    number_events_attended 0
    number_publications_created 0
  end
end
