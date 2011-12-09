# coding: utf-8

class Book < ActiveRecord::Base
  scope :gihyo, where(:publish => '技術評論社')
  scope :newer, order('published DESC')
  scope :top10, newer.limit(10)
  scope :whats_new, lambda {
  |pub| where(:publish => pub).order('published DESC').limit(5)
}

  has_many :reviews
  has_and_belongs_to_many :authors
  has_many :users, :through => :reviews

  # validates :isbn,
  #   :presence => { :message => 'は必須です'},
  #   :uniqueness => { :allow_blank => true, :message => '%{value}は一意でなければなりません' },
  #   :length => { :is => 17 , :allow_blank => true, :message => '%{value}は%{count}桁でなければなりません' },
  #   :format => { :with => /^[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}$/, :allow_blank => true, :message => '%{value}は正しい形式ではありません' }

  validates :isbn,
    :presence => true,
    :uniqueness => true,
    # :uniqueness => { :allow_blank => true },
    :length => { :is => 17 },
    # :length => { :is => 17 , :allow_blank => true },
    :format => { :with => /^[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}$/ }
    # :format => { :with => /^[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}$/, :allow_blank => true }
    # :isbn => { :allow_old => true }

  validates :title,
    :presence => true,
    :length => { :minimum => 1, :maximum => 100 }
  validates :price,
    :numericality => { :only_integer => true, :less_than => 10000 }
  validates :publish,
    :inclusion => { :in => ['技術評論社', '翔泳社', '秀和システム', '日経BP社', 'インプレスジャパン'] }
  # validates :title, :uniqueness => { :scope => :publish }

  # validate :isbn_valid?

  # private
  # def isbn_valid?
  #   errors.add(:isbn, 'は正しい形式ではありません。') unless isbn =~ /^[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}$/
  # end

  after_destroy :history_book
  #after_destroy :history_book, :unless => Proc.new { |b| b.publish == "翔泳社" }


   private
   def history_book
    logger.info('deleted: ' + self.inspect)
   end

  # after_destroy do |b|
  #   logger.info('deleted: ' + b.inspect)
  # end

  # after_destroy BookCallbacks.new
end
