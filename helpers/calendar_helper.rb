module Backend::CalendarHelper
  include Backend
	def select_weekday(wday=0, options = {})
		names = options[:show_abbr] ? Date::ABBR_DAYNAMES : Date::DAYNAMES
		val = names[wday]
		select_html('wday', options_for_select(names, val), options)
	end

	def today_link()
		calendar_link("Today", @today, controller.action_name)
	end

	def _calendar_link(content, date=nil, action_name=nil)
		action_name ||= controller.action_name
#		date ||= DateTime.now
    options = { :controller => 'calendar', :action => action_name }
    options.update( :date => date.to_s(:db) ) unless date.nil?
    link_to content, options
	end

	def calendar_link(content, date=nil)
    url = case controller.action_name
      when 'day'
        day_path(date.year, date.month, date.day)
      when 'week'
        week_path(date.year, date.week)
      when 'month'
        month_path(date.year, date.month)
      when 'quarter'
        quarter_path(date.year, date.quarter)
      when 'year'
        year_path(date.year)
    end
    link_to content, url
	end

	def render_month(options=nil)
    options ||= { :locals => {} }
    options[:locals][:show_hours] = (options.delete(:show_hours) == true)
		if options.has_key? :show_near_month_wdays
			options[:locals][:show_near_month_wdays] = options[:show_near_month_wdays]
			if options[:show_near_month_wdays]
				options[:show_hours] = false
			end
			options.delete :show_near_month_wdays
		else
			options[:locals][:show_near_month_wdays] = true
		end
		render options.update :partial => 'month'
	end

	def label_checkbox(content, options={}, actions=[])
		id = options[:id] if options.has_key? :id
		accesskey = options[:accesskey] if options.has_key? :accesskey

		(r = Regexp.new("([#{accesskey.upcase}#{accesskey.downcase}])")).match(content)
		content[r] = "<u>#{Regexp.last_match(0)}</u>"
    l = content_tag(:label, content, :for => id, :accesskey => accesskey)

    options = {
      :id        => id, 
      :type      => 'checkbox',
      :name      => id, 
      :accesskey => accesskey, 
      :onclick   => "jsReload(/#{id}=(true|false)/, '#{id}', this.checked)",
    }
    options[:disabled] = "disabled" unless actions.index(controller.action_name)
    options[:checked]  = "checked" if controller.instance_variable_get("@#{id}") 
    i = content_tag(:input, '', options)
		l.to_s + i.to_s
	end

  def format_for_day_display wday, current_date_variable
      if wday.month != current_date_variable.month
        if wday.year != current_date_variable.year
          format = "%m/%d/%Y"
        else
          format = "%m/%d"
        end
      else
        format = "%d"
      end
  end
end
