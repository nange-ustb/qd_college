# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset do
    title "MyString"
    link "MyString"
    body "MyString"
    desc "MyString"
    position 1
    type ""
    viewable_type "MyString"
    viewable_id 1
  end
end
