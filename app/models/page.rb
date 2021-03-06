require 'position_mover'
class Page < ActiveRecord::Base
  attr_accessible :subject_id,:name, :permalink, :position,:visible
    
  include PositionMover

  belongs_to :subject
  has_many :sections
  
  validates_presence_of :name, :permalink
  validates_length_of :name, :maximum => 255
  validates_length_of :permalink, :within => 3...255
  #use presence with length to disallow spaces
  validates_uniqueness_of :permalink
  
  #went against Rails convention, therefore, the class_name must be set.
  has_and_belongs_to_many :editors, :class_name => "AdminUser"

  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
  scope :sorted, order('pages.position ASC')

  
  private

  def position_scope
    "pages.subject_id = #{subject_id.to_i}"
  end

  
end
  
