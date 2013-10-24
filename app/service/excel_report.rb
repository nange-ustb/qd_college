# -*- encoding : utf-8 -*-
class ExcelReport 
	attr_accessor :datas,:titles,:attrs
	def initialize(objs,titles,attrs)
		@datas = objs
		@titles = titles
		@attrs = attrs
	end

	def to_xls_report()
		sheet,book,report = initialize_sheet
	    count_row = 1
	    datas.each do |obj|
	      sheet.row(count_row).concat read_row(obj,attrs)
	      count_row += 1
	    end
	    book.write report

	    return report.string
	  end

  def initialize_sheet
  	report = StringIO.new
  	book = Spreadsheet::Workbook.new
  	sheet = book.create_worksheet :name => 'sheet1'
  	blue = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 10
  	sheet.row(0).default_format = blue
    sheet.row(0).concat titles
    return sheet,book,report
  end

  def read_row(obj,attrs)
      row = []
      attrs.each { |attr| row << column_value(obj,attr)}
      return row
  end

  def column_value(obj,attr)
    begin
      obj_dup = obj.clone
      methods = attr.split(".")
      methods.each do |method| 
        obj_dup = obj_dup.send(method.to_sym)
      end
      if obj_dup.is_a? Time
        return obj_dup.to_s(:db)
      else
        obj_dup.to_s
      end
    rescue
      ''
    end
  end
end

class << ExcelReport
  def report(objs,titles,attrs)
    new(objs,titles,attrs).to_xls_report
  end
end
