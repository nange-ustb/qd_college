# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :document do
    title "MyString"
    body "MyString"
    user_id 1
    level "MyString"
    topic "MyString"
  end
end
