# Library Lending Application

A Ruby on Rails 8 application for managing book borrowing and returns with user authentication.

## Features

- User registration and login (with Rails 8 authentication)
- Book catalog with availability status
- Borrowing system with 2-week due dates
- User profile showing borrowed books
- Book management:
  - Title, author, ISBN validation
  - Unique ISBN enforcement
- Test coverage for models, controllers, and views

## Technologies

- Ruby 3.x
- Rails 8
- SQLite (development)
- ERB templates
- Rails Testing Framework

## Prerequisites

- Ruby 3.2.2 or newer
- Rails 8.0.0 or newer
- SQLite3
- Node.js (for asset pipeline)
- Yarn

## Installation

1. Clone the repository
2. Install dependencies
3. Set up the database
4. Add background image (optional)

## Running the Application

Start the Rails server and visit http://localhost:3000 in your browser.

## Testing

Run all tests or specific test types (models, controllers, system).

## Deployment

1. Create Heroku app
2. Set up production database
3. Deploy and migrate database

## Project Structure

Key components:
- `app/models/`: User, Book, Borrowing models
- `app/controllers/`: Sessions, Users, Books controllers
- `test/`: Test files
- `config/routes.rb`: Application routes
- `db/migrate/`: Database migrations

## Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request

## License

MIT License. See [LICENSE](LICENSE) for details.