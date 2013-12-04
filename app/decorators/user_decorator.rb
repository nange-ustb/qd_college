# -*- encoding : utf-8 -*-
module UserDecorator
  def user_header_img
    if user_header and user_header.link.present?
      image_tag user_header.link_url(:mini)
    else
      image_tag asset_path("images/user/sculpture.jpg")
    end
  end

  def province_and_city
    if zone = current_user.zone
      if zone.root?
        province = zone
      else
        province = zone.parent
        city = zone
      end
    end

    return province,city
  end
end
