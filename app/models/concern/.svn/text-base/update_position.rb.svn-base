# -*- encoding : utf-8 -*-
module UpdatePosition
  extend ActiveSupport::Concern
  included do
    default_scope { order("position") }
    before_create :update_position
  end

  def update_position
    self.position = self.class.maximum( :position ).to_i + 1
  end
end
