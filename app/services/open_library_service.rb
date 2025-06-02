require 'net/http'
require 'json'

class OpenLibraryService
  BASE_URL = "https://openlibrary.org"

  def self.search_books(query)
    uri = URI("#{BASE_URL}/search.json")
    uri.query = URI.encode_www_form(q: query, limit: 25)

    response = Net::HTTP.get_response(uri)
    return [] unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    data["docs"].map { |book| parse_book_data(book) }
  end

  def self.get_book_by_isbn(isbn)
    uri = URI("#{BASE_URL}/api/books")
    uri.query = URI.encode_www_form(bibkeys: "ISBN:#{isbn}", format: 'json', jscmd: 'details')

    response = Net::HTTP.get_response(uri)
    return nil unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    book_data = data["ISBN:#{isbn}"]
    return nil unless book_data

    {
      title: book_data['details']['title'],
      author: book_data['details']['authors']&.first&.dig('name'),
      isbn: isbn,
      description: book_data['details']['description'],
      published_date: book_data['details']['publish_date'],
      page_count: book_data['details']['number_of_pages'],
      cover_url: "https://covers.openlibrary.org/b/isbn/#{isbn}-L.jpg",
      read_url: "https://archive.org/details/isbn_#{isbn}"
    }
  end

  def self.get_read_url(isbn)
    "https://archive.org/details/isbn_#{isbn}"
  end

  private

  def self.parse_book_data(book)
    {
      title: book['title'],
      author: book['author_name']&.first,
      isbn: book['isbn']&.first,
      published_date: book['first_publish_year'],
      description: book['description'],
      cover_url: book['isbn'] ? "https://covers.openlibrary.org/b/isbn/#{book['isbn'].first}-L.jpg" : nil,
      read_url: book['isbn'] ? "https://archive.org/details/isbn_#{book['isbn'].first}" : nil
    }
  end
end 