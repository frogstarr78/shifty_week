class Date
  include ShiftyWeek
	attr_writer :week_day_start

  alias_method :step_to_date, :step #:nodoc:
#   Seemed to make more sense to me to have step accept an integer number 
#   see step_to_date for previous behavior. Although, you can still pass
#   a datetime object to this method and it will call the previous behavior.
  def step(limit, step=1)
    method = 'step_to_date'
    if limit.is_a?(Integer)
      limit = (self + limit)-1
      method = 'step'
    end
    send(method, limit, step) {|a_day| 
      a_day.week_day_start = self.week_day_start
      yield a_day 
    }
  end
end

class DateTime < Date
  include ShiftyWeek
  def to_time
    Time.parse(self.strftime("%c -0800"), self)
  end
end
