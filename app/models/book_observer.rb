class BookObserver < ActiveRecord::Observer
  def after_save(b)
    NoticeMailer.sendmail_book(b).deliver
  end
end
