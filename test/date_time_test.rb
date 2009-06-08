require 'test/test_helper'

class DateTimeTest < Test::Unit::TestCase
  def test_to_time
    now = DateTime.now.to_time
    assert_kind_of Time, now
  end
end
