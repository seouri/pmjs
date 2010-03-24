module SubjectsHelper
  def treelist(subject)
    list = []
    subject.mesh_trees.each do |tree|
      children = tree.children.map {|c| c.subject ? content_tag(:li, link_to(c.subject.term, c.subject)) : ""}
      current = content_tag(:ul, content_tag(:li, content_tag(:strong, subject.term)) + content_tag(:ul, children.join("\n")))
      ancestors = tree.ancestors.reverse.inject(current) do |html, a|
        content_tag(:ul, content_tag(:li, (a.subject ? link_to(a.subject.term, a.subject) : a.subject_id.to_s) + "\n" + html), :class => "treelist")
      end
      list.push(ancestors)
    end
    list.join("\n")
  end
end
