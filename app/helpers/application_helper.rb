module ApplicationHelper
  def decades(item)
    li = []
    item.start_year.upto(item.end_year) do |year|
      li.push(content_tag(:li, link_to(year, :year => year))) unless year % 10
    end
    content_tag(:ul, li.join("\n"), :class => "years")
  end

  def top_items(object)
    tr = []
    for item in object.top(@year) do
      td = []
      td.push(content_tag(:td, object.class == Subject ? link_to(item.journal.abbr, item.journal) : link_to(item.subject.term, item.subject)))
      td.push(content_tag(:td, number_with_delimiter(item.direct_articles_count), :class => "direct number"))
      td.push(content_tag(:td, number_with_delimiter(item.descendant_articles_count), :class => "descendant number"))
      td.push(content_tag(:td, number_with_delimiter(item.articles_count), :class => "total number"))
      td.push(content_tag(:td, sparkline(item)))
      tr.push(content_tag(:tr, td.join("\n")))
    end
    content_tag(:table, tr.join("\n"))
  end

  def top_items2(object)
    li = []
    for item in object.top(@year) do
      l = object.class == Subject ? link_to(item.journal.abbr, item.journal) : link_to(item.subject.term, item.subject)
      l += " ("
      l += content_tag(:span, number_with_delimiter(item.direct_articles_count), :class => "direct")
      l += " + "
      l += content_tag(:span, number_with_delimiter(item.descendant_articles_count), :class => "descendant")
      l += " = "
      l += content_tag(:span, number_with_delimiter(item.articles_count), :class => "total")
      l += ")"
      l += sparkline(item)
      li.push(content_tag(:li, l))
    end
    content_tag(:ol, li.join("\n"))
  end

  def bar_graph(item)
    start_year = item.start_year
    end_year = item.end_year
    labels = (start_year .. end_year).to_a
    data = item.articles
    y_max = number_with_delimiter(data.max)
    title = item.to_s + " (" + pluralize(number_with_delimiter(item.articles_count), "article") + ")"
    width = labels.size * 7 + y_max.to_s.size * 6 + 10 + 10
    width = title.size * 5 > width ? title.size * 5 : width
    labels = labels.map {|year| year.to_i % 5 == 0 ? year : ""}
    vgrids = labels.select {|y| y % 10 == 0}.map {|y| "V,DDDDDD,0,#{labels.index(y)},1,-1"}.join("|")
    image_tag(Gchart.bar(:size => "#{width}x80",:data => data, :axis_labels => [labels, [0, y_max]], :axis_with_labels => 'x,y', :bar_width_and_spacing => {:width => 5, :spacing => 2}, :title => title, :title_size => '11', :bar_colors => "ffcc00,cccccc", :custom => "chm=#{vgrids}"))
  end

  def bar_graph2(item)
    start_year = item.start_year
    end_year = item.end_year
    labels = (start_year .. end_year).to_a
    data1 = item.direct_articles
    data2 = item.descendant_articles
    data = [data1]
    data.push(data2) if data2.max > 0
    y_max = number_with_delimiter(item.articles.max)
    title = item.to_s + " (" + pluralize(number_with_delimiter(item.articles_count), "article") + ")"
    width = labels.size * 7 + y_max.to_s.size * 6 + 10 + 10
    width = title.size * 5 > width ? title.size * 5 : width
    labels = labels.map {|year| year.to_i % 5 == 0 ? year : ""}
    vgrids = labels.select {|y| y % 10 == 0}.map {|y| "V,DDDDDD,0,#{labels.index(y)},1,-1"}.join("|")
    image_tag(Gchart.bar(:size => "#{width}x80",:data => data, :axis_labels => [labels, [0, y_max]], :axis_with_labels => 'x,y', :bar_width_and_spacing => {:width => 5, :spacing => 2}, :title => title, :title_size => '11', :bar_colors => "ffcc00,cccccc", :custom => "chm=#{vgrids}"))
  end

  def sparkline(item)
    data = item.articles
    width = data.size * 1 + 6 * 4 * 2 + 2
    height = 10
    size = "#{width}x#{height}"
    labels = (item.start_year .. item.end_year).to_a
    vgrids = labels.select {|y| y % 10 == 0}.map {|y| "V,DDDDDD,0,#{labels.index(y)},1,-1"}.join("|")
    source = Gchart.sparkline(:data => data, :size => size, :custom => "chm=B,FFEE99,0,0,0|#{vgrids}&chxtc=0,0|1,0", :axis_labels => [["",item.start_year,""], ["",item.end_year,""]], :axis_with_labels => 'y,r')
    image_tag(source)
  end

  def pagination
    prev_offset = @offset - @per_page
    prev_offset = nil if prev_offset <= 0
    next_offset = @offset + @per_page
    pagination = []
    pagination.push(link_to("Beginning")) if @offset > 0
    pagination.push(link_to("Previous #{@per_page}", :o => prev_offset)) if @offset > @per_page
    pagination.push(link_to("Next #{@per_page}", :o => next_offset))
    content_tag(:div, pagination.join("\n"))
  end
end
