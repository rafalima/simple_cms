class Page < ActiveRecord::Base
  attr_accessible :name, :permalink, :position
    
  belongs_to :subject
  has_many :sections
  
  #went against Rails convention, therefore, the class_name must be set.
  has_and_belongs_to_many :editors, :class_name => "AdminUser"
  
end
  
