module DateTimeHelpers
  def render_date_header(d)
    d = d.in_time_zone
    "<div class='date'>
<span class='day'>#{d.day}</span>
<span class='month'>#{I18n.t('date.abbr_month_names')[d.month]}</span>
#{"<span class='year'>#{d.year}</span>" if d.year != Date.today.year}
</div>".html_safe
  end

  def render_date(d)
    d    = d.in_time_zone
    year = d.year == Date.today.year ? '' : "<span class='year'> #{d.year} </span>"
    "<span class='date'> <span class='day'>#{d.day}</span> <span class='month'>#{h I18n.t('date.abbr_month_names')[d.month]}</span> #{year} </span>"
  end

  def render_time(d, midnight_as_24 = false)
    d = d.in_time_zone
    t = d.to_s(:time)
    # Hack for show midnight as 00:00
    t = '24:00' if is_midnight?(d) && midnight_as_24
    "<span class='time'> #{h t}</span>"
  end

  def render_datetime(d, midnight_as_24 = false)
    d = d.in_time_zone
    if is_midnight?(d) && midnight_as_24
      date = render_date(d - 1)
    else
      date = render_date(d)
    end
    [date, render_time(d, midnight_as_24)] * ' '
  end

  private
  def is_midnight?(d)
    d.to_s(:time) == '00:00'
  end
end
