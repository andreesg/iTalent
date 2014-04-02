# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "MyString"
    description "MyString"
    location "MyString"
    date_limit "2014-04-02 23:16:43"
    num_attendings 1
    num_invitations 1
    created_at "2014-04-02 23:16:43"
    updated_at "2014-04-02 23:16:43"
  end
end