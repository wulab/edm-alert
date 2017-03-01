module HtmlHelper
  def truncate_url(raw_url)
    if raw_url.include? "://"
      "http://" + raw_url.split("/")[2]
    else
      "http://" + raw_url.split("/")[0]
    end
  end

  def date_format(date)
    date.strftime("วันที่: %-d/%-m/%y เวลา %H:%M น.")
  end
end
