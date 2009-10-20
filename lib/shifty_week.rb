# Normally a calendar displayed by ruby for October 2009 would be appear:
#
#    (Using cwday)
#    Mo Tu We Th Fr Sa Su
#              1  2  3  4
#     5  6  7  8  9 10 11
#    12 13 14 15 16 17 18
#    19 20 21 22 23 24 25
#    26 27 28 29 30 31
#    
#    (Using wday)
#    Su Mo Tu We Th Fr Sa
#                 1  2  3
#     4  5  6  7  8  9 10
#    11 12 13 14 15 16 17
#    18 19 20 21 22 23 24
#    25 26 27 28 29 30 31
#
# With this gem you can set a week_day_start.
#
# In this example to Wed.
#
# And the calendar will be displayed::
#
#    We Th Fr Sa Su Mo Tu
#        1  2  3  4  5  6
#     7  8  9 10 11 12 13
#    14 15 16 17 18 19 20
#    21 22 23 24 25 26 27
#    28 29 30 31

module ShiftyWeek
  WORKER_FORMAT = "%Y-%m-%d %H:%M:%S"
  class Constants # :nodoc:
    SUMMARY     = %q{Calculate dates based on a configurable first day of the week.}
    DESCRIPTION = %q{Calculate dates based on a configurable first day of the week. If you want
    the first day of the week to be Wednesday and the current calendar Year-Month are 2009-10,
    DateTime#week_days will return an array of DateTime objects which when formatted with "%Y-%m-%d %a" look like 
    ["2009-10-14 Wed", "2009-10-15 Thu", "2009-10-16 Fri", "2009-10-17 Sat", "2009-10-18 Sun", "2009-10-19 Mon", "2009-10-20 Tue"] }
  end

  # TODO: Implement Quarters
  # TODO: Implement human_diff method 2009-02-01 - 2009-01-01 #=> 1 month or 31 days, etc...
#  def human_diff o, options = {}
#    d = (self.day - o.day)*-1
#    h = self.day < o.day ? ' ago' : ' til'
#    r = "#{d} day".send(d > 1 ? :pluralize : :singularize)
#    r << h if options[:historical]
#    r
#  end

  # Calculate the last week day for the month
  def last_week_day
    DateTime.new(self.year, self.month, self.days_in_month).wday
  end

  # Instance method for retreiving the number of days in this month
  def days_in_month
    Time.send("month_days", self.year, self.month)
  end

  #  Calculate the number of weeks in a year taking into account "shifted" weeks
  def weeks_in_year
    return (self-(self.yday-1)).wday == 6 && self.leap? ? 54 : 53
  end

  # Get the offset of this object's date, to the first day of the week.
  def wday_offset()
    _week_day_numbers.index(self.wday)
  end

  # Convenience method
  def month_name
    DateTime::MONTHNAMES[self.month]
  end

  # Convenience method
  def month_names
    self.class.month_names
  end

  # Get the week number for the current object
  def week
    working_date = DateTime.new(self.year, 1, 1)
    working_date.week_day_start = self.week_day_start
    working_date = (working_date-working_date.send("wday_offset"))
    week_num = 0
    working_date.step(self) { |a_day| 
      if a_day.wday == _week_day_numbers.first
        week_num += 1
      end
    }
    week_num
  end

  # TODO: Implement weeks method
#  def weeks
#    DateTime.new(self.year, self.month).step(self.days_in_month, 7) { |d|
#      week_days d.day
#    }
#  end

  # Accessor for first week day of the calendar
  def week_day_start
    @week_day_start || 0
  end
  
  # Get the days of the week based on the current week_day_start
  def week_days(options={}, &block)
    start_date = self
    result = []
    (start_date-wday_offset).step 7 do |a_day|
      a_day.week_day_start = self.week_day_start
      if block_given?
        yield a_day
      else
        result.push(a_day)
      end
    end
    result
  end

  # TODO: Implement month_weeks method
#  def month_weeks(&block)
#    result = []
#    (self - (self.day-1)).step(self.days_in_month+(6-self.last_week_day), 7) { |d| 
#      if block
#        yield d
#      else
#        result.push(d.week) 
#      end
#    }
#    result
#  end

  # Hopefully the name explains what this method does
  def step_to_month_end step = 1
    days_in_month = self.days_in_month
    days_in_month += self.wday_offset if days_in_month%(7*4) >= 0
    self.step(days_in_month, step) do |date| 
      date.week_day_start = self.week_day_start
      yield date
    end
  end

  class << self

    # Let's generate some helpers
    def included in_class
      in_class.class.send :define_method, :day_names, proc {
          (
            (0..6).to_a +
            Date::DAYNAMES +
            Date::ABBR_DAYNAMES +
            Date::ABBR_DAYNAMES.collect {|wday| wday[0,2] }
          )
        }

      in_class.class.send :define_method, :month_names, proc {
          (
            (0..12).to_a +
            DateTime::MONTHNAMES +
            DateTime::ABBR_MONTHNAMES
          )
        }
    end
  end

  private
    # Calculate the dates within a week range taking into account "shifted" weeks
    def _week_day_numbers
        week_day_start = self.week_day_start
        week_day_start.capitalize if week_day_start.is_a? String
        [0, 1, 2, 3, 4, 5, 6].partition {|on| on >= day_names.index(week_day_start)%7 }.flatten
    end

    # Simplifying access to day_names/numbers
    def day_names
      self.class.day_names
    end
end

