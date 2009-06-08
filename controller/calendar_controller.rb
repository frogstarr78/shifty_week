class Backend::CalendarController < Backend::BackendController
  append_before_filter :load_prefs
  append_before_filter :start_at_today, :except => [:month]
  helper_method :current_date_variable, :follow_time, :follow_day, :wd_start, :military_time

	def index
		month
		render :action => 'month'
	end

	def day
	end

	def week
	end

	def month
    @month = DateTime.new(params[:year].to_i, params[:month].to_i) 
    @month.week_day_start = @preferences.week_day_start
	end

	def year
		@colspan = 3
    @year = DateTime.new(params[:year].to_i) 
    @year.week_day_start = @preferences.week_day_start
	end

	def current_date_variable
    self.instance_variable_get("@#{self.action_name}")
	end
	private

    def load_prefs
      @preferences = Preference.find_by_admin_user_id(20)
      @today = DateTime.now
      @today.week_day_start = @preferences.week_day_start
    end

    def start_at_today
      case action_name
        when 'day'
          @day = get_date(params)
        when 'week'
          @week = get_date(params)
          @week = @week-(@week.wday)
        when 'year'
          @year = get_date(params)
          @year = DateTime.new(@year.year, 1, 1, @year.hour, @year.min)
      end
      @colspan = 1
    end

  def follow_time
    return false if %w(month year).include?(action_name)
    @follow_time = session[:follow_time]
    if params.has_key?(:follow_time)
      @follow_time = session[:follow_time] = params[:follow_time] == 'true'
    end
    @follow_time
  end

  def follow_day
    return false if %w(day year).include?(action_name)
    @follow_day = false
  end

  def military_time
    @military_time = session[:military_time]
    if params.has_key?(:military_time)
      @military_time = session[:military_time] = params[:military_time] == 'true'
    end
    @military_time
  end

	def get_date(params)
		now = DateTime.now
    if (year = params[:year].to_i) > 0
      if (month = params[:month].to_i) > 0
        if (day = params[:day].to_i) > 0
          now = DateTime.new(year, month, day)
        else
          now = DateTime.new(year, month)
        end
      else
        now = DateTime.new(year)
      end
    end

    if date = params[:date]
      now = DateTime.new(*(date.split(/(\d{4})-(\d{2})-(\d{2})/)[1, 3].map(&:to_i)))
    end
    now
	end

end
