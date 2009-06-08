require 'calendar'

class Date
  include Calendar
	attr_writer :week_day_start

  alias_method :'weekless_>>', :'>>'
  def >> int
    new_day = send(:'weekless_>>', int)
    new_day.week_day_start = self.week_day_start
    new_day
  end

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
    send(method, limit, step) {|d| 
      d.week_day_start = self.week_day_start
      yield d 
    }
  end
end

class DateTime < Date
  include Calendar
  def to_time
    Time.parse(self.strftime("%c -0800"), self)
  end
end
