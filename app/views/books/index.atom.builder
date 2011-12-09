atom_feed do |feed|
  feed.title('最新書籍情報')
  feed.updated(@books.last.created_at)

  @books.each do |book|
    feed.entry(book,
      :url => "http://www.wings.msn.to/index.php/-/A-03/#{book.isbn}/",
      :published => book.published,
      :updated => book.published) do |entry|
      entry.title(book.title)
      entry.content("#{book.publish}刊 #{book.price}円")
      entry.author do |author|
        author.name(book.authors[0].name)
      end
    end
  end
end