require 'test_helper'

class ShiftyWeekTest < Test::Unit::TestCase
  def test_week_starting_sunday
      month_starts = [
   %w(Su Mo Tu We Th Fr Sa
      \  \   1  2  3  4  5
       6  7  8  9 10 11 12
      13 14 15 16 17 18 19
      20 21 22 23 24 25 26
      27 28 29 30 31),

   %w(Mo Tu We Th Fr Sa Su
      \   1  2  3  4  5  6
       7  8  9 10 11 12 13
      14 15 16 17 18 19 20
      21 22 23 24 25 26 27
      28 29 30 31),

   %w(Tu We Th Fr Sa Su Mo
       1  2  3  4  5  6  7
       8  9 10 11 12 13 14
      15 16 17 18 19 20 21
      22 23 24 25 26 27 28
      29 30 31),

   %w(We Th Fr Sa Su Mo Tu
      \  \  \  \  \  \   1
       2  3  4  5  6  7  8
       9 10 11 12 13 14 15
      16 17 18 19 20 21 22
      23 24 25 26 27 28 29
      30 31),

   %w(Th Fr Sa Su Mo Tu We
      \  \  \  \  \   1  2
       3  4  5  6  7  8  9
      10 11 12 13 14 15 16
      17 18 19 20 21 22 23
      24 25 26 27 28 29 30
      31),

   %w(Fr Sa Su Mo Tu We Th
      \  \  \  \   1  2  3
       4  5  6  7  8  9 10
      11 12 13 14 15 16 17
      18 19 20 21 22 23 24
      25 26 27 28 29 30 31),

   %w(Sa Su Mo Tu We Th Fr
      \  \  \   1  2  3  4
       5  6  7  8  9 10 11
      12 13 14 15 16 17 18
      19 20 21 22 23 24 25
      26 27 28 29 30 31)
     ]
  end

	def test_week

    date = DateTime.new(2008, 1, 6)
    assert_equal(0, date.send("wday_offset"))
    assert_equal(2, date.week, "week #{date.week} on date #{date.to_s} != 2")

    date = date-1
    assert_equal(6, date.send("wday_offset"))
    assert_equal(1, date.week, "week #{date.week} on date #{date.to_s} != 2")

    years_days = {
        2000 => 2,
        2001 => 7,	
        2002 => 6,	
        2003 => 5,	
        2004 => 4,	
        2005 => 2,	
        2006 => 8,	
        2007 => 7,	
        2008 => 6,	
        2010 => 3,	
    }.each { |year, day|
        date = DateTime.new(year, 1, day)
        assert_equal(2, date.week, "week #{date.week} on date #{date.to_s} != 1")
    }

		date = DateTime.new(2008, 1, 3)
		date.week_day_start = 'Wed'
		assert_equal(1, date.send("wday_offset"))
		assert_equal(2, date.week, "week #{date.week} on date #{date.to_s} != 2")

		date = date-1
		date.week_day_start = 'Wed'
		assert_equal(0, date.send("wday_offset"))
		assert_equal("2008-01-02", date.strftime("%Y-%m-%d"))
		assert_equal(2, date.week, "week #{date.week} on date #{date.to_s} != 2 with wday_start #{date.week_day_start}")

		date = date-1
		date.week_day_start = 'Wed'
		assert_equal(6, date.send("wday_offset"))
		assert_equal("2008-01-01", date.strftime("%Y-%m-%d"))
		assert_equal(1, date.week, "week #{date.week} on date #{date.to_s} != 1 with wday_start #{date.week_day_start}")

		date = DateTime.new(2007)
		date.week_day_start = 'Sunday'
		assert_equal(1, date.week, "week #{date.week} on date #{date.to_s} != 1")
		assert_equal(1, (date+5).week, "week #{(date+5).week} on date #{(date+5).to_s} != 1")
		date = DateTime.new(2007, 8, 25)
		assert_equal(34, date.week, "week #{date.week} on date #{date.to_s} != 34")
		date = (date+7)
#		date = DateTime.new(2007, 9, 1)
		assert_equal(35, date.week, "week #{date.week} on date #{date.to_s} != 35")

		years_days = {
			1998 => 53,
			1999 => 53,
			2000 => 54,
			2001 => 53,	
			2002 => 53,	
			2003 => 53,	
			2004 => 53,	
			2005 => 53,	
			2006 => 53,	
			2007 => 53,	
			2008 => 53,	
			2009 => 53,	
			2010 => 53,	
			2011 => 53,	
			2012 => 53,	
			2013 => 53,	
			2014 => 53,	
			2015 => 53,	
			2016 => 53,	
		}.each { |year, weeks|
			date = DateTime.new(year, 12, 31)
			assert_equal(weeks, date.week, "week #{date.week} in year #{year} != 1")
		}

		(2000..2006).each do |year|
			day = 1
				date = DateTime.new(year, 1, day)
				assert_equal(1, date.week, "week #{date.week} on date #{date.to_s} != 1")
