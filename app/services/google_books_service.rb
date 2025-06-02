require 'net/http'
require 'json'

class GoogleBooksService
  BASE_URL = "https://www.googleapis.com/books/v1/volumes"

  def self.search(query)
    uri = URI("#{BASE_URL}?q=#{URI.encode_www_form_component(query)}")
    response = Net::HTTP.get_response(uri)
    
    return [] unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    data["items"]&.map { |item| parse_book_data(item) } || []
  end

  def self.find_by_isbn(isbn)
    uri = URI("#{BASE_URL}?q=isbn:#{isbn}")
    response = Net::HTTP.get_response(uri)
    
    return nil unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    return nil unless data["items"]&.first

    parse_book_data(data["items"].first)
  end

  def self.find_preview_url(isbn)
    uri = URI("#{BASE_URL}?q=isbn:#{isbn}")
    response = Net::HTTP.get_response(uri)
    
    return nil unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    return nil unless data["items"]&.first

    volume_info = data["items"].first["volumeInfo"]
    preview_link = volume_info["previewLink"]
    
    if preview_link && volume_info["readingModes"]["text"]
      "#{preview_link}&printsec=frontcover&output=embed"
    else
      nil
    end
  end

  private

  def self.parse_book_data(item)
    volume_info = item["volumeInfo"]
    {
      title: volume_info["title"],
      author: volume_info["authors"]&.join(", "),
      description: volume_info["description"],
      published_date: volume_info["publishedDate"],
      isbn: volume_info["industryIdentifiers"]&.find { |id| id["type"] == "ISBN_13" }&.dig("identifier"),
      page_count: volume_info["pageCount"],
      categories: volume_info["categories"],
      image_url: volume_info.dig("imageLinks", "thumbnail")&.gsub("http:", "https:"),
      preview_link: volume_info["previewLink"]
    }
  end
end 