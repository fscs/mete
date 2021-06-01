require 'test_helper'

class AuditsControllerTest < ActionController::TestCase

  test "should get audits" do
    get :index
    assert_response :success
    assert_not_nil(:audits)
  end

  test "should get no audits" do
    # This is way back in the past.
    @date = {
      "year"  => 1970,
      "month" => 1,
      "day"   => 1
    }
    get :index, params: { start_date: @date, end_date: @date}
    assert_response :success
    assert_not_nil assigns(:audits)
  end

end
