# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Book.create([
    { title: "Fourth Wing", author: "Rebecca Yarros", isbn: "1234567890" },
    {title: "Outliers", author: "Malcolm Gladwell", isbn: "0987654321" },
    {title: "The 48 Laws of Power", author: "Robert Greene", isbn: "0987654321" },
    {title: "Mastery", author: "Robert Greene", isbn: "1112223334" },
    {title: "The Lies of Locke Lamora", author: "Scott Lynch", isbn: "0987654321" },
    {title: "The Name of The Wind", author: "Patrick Rothfuss", isbn: "0987654321" },
    {title: "Six of Crows", author: "Leigh Bardugo", isbn: "9998887776" },
    {title: "The Will of The Many", author: "James Islington", isbn: "6665554443" },
    {title: "If Tomorrow Comes", author: "Sidney Sheldon", isbn: "0987654321" }
])