#			end
		end

#		date = DateTime.new(2003, 1, 1)
#		week = date.week(4)
#		assert_equal(week, 1, "week #{week} on date #{date.to_s} != 1")
#		date = DateTime.new(2003, 1, 2)
#		week = date.week(4)
#		assert_equal(week, 2, "week #{week} on date #{date.to_s} != 2")
#		week = date.week(10)
#		assert_equal(week, 2, "week #{week} on date #{date.to_s} != 2")
#		date = DateTime.new(2003, 1, 3)
#		week = date.week(4)
#		assert_equal(week, 2, "week #{week} on date #{date.to_s} != 2")
	end

	def test_weeks_in_year
		years_days = {
			2000 => 54,
			2001 => 53,	
			2002 => 53,	
			2003 => 53,	
			2004 => 53,	
			2005 => 54,	
			2006 => 53,	
			2007 => 53,	
			2008 => 53,	
			2009 => 53,	
			2010 => 53,	
			2011 => 54,	
			2012 => 53,	
			2013 => 53,	
			2014 => 53,	
			2015 => 53,	
		}.each { |year, weeks|
			date = DateTime.new(year, 12, 31)
			assert_equal weeks, date.weeks_in_year, "week #{date.week} on date #{date.to_s} != 1"
		}
	end

	def test_wday_offset
		date = DateTime.new(2007)
		expected_value_map = [1, 0, 6, 5, 4, 3, 2]
		date.send("day_names").each_with_index {|wday, index| 
			date.week_day_start = wday
			assert_equal(expected_value_map[index%7], date.send("wday_offset"))
		}
	end

	def test_week_days_control
		date = DateTime.new(2007)
		assert_equal([
				DateTime.new(2006, 12, 31).to_s, 
				DateTime.new(2007, 1, 1).to_s,
				DateTime.new(2007, 1, 2).to_s,
				DateTime.new(2007, 1, 3).to_s,
				DateTime.new(2007, 1, 4).to_s,
				DateTime.new(2007, 1, 5).to_s,
				DateTime.new(2007, 1, 6).to_s
			], 
			date.week_days.collect {|date| date.to_s}
		)
  end

  def test_week_days_span_month_and_year_boundary_with_configured_week_day_start
		date = DateTime.new(2007)
		date.week_day_start = 'Saturday'
		assert_equal([
				DateTime.new(2006, 12, 30).to_s, 
				DateTime.new(2006, 12, 31).to_s, 
				DateTime.new(2007, 1, 1).to_s,
				DateTime.new(2007, 1, 2).to_s,
				DateTime.new(2007, 1, 3).to_s,
				DateTime.new(2007, 1, 4).to_s,
				DateTime.new(2007, 1, 5).to_s,
			], date.week_days.collect {|date| date.to_s}
		)
  end

  def test_week_days_dont_span_month_and_year_boundary_and_leap_year_because_of_configured_week_day_start
		date = DateTime.new(2008)
		date.week_day_start = 'Tue'
		assert_equal([
				DateTime.new(2008, 1, 1).to_s,
				DateTime.new(2008, 1, 2).to_s, 
				DateTime.new(2008, 1, 3).to_s, 
				DateTime.new(2008, 1, 4).to_s, 
				DateTime.new(2008, 1, 5).to_s, 
				DateTime.new(2008, 1, 6).to_s, 
				DateTime.new(2008, 1, 7).to_s, 
			], date.week_days.collect {|date| date.to_s}
		)
  end

  def test_week_days_span_month_and_year_boundary_and_leap_year_because_of_configured_week_day_start
		date = DateTime.new(2008)
		date.week_day_start = 'Wed'
		assert_equal([
				DateTime.new(2007, 12, 26).to_s, 
				DateTime.new(2007, 12, 27).to_s, 
				DateTime.new(2007, 12, 28).to_s, 
				DateTime.new(2007, 12, 29).to_s, 
				DateTime.new(2007, 12, 30).to_s, 
				DateTime.new(2007, 12, 31).to_s, 
				DateTime.new(2008, 1, 1).to_s,
			], date.week_days.collect {|date| date.to_s}
		)
  end

  def test_week_days_span_month_and_year_boundary_non_leap_year_with_non_configured_week_day_start
    date = DateTime.new(2003)
		assert_equal([
				DateTime.new(2002, 12, 29).to_s, 
				DateTime.new(2002, 12, 30).to_s, 
				DateTime.new(2002, 12, 31).to_s, 
				DateTime.new(2003, 1, 1).to_s,
				DateTime.new(2003, 1, 2).to_s,
				DateTime.new(2003, 1, 3).to_s,
				DateTime.new(2003, 1, 4).to_s,
			], 
			date.week_days.collect {|date| date.to_s}
		)
  end

  def test_week_days_span_month_and_year_boundary_non_leap_year_with_specific_day_but_non_configured_week_day_start
		date = DateTime.new(2007, 12, 31)
		assert_equal([
				DateTime.new(2007, 12, 30).to_s, 
				DateTime.new(2007, 12, 31).to_s, 
				DateTime.new(2008, 1, 1).to_s,
				DateTime.new(2008, 1, 2).to_s,
				DateTime.new(2008, 1, 3).to_s,
				DateTime.new(2008, 1, 4).to_s,
				DateTime.new(2008, 1, 5).to_s,
			], 
			date.week_days.collect {|date| date.to_s}
		)
		assert_equal('2008-01-05', date.strftime("%Y-%m-%d"))
  end

  def test_week_days_with_configured_integer_week_day_start
		date = DateTime.new(2007, 12, 31)
		date.week_day_start = 2
		assert_equal([
				DateTime.new(2008, 1, 1).to_s,
				DateTime.new(2008, 1, 2).to_s,
				DateTime.new(2008, 1, 3).to_s,
				DateTime.new(2008, 1, 4).to_s,
				DateTime.new(2008, 1, 5).to_s,
				DateTime.new(2008, 1, 6).to_s,
				DateTime.new(2008, 1, 7).to_s,
			],
			date.week_days.collect {|date| date.to_s }
		)

		assert_equal('2008-01-07', date.strftime("%Y-%m-%d"))
  end

  def test_week_days_with_abbreviated_week_day_name_week_day_start
		date = DateTime.new(2007, 12, 31)
		date.week_day_start = 'We'
		assert_equal([
				DateTime.new(2008, 1, 2).to_s,
				DateTime.new(2008, 1, 3).to_s,
				DateTime.new(2008, 1, 4).to_s,
				DateTime.new(2008, 1, 5).to_s,
				DateTime.new(2008, 1, 6).to_s,
				DateTime.new(2008, 1, 7).to_s,
				DateTime.new(2008, 1, 8).to_s,
			],
			date.week_days.collect {|date| date.to_s }
		)
	end

  def test_step_to_month_end
    expected_display = {
    %w(January 2009) => 
    %w(
       Th Fr Sa Su Mo Tu We
        1  2  3  4  5  6  7 
        8  9 10 11 12 13 14
       15 16 17 18 19 20 21
       22 23 24 25 26 27 28
       29 30 31  1  2  3  4
       )
    }
    
    jan_09 = DateTime.new(2009, 1)
    days_in_month = []
    jan_09.step_to_month_end do |date|
      days_in_month << date.day 
    end
    assert_equal 35, days_in_month.size
    assert_equal expected_display[%w(January 2009)][7..-1], days_in_month.collect(&:to_s)
  end

  def test_month_name
    assert_equal 'January', DateTime.new(2009, 01).month_name
  end

