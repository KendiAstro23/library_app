require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @book = books(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get books_url
    assert_response :success
  end
end