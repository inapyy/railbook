#coding: utf-8

class ExtraController < ApplicationController
  # before_filter :auth, :only => ['p_cache', 'a_cache']
  caches_page :p_cache
  caches_action :a_cache
  caches_page :p_cache2, :if => Proc.new { |c| c.request.format.xml? }

  def sendmail
    user = User.find(6)
    @mail = NoticeMailer.sendmail_confirm(user).deliver
    render :text => 'メールが正しく送信できました。'
  end

  def p_cache
    render :text => Time.now
  end

  def p_cache2
    respond_to do |format|
      format.html { render :text => Time.now }
      format.xml  { render :text => '<data>' + Time.now.to_s + '</data>' }
    end
  end

  def a_cache
    render :text => Time.now
  end

  def f_logic1
    unless fragment_exist?(:controller => 'extra', :action => 'f_logic1')
      @books = Book.all
    end
  end

  def paging
    @books = Book.order('published DESC').
      paginate(:page => params[:page], :per_page => 5)
  end

  private
  def auth
    name = 'yyamada'
    passwd = '8cb2237d0679ca88db6464eac60da96345513964'
    authenticate_or_request_with_http_basic('Railsbook') do |n, p|
      n == name &&
        Digest::SHA1.hexdigest(p) == passwd
    end
  end
end
