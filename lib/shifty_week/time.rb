class Time
  include ShiftyWeek
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
