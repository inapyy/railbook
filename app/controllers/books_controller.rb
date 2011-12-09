# coding: utf-8

class BooksController < ApplicationController
  # layout 'product'

  # caches_action :index
  # caches_action :index, :show
  # cache_sweeper :book_sweeper
  # GET /books
  # GET /books.xml
  def index
    @books = Book.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books }
      format.atom
    end
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
  # render :text => params[:book].inspect
  # return
    @book = Book.new(params[:book])

   # @book = Book.new
   # @book.isbn      = params[:book][:isbn]
   # @book.title     = params[:book][:title]
   # @book.price     = params[:book][:price]
   # @book.publish   = params[:book][:publish]
   # @book.published = params[:book][:published]
   # @book.cd        = params[:book][:cd]

    respond_to do |format|
      if @book.save
        # expire_action :action => 'index'
        format.html { redirect_to(@book, :notice => 'Book was successfully created.') }
        # format.html {
        # flash[:msg] = 'Book was successfully created.'
        # redirect_to @book
        # }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    # sleep 3
    @book = Book.find(params[:id])

   # @book = Book.find(params[:id])
   # @book.isbn      = params[:book][:isbn]
   # @book.title     = params[:book][:title]
   # @book.price     = params[:book][:price]
   # @book.publish   = params[:book][:publish]
   # @book.published = params[:book][:published]
   # @book.cd        = params[:book][:cd]

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to(@book, :notice => 'Book was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

   # Book.destroy(params[:id])

   # Book.delete(params[:id])

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :ok }
    end
  end
end
