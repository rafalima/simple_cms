#require 'lib/position_mover'
class Subject < ActiveRecord::Base
  #include PositionMover

  attr_accessible :name, :position, :visible,:created_at,:updated_at
  
  #has_one :page
  has_many :pages
  
  
  # validates_presence_of :name
  # validates_length_of :name, :maximum => 255
  
  validates :name, :presence => true, :length => { :maximum => 10, :message => "name too shorty"}
  
  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
  scope :sorted, order('subjects.position ASC')
  scope :search, lambda {|query| where(["name LIKE ?","%#{query}%"])}
  
 
end
