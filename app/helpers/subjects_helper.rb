module SubjectsHelper
  def treelist(subject)
    list = []
    if subject.nil?
      list.push(MeshTree.children)
    else
      subject.mesh_trees.each do |tree|
        list.push(tree)
        list.push(tree.children)
        list.push(tree.ancestors)
      end
    end
    list = list.flatten.uniq.reject {|l| l.subject.nil?}.sort_by(&:id)
    tree = []
    highlight_id = subject.nil? ? nil : subject.id
    treelist = content_tag(:div, treeview(0, list, tree, highlight_id).join(""), :id => "treelist")
    content_tag(:div, link_to_unless_current("MeSH", subjects_path) + treelist, :id => "subject_tree")
  end

  def treeview(current_id, list, tree, highlight_id)
    if current_id > 0
      current = list.select {|l| l.id == current_id}[0].subject
      tree.push('<li class="expanded">')
      tree.push(content_tag(:span, link_to_unless(current.id == highlight_id, current.term, current) + sparkline(current)))
    end
    children = list.select {|l| l.parent_id == current_id}
    if children.size > 0
      tree.push('<ul>')
      children.each do |c|
        treeview(c.id, list, tree, highlight_id)
      end
      tree.push('</ul>')
    end
    if current_id > 0
      tree.push('</li>')
    end
    tree
  end
end
