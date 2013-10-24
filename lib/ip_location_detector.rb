# -*- encoding : utf-8 -*-
require "qqwry"
class IpLocationDetector
  attr_accessor :qq_parser
  def initialize
    @qq_parser = QQWry::QQWryFile.new
  end

  def detect( ip_str )
    result = @qq_parser.find( ip_str )
    result
  rescue
    return nil
  end
end
