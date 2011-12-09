# coding: utf-8

class RecordController < ApplicationController

  def find
    @books = Book.find([2, 5, 10])
    render 'hello/list'
  end

  def dynamic_find
    @books = Book.find_all_by_publish('技術評論社')
    render 'hello/list'
  end

  def dynamic_find2
    @book = Book.find_by_publish_and_price('技術評論社', 2604)
    render 'books/show'
  end

  def where
    @books = Book.where(:publish => '技術評論社')
    # @books = Book.where(:publish => '技術評論社', :price => 2604)
    # @books = Book.where(:published => '2010-07-01'..'2010-12-31')
    # @books = Book.where(:publish => ['技術評論社', '翔泳社'])
    render 'hello/list'
  end

  def ph1
    @books = Book.where('publish = ? AND price >= ?',
      params[:publish], params[:price])
    # @books = Book.where('publish = :publish AND price >= :price',
    #   {:publish => params[:publish], :price => params[:price]})
    render 'hello/list'
  end

  def order
    @books = Book.where(:publish => '技術評論社').order('published DESC')
    # @books = Book.where(:publish => '技術評論社').order('published DESC, price ASC')
    render 'hello/list'
  end

  def select
    @books = Book.where('price >= 2000').select('title, price')
    render 'hello/list'
  end

  def select2
    @pubs = Book.select('DISTINCT publish').order('publish')
  end

  def offset
    @books = Book.order('published DESC').limit(3).offset(4)
    render 'hello/list'
  end

  def page
    page_size = 3
    page_num = params[:id] == nil ? 0 : params[:id].to_i - 1
    @books = Book.order('published DESC').
      limit(page_size).offset(page_size * page_num)
    render 'hello/list'
  end

  def last
    @book = Book.order('published DESC').limit(3).last
    render 'books/show'
  end

  def groupby
    @books = Book.select('publish, AVG(price) AS avg_price').group('publish')
  end

  def groupby2
    @books = Book.group('publish').average('price')
  end

  def havingby
    @books = Book.select('publish, AVG(price) AS avg_price').group('publish').
      having(['AVG(price) >= ?', 2500])
      # having(['AVG(price) >= :price', :price => 2500])
    render 'record/groupby'
  end

  def exists
     flag = Book.where(:publish => '新評論社').exists?
    # flag = Book.exists?(1)
    # flag = Book.exists?(['price > ?', 5000])
    # flag = Book.exists?({ :publish => '技術評論社' })
    # flag = Book.exists?
    render :text => "存在するか？ : #{flag}"
  end

  def scope
    @books = Book.gihyo.top10
    render 'hello/list'
  end

  def scope2
    @books = Book.whats_new('技術評論社')
    render 'hello/list'
  end

  def count
    cnt = Book.where(:publish => '技術評論社').count
    # cnt = Book.count(:conditions => "publish = '技術評論社'")
    render :text => "#{cnt}件です。"
  end

  def def_scope
    render :text => Review.all.inspect
  end

  def average
    price = Book.where(:publish => '技術評論社').average('price')
    render :text => "平均価格は#{price}円です。"
  end

	def literal_sql
	  @books = Book.find_by_sql(['SELECT publish, AVG(price) AS avg_price FROM "books" GROUP BY publish HAVING AVG(price) >= ?', 2500])
	  render 'record/groupby'
	end

  def protect_attr
    @user = User.new({
      :username => 'tyamada',
      :password => '12345',
      :email => 'tyamada@wings.msn.to',
      :dm => false,
      :roles => 'admin'
    })
    render :text => "ロール情報： #{@user.roles}"
  end

  def update_all
  cnt = Book.update_all('price = price * 1.05',
      ['publish = ?', '技術評論社'])
  render :text => "#{cnt}件のデータを更新しました。"
  end

  def update_all2
  cnt = Book.update_all('price = price * 0.8', nil,
      {:order => 'published ASC', :limit => 5})
  render :text => "#{cnt}件のデータを更新しました。"
  end

  def destroy_all
    books = Book.destroy_all(['publish <> ?', '技術評論社'])
    render :text => '削除完了'
  end

  def transact
      Book.transaction do
        b1 = Book.new({:isbn => '978-4-7741-4223-0', :title => 'Rubyポケットリファレンス',
          :price => 2000, :publish => '技術評論社', :published => '2011-01-01'})
        b1.save!
        raise '例外発生：処理はキャンセルされました。'
        b2 = Book.new({:isbn => '978-4-7741-4223-2', :title => 'Tomcatポケットリファレンス',
          :price => 2500, :publish => '技術評論社', :published => '2011-01-01'})
        b2.save!
      end
      render :text => 'トランザクションは成功しました。'
    rescue => e
      render :text => e.message
  end

  def join
  @books = Book.where(:isbn => '978-4-7741-4466-5').
    joins('INNER JOIN reviews ON books.id = reviews.book_id').
    select('reviews.*, books.*')
    render :text => @books[0].body
  end

  def belongs
    @review = Review.find(3)
  end

  def hasmany
    @book = Book.where(:isbn => '978-4-7741-4466-5').first
  end

  def hasone
    @user = User.where(:username => 'yyamada').first
  end

  def has_and_belongs
    @book = Book.where(:isbn => '978-4-7741-4466-5').first
  end

  def has_many_through
    @user = User.where(:username => 'isatou').first
  end

  # FunCommentモデルとの関連
  def hasmany2
    @author = Author.find(1)
  end


end
