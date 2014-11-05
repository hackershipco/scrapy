require 'test_helper'

class ScrapperControllerTest < ActionController::TestCase
  test "should get scrap" do
    get :scrap
    assert_response :success
  end

end
