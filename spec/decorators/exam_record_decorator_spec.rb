# coding: utf-8
require 'spec_helper'

describe ExamRecordDecorator do
  let(:exam_record) { ExamRecord.new.extend ExamRecordDecorator }
  subject { exam_record }
  it { should be_a ExamRecord }
end
