# -*- encoding : utf-8 -*-
class TimePickerInput < SimpleForm::Inputs::Base
  def input
    "$ #{@builder.datetime_picker(attribute_name, input_html_options)}".html_safe
  end
end
