require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
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
=======
  test "should get index" do
    get books_index_url
    assert_response :success
  end

  test "should get show" do
    get books_show_url
    assert_response :success
  end
end
>>>>>>> bc5036a (Dashboard, borrowing page)
