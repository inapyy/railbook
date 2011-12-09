class BookSweeper < ActionController::Caching::Sweeper
  observe Book

  def after_create(book)
    gc_cache(book)
  end

  def after_update(book)
    gc_cache(book)
  end

  def after_destroy(book)
    gc_cache(book)
  end

  private
  def gc_cache(book)
    expire_action :controller => 'books', :action => 'index'
    expire_action :controller => 'books', :action => 'show', :id => book.id
  end
end 