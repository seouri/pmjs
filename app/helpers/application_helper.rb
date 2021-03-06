module ApplicationHelper
  def decades(item)
    li = []
    li.push(content_tag(:li, link_to_unless(@decade == 0, "All", :decade => nil)))
    start_decade = (item.start_year / 10).round * 10
    end_decade = (item.end_year / 10).round * 10
    start_decade.step(end_decade, 10) do |decade|
      li.push(content_tag(:li, link_to_unless(decade == @decade, decade.to_s + "s", :decade => decade)))
    end
    content_tag(:ul, li.join("\n").html_safe, :class => "decades")
  end

  def items_table(items, offset = nil)
    return "" if items[0].nil?
    tr = []
    td = []
    td.push(content_tag(:th, "No")) unless offset.nil?
    if @journal.present? and items[0].class == JournalSubject
      td.push(content_tag(:th, "Subject"))
    elsif @subject.present? and items[0].class == JournalSubject
      td.push(content_tag(:th, "Journal"))
    else
      td.push(content_tag(:th, items[0].to_l.class.to_s))
    end
    td.push(content_tag(:th, "Direct")) if items[0].respond_to?(:direct_articles_count)
    td.push(content_tag(:th, "Descendant")) if items[0].respond_to?(:descendant_articles_count)
    td.push(content_tag(:th, "Total"))
    td.push(content_tag(:th, "")) if items[0].start_year > 0
    tr.push(content_tag(:tr, td.join("\n").html_safe))
    for item in items do
      td = []
      td.push(content_tag(:td, number_with_delimiter(offset + items.index(item) + 1), :class => "number")) unless offset.nil?
      if @journal.present? and item.class == JournalSubject
        td.push(content_tag(:td, link_to(item.subject.to_s, item.subject)))
      elsif @subject.present? and item.class == JournalSubject
        td.push(content_tag(:td, link_to(item.journal.to_s, item.journal)))
      else
        td.push(content_tag(:td, link_to(item.to_s, item.to_l)))
      end
      td.push(content_tag(:td, number_with_delimiter(item.direct_articles_count), :class => "direct number")) if item.respond_to?(:direct_articles_count)
      td.push(content_tag(:td, number_with_delimiter(item.descendant_articles_count), :class => "descendant number")) if item.respond_to?(:descendant_articles_count)
      td.push(content_tag(:td, number_with_delimiter(item.articles_count), :class => "total number"))
      td.push(content_tag(:td, sparkline(item).html_safe)) if item.start_year > 0
      tr.push(content_tag(:tr, td.join("\n").html_safe))
    end
    content_tag(:table, tr.join("\n").html_safe)
  end

  def bar_graph(item)
    start_year = item.start_year
    end_year = item.end_year
    labels = (start_year .. end_year).to_a
    data1 = item.direct_articles if item.respond_to?(:direct_articles)
    data2 = item.descendant_articles if item.respond_to?(:descendant_articles)
    data = []
    data.push(data1) if data1.present?
    data.push(data2) if data2.present? and data2.max > 0
    data = item.articles if data.size == 0
    y_max = number_with_delimiter(item.articles.max)
    title = item.to_s + " (" + pluralize(number_with_delimiter(item.articles_count), "article") + ")"
    width = labels.size * 7 + y_max.to_s.size * 6 + 10 + 10
    width = title.size * 5 > width ? title.size * 5 : width
    chm = []
    if @decade > 0
      decade_range = labels.select {|y| (y / 10).round * 10 == @decade}
      vrange = "v,AA0000,0,#{labels.index(decade_range[0])}:#{labels.index(decade_range[-1])}:1,5"
      chm.push(vrange)
      if data.size == 2
        vrange = "v,33333333,1,#{labels.index(decade_range[0])}:#{labels.index(decade_range[-1])}:1,5"
        chm.push(vrange)
      end
    end
    labels = labels.map {|year| year.to_i % 5 == 0 ? year : ""}
    vgrids = labels.select {|y| y % 10 == 0}.map {|y| "V,DDDDDD,0,#{labels.index(y)},1,-1"}.join("|")
    chm.push(vgrids)
    image_tag(Gchart.bar(:size => "#{width}x80",:data => data, :axis_labels => [labels, [0, y_max]], :axis_with_labels => 'x,y', :bar_width_and_spacing => {:width => 5, :spacing => 2}, :title => title, :title_size => '11', :bar_colors => "ffcc00,cccccc", :custom => "chm=#{chm.join("|")}"))
  end

  def sparkline(item)
    data = item.articles
    width = data.size * 1 + 6 * 4 * 2 + 2
    height = 10
    size = "#{width}x#{height}"
    labels = (item.start_year .. item.end_year).to_a
    chm = ["B,FFEE99,0,0,0"]
    if @decade > 0
      decade_range = labels.select {|y| (y / 10).round * 10 == @decade}
      vrange = "B,EECC33,0,#{labels.index(decade_range[0])}:#{labels.index(decade_range[-1])}:1,5"
      chm.push(vrange)
    end
    vgrids = labels.select {|y| y % 10 == 0}.map {|y| "V,DDDDDD,0,#{labels.index(y)},1,-1"}.join("|")
    chm.push(vgrids)
    source = Gchart.sparkline(:data => data, :size => size, :custom => "chm=#{chm.join("|")}&chxtc=0,0|1,0", :axis_labels => [["",item.start_year,""], ["",item.end_year,""]], :axis_with_labels => 'y,r')
    image_tag(source).html_safe
  end

  def pagination
    prev_offset = @offset - @per_page
    prev_offset = nil if prev_offset <= 0
    next_offset = @offset + @per_page
    pagination = []
    pagination.push(link_to("Beginning", pagination_params(nil))) if @offset > 0
    pagination.push(link_to("Previous #{@per_page}", pagination_params(prev_offset))) if @offset > @per_page
    pagination.push(link_to("Next #{@per_page}", pagination_params(next_offset)))
    content_tag(:div, pagination.join("\n").html_safe, :class => "pagination")
  end
  
  def pagination_params(offset)
    p = { :o => offset }
    p[:q] = params[:q] if params[:q].present?
    p[:decade] = params[:decade] if @decade > 0
    return p
  end
end
