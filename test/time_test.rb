require 'test/test_helper'

class TimeTest < Test::Unit::TestCase
  def test_shift_for_time
    format = "%c"
    assert_respond_to Time.now, ">>"
    assert_respond_to Time.now, "<<"

    assert_equal (DateTime.parse(Time.now.strftime(Time::WORKER_FORMAT))<<1).strftime(format), (Time.now<<1).strftime(format)
    assert_equal (DateTime.parse(Time.now.strftime(Time::WORKER_FORMAT))>>1).strftime(format), (Time.now>>1).strftime(format)

    assert_equal (Time.local(2008, 12, 1)).strftime(format), (Time.local(2008, 10, 1)>>2).strftime(format)
    assert_equal (Time.utc(2008, 12, 1)).strftime(format), (Time.utc(2008, 10, 1)>>2).strftime(format)
  end
end
