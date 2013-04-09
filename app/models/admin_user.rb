require 'digest/sha1'

class AdminUser < ActiveRecord::Base
  attr_accessible :first_name,:last_name,:username, :email
  # attr_protected :hash_password, :salt
  
  #To configure a different table name if needed
  #set_table_name("admin_users")
  
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits
  
  attr_accessor  :password
  
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
  
  validates_length_of :password, :within => 8..25, :on => :create
  
  before_save :create_hashed_password
  after_save :clear_password
  
  
  scope :named, lambda {|first, last| where(:first_name => first, :last_name => last)}
  
  def self.make_salt(username="")
    Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")
  end
  
  def self.hash_with_salt(password="",salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end
  
  # def self.hash(password="")
    # Digest::SHA1.hexdigest(password)
  # end
  
  def self.authenticate(username="", password="")    
    user = AdminUser.where({:name => username})
    
    if user == nil
      return false
    end
    
    
    
    
    
    
  end
  
  
  private
  
  def create_hashed_password
    # Whenever :password has a value hashing is needed
    unless password.blank?
      self.salt = AdminUser.make_salt(username) if salt.blank?
      self.hashed_password = AdminUser.hash_with_salt(password,salt)
    end
  end
  
  def clear_password
    self.password = nil
  end
  
    
  
end
