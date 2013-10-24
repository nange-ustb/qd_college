# -*- encoding : utf-8 -*-
class TrustTextChecker

  attr_accessor :connector , :content
  attr_accessor :validate_action
  
  class TrustTextCheckerResult
    attr_accessor :result , :words
    
    def initialize( xml_str )
      @result = ""
      xml = Nokogiri::XML( xml_str )
      
      if xml.xpath('//invalid_request').many?
        @result = "invalid_request"
      elsif xml.xpath('//valid_content').many?
        @result = "valid"
      else
        @words = xml.xpath('//keyword').collect( &:text )
      end
    end
    
    def result
      ActiveSupport::StringInquirer.new( @result )
    end
    
  end
  
  def initialize
    @connector = Faraday.new(:url => defined?(TRUST_TEXT_URL) ?  TRUST_TEXT_URL : "http://211.103.170.19:8000")
    @validate_action = "validates"
  end
  
  def validate!( content )
    resp_xml = @connector.post( @validate_action , { :content => content } )
    TrustTextCheckerResult.new( resp_xml.body )
  end
  
end

class TrustTextValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    trust_text_validate = TrustTextChecker.new.validate!( value )
    return if trust_text_validate.result.valid?
    
    if trust_text_validate.result.invalid_request?
      record.errors[attribute] << I18n.t('.invalid_request')
    else
      words_count = trust_text_validate.words.size
      words_str = trust_text_validate.words.join( ", " )
      record.errors[attribute] << I18n.t('.illegal_words' , :words => words_str , :count => words_count)
    end
  end
  
end
