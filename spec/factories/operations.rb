# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :operation do
    master_id "MyString"
    master_type "MyString"
    name "MyString"
    position 1
  end
end
