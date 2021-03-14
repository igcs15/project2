require 'test_helper'

class InformationsImportsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get informations_imports_new_url
    assert_response :success
  end

  test "should get create" do
    get informations_imports_create_url
    assert_response :success
  end

end
