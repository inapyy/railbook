#coding: utf-8

class NoticeMailer < ActionMailer::Base 
  # layout 'mail'

  default :from => 'webmaster@wings.msn.to',
          :cc => 'CQW15204@nifty.com'

  def sendmail_confirm(user) 
    @user = user
    mail(:to => user.email, 
         :subject => 'ユーザ登録ありがとうございました')
    #      :subject => 'ユーザ登録ありがとうございました') do |format|
    # format.html
    # format.text
    # end

    #      :subject => 'ユーザ登録ありがとうございました') do |format|
    # format.text { render :inline => 'HTML対応クライアントで受信ください' }
    # format.text
    # end
  end

  def sendmail_book(book) 
    @book = book
    mail(:to => 'nami@wings.msn.to', 
         :subject => '書籍情報を更新しました')
  end
end