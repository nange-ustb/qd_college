# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exam_record do
    student_id "MyString"
    user_id "MyString"
    correct "MyString"
    level "MyString"
    exam_count "MyString"
  end
end
