# -*- encoding : utf-8 -*-
class Admin::RegulationsController < Admin::ResourceController
  has_scope :search, :only => [:index], :type => :hash

  respond_to :html, :json, :js

end
