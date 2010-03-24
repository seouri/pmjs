class MeshTree < ActiveRecord::Base
  belongs_to :subject
  belongs_to :parent, :class_name => "MeshTree", :foreign_key => :parent_id, :include => :subject

  def self.children(parent_id = 0)
    MeshTree.where(:parent_id => parent_id).order(:id).includes(:subject)
  end
  
  def children
    MeshTree.where(:parent_id => id).order(:id).includes(:subject)
  end
 
  def ancestors
    current = self
    ancestor = []
    while current.nil? == false do
      parent = current.parent
      current = parent
      ancestor.push(parent) unless parent.nil?
    end
    ancestor.reverse
  end
end
