require 'net/http'

class AjaxController < ApplicationController
  def upanel
    @time = Time.now.to_s
  end

  def search
    @books = Book.select('DISTINCT publish')
  end

  def result
    sleep(2)
    @books = Book.where(:publish => params[:publish])
  end

  def yahoo
    Net::HTTP.start('search.yahooapis.jp') do |http|
      response = http.get('/WebSearchService/V2/webSearch?appid=wings-project&query=' + ERB::Util.url_encode(params[:keywd]))
      @body = Hash.from_xml(response.body)
    end
  end
end
