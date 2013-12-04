class Admin::ExamsController < Admin::ResourceController
	helper_method :attributes
	#has_scope :of_student,:only => [:index] 
	has_scope :search , :only => [:index] ,:type => :hash, :default => {:username=>""}
	private 
	def attributes
		["level", "correct", "incorrect", "pass", "created_at"]
	end 
end
