class ApplicationController < ActionController::Base
  protect_from_forgery
  # before_filter :check_logined
  # before_filter :detect_locale
  # rescue_from ActiveRecord::RecordNotFound, :with => :id_invalid


  private
  def check_logined
    if session[:usr] then
      begin
        @usr = User.find(session[:usr])
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end
    unless @usr
      flash[:referer] = request.fullpath
      redirect_to :controller => 'login', :action => 'index' 
    end
  end

  def id_invalid(e)
    render 'shared/record_not_found', :status => 404
  end

  # def default_url_options(options = {})
  #    { :locale => I18n.locale }
  # end

  private
  def detect_locale
    I18n.locale = request.headers['Accept-Language'].scan(/^[a-z]{2}/).first
    # I18n.locale = params[:locale]
  end

end
