module SubjectsHelper
  def treelist(subject)
    list = [content_tag(:strong, link_to_unless_current("MeSH", subjects_path))]
    if subject.nil?
      children = MeshTree.children.map {|c| c.subject ? content_tag(:li, link_to(c.subject, c.subject)) : ""}
      list.push(content_tag(:ul, children.join("\n"), :class => "treelist"))
    else
      subject.mesh_trees.each do |tree|
        children = tree.children.map {|c| c.subject ? content_tag(:li, link_to(c.subject.term, c.subject) + sparkline(c.subject)) : ""}
        current = content_tag(:ul, content_tag(:li, content_tag(:strong, subject.term)) + content_tag(:ul, children.join("\n")), :class => "treelist")
        ancestors = tree.ancestors.reverse.inject(current) do |html, a|
          content_tag(:ul, content_tag(:li, (a.subject ? link_to(a.subject.term, a.subject)  + sparkline(a.subject) : a.subject_id.to_s) + "\n" + html), :class => "treelist")
        end
        list.push(ancestors)
      end
    end
    list.join("\n")
  end
end
