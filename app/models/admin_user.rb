class AdminUser < ActiveRecord::Base
  attr_accessible :first_name,:last_name,:username
  
  #To configure a different table name if needed
  #set_table_name("admin_users")
  
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits
  
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  
  #STANDARD VALIDATION METHODS
  
  # validates_presence_of :first_name, :last_name,  :username, :email
  # validates_length_of :first_name, :maximum => 25
  # validates_length_of :last_name, :maximum => 50
  # validates_length_of :username, :maximum => 8..25
  # validates_length_of :email, :maximum => 100
  # validates_format_of :email, :with => EMAIL_REGEX
  # validates_confirmation_of :email
  # validates_uniqueness_of :username
  
  #SEXY VALIDATION METHODS
  
  validates :first_name, :presence => true, :length => {:maximum => 25}
  validates :last_name, :presence => true, :length => {:maximum => 50}
  validates :username, :presence => true, :uniqueness => true, :length => {:within => 8..25}
  validates :email, :presence => true, :length => { :maximum => 100 }, :format => EMAIL_REGEX, :confirmation => true
  
  
  scope :named, lambda {|first, last| where(:first_name => first, :last_name => last)}
    
  
end
