class Page < ActiveRecord::Base
  attr_accessible :subject_id,:name, :permalink, :position,:visible
    
  belongs_to :subject
  has_many :sections
  
  #went against Rails convention, therefore, the class_name must be set.
  has_and_belongs_to_many :editors, :class_name => "AdminUser"
  
end
  
