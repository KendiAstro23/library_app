namespace :books do
  desc "Seed books from Open Library API"
  task populate: :environment do
    require 'net/http'
    require 'json'

    # Open Library API endpoint
    url = URI("https://openlibrary.org/subjects/programming.json?limit=50")
    response = Net::HTTP.get_response(url)

    if response.is_a?(Net::HTTPSuccess)
      books_data = JSON.parse(response.body)['works']

      books_data.each_with_index do |book_data, index|
        title = book_data['title']
        author = book_data['authors']&.map { |a| a['name'] }&.join(', ')
        cover_id = book_data['cover_id']
        cover_url = cover_id ? "https://covers.openlibrary.org/b/id/#{cover_id}-L.jpg" : ActionController::Base.helpers.asset_path("book#{(index % 9) + 1}.jpg")
        isbn = book_data['key']

        next if Book.exists?(isbn: isbn) # Avoid duplicates

        Book.create!(
          title: title,
          author: author,
          isbn: isbn,
          image_url: cover_url,
          borrowed: false
        )
      end

      puts "Seeded #{Book.count} books!"
    else
      puts "Failed to fetch books. HTTP Status: #{response.code}"
    end
  end
end
