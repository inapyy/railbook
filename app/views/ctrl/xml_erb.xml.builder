xml.book(:isbn => @book.isbn) do
  xml.title(@book.title)
  xml.price(@book.price)
  xml.publish(@book.publish)
end