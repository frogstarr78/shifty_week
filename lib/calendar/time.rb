require 'calendar'

class Time
  HOUR = 60*60
  DAY = HOUR*24
  DAYS = lambda {|int| DAY*int }

  include Calendar
  def to_billing_week_start
    (self.to_datetime-offset_from_billing_week_start).beginning_of_day
  end
  def to_billing_week_end
    ((self.to_datetime-offset_from_billing_week_start)+6).end_of_day
  end

  def >> int
#    r = self
#    (int < 0 ? int*-1 : int).times do 
#      r = r.send( (int < 0 ? "-" : "+"), (DAYS(r.days_in_month)) )
#    end
#    r += HOUR if r.dst? 
#    r
    DateTime.parse(self.strftime(WORKER_FORMAT)) >> int
  end

  def << int
#    r = self
#    (int < 0 ? int*-1 : int).times do 
#      r = r.send( (int < 0 ? "+" : "-"), (DAYS(r.days_in_month)) )
#    end
#    r += HOUR if r.dst? 
#    r
    DateTime.parse(self.strftime(WORKER_FORMAT)) << int
  end
end
