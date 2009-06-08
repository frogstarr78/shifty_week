class Preference < ActiveRecord::Base
  belongs_to :user, :foreign_key => :admin_user_id, :class_name => "AdminUser"

	class << self
    def available_perspectives
      %w(day days week weeks month months quarter quarters year)
      %w(day week month quarter year)
    end
	end
end