#	def test_month_weeks
#		date = DateTime.new(2007, 11, 17)
#		assert_equal([44, 45, 46, 47, 48], date.month_weeks, "")
#		date = DateTime.new(2007, 1, 1)
#		assert_equal([1, 2, 3, 4, 5], date.month_weeks, "")
#		date = DateTime.new(2007, 8, 1)
#		assert_equal([31, 32, 33, 34, 35], date.month_weeks, "")
#		date = DateTime.new(2007, 9, 30)
#		assert_equal([35, 36, 37, 38, 39, 40], date.month_weeks, "")
#		date = DateTime.new(2007, 12, 31)
#		assert_equal([48, 49, 50, 51, 52, 53], date.month_weeks, "")
#	end

	def test_last_week_day
		assert_equal(DateTime.new(2007, 1).last_week_day, 3);
		assert_equal(DateTime.new(2007, 2).last_week_day, 3);
		assert_equal(DateTime.new(2007, 3).last_week_day, 6);
		assert_equal(DateTime.new(2007, 4).last_week_day, 1);
		assert_equal(DateTime.new(2007, 5).last_week_day, 4);
		assert_equal(DateTime.new(2007, 6).last_week_day, 6);
		assert_equal(DateTime.new(2007, 7).last_week_day, 2);
		assert_equal(DateTime.new(2007, 8).last_week_day, 5);
		assert_equal(DateTime.new(2007, 9).last_week_day, 0);
		assert_equal(DateTime.new(2007, 10).last_week_day, 3);
		assert_equal(DateTime.new(2007, 11).last_week_day, 5);
		assert_equal(DateTime.new(2007, 12).last_week_day, 1);
	end
end
