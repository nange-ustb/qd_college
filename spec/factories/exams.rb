# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exam do
    level "MyString"
    student_id 1
    correct 1
    incorrect 1
    is_pass "MyString"
  end
end
