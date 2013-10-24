# -*- encoding : utf-8 -*-
class String
  def truncate_by_byte(length, options = {})
    text = self.dup
    options[:omission] ||= "..."

    length_with_room_for_omission = length - options[:omission].mb_chars.length
    chars = text.mb_chars

    (text.bytesize > length ? chars.limit( length_with_room_for_omission ) + options[:omission] : chars.limit(length)).to_s
  end

  def truncate_by_width( length , options = {} )
    text = self.dup
    options[:omission] ||= "..."
    options[:comparation] ||= 2

    length_with_room_for_omission = length - options[:omission].mb_chars.length

    text_heavy_ary = text.chars.map{|mbc| mbc.bytesize > 1 ? options[:comparation] : 1 }

    heavy_step = index = 0

    text_heavy_ary.detect{|h| heavy_step += h ; index += 1; heavy_step >= length_with_room_for_omission }

    (index < text.chars.to_a.size ? text.mb_chars[0...index] + options[:omission] : text).to_s
  end
end

