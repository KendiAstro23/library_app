require 'net/http'
require 'json'

class OverdriveService
  BASE_URL = "https://integration.api.overdrive.com/v2"
  OAUTH_URL = "https://oauth.overdrive.com/token"

  def self.configure
    @client_id = ENV['OVERDRIVE_CLIENT_ID']
    @client_secret = ENV['OVERDRIVE_CLIENT_SECRET']
    @library_id = ENV['OVERDRIVE_LIBRARY_ID']
  end

  def self.get_access_token
    uri = URI(OAUTH_URL)
    request = Net::HTTP::Post.new(uri)
    request.basic_auth(@client_id, @client_secret)
    request.set_form_data(
      'grant_type' => 'client_credentials',
      'scope' => 'library_account'
    )

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)['access_token']
  end

  def self.search_books(query)
    access_token = get_access_token
    uri = URI("#{BASE_URL}/libraries/#{@library_id}/media")
    uri.query = URI.encode_www_form(
      q: query,
      format: 'ebook',
      limit: 25
    )

    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{access_token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)['items'] || []
  end

  def self.get_download_link(overdrive_id)
    access_token = get_access_token
    uri = URI("#{BASE_URL}/media/#{overdrive_id}/downloadlink")
    
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{access_token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)['downloadLink']
  end

  def self.get_book_availability(overdrive_id)
    access_token = get_access_token
    uri = URI("#{BASE_URL}/libraries/#{@library_id}/media/#{overdrive_id}/availability")
    
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{access_token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end
end 