# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "MyString"
    description "MyString"
    location "MyString"
    date_start DateTime.now
    date_limit "2014-04-02 23:16:43"
    created_at "2014-04-02 23:16:43"
    updated_at "2014-04-02 23:16:43"
  end

  factory :invalid_event, parent: :event do
    title "T"*300
    description "D"*300
    location "MyString"
    date_limit "2014-04-02 23:16:43"
    created_at "2014-04-02 23:16:43"
    updated_at "2014-04-02 23:16:43"
  end

end
