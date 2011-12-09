class User < ActiveRecord::Base
  has_one :author
  has_many :reviews
  has_many :books, :through => :reviews

  attr_protected :roles
  # attr_accessible :username, :password, :email, :dm

  validates :agreement, :acceptance => { :accept => 'yes' }
  # validates :agreement, :acceptance => { :on => :create }
   validates :email, :confirmation => true
  # validates :email, :presence => { :unless => 'dm.blank?' }
  # validates :email, :presence => { :if => '!dm.blank?' } 

  # validates :email, :presence => { :unless => :sendmail? }

  # def sendmail?
  #   dm.blank?
  # end

  # validates :email,
  #   :presence => { :unless => Proc.new { |u| u.dm.blank? } }

  def self.authenticate(username, password)
    where(:username => username,
      :password => Digest::SHA1.hexdigest(password)).first
  end
end
