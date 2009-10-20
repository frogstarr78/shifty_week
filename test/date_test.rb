require 'test/test_helper'

class DateTest < Test::Unit::TestCase
  FORMAT = 
	def test_step
		date = Date.strptime Time.now.strftime("%Y-%m-%d")
		future_date = date+6
		received_date = date
		date.step(7){ |d| received_date = d }
		assert_equal(received_date, future_date, "un-equal dates: #{date.to_s} #{future_date.to_s}")
	end
end
