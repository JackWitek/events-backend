require "test_helper"

class DaterangesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daterange = dateranges(:one)
  end

  test "should get index" do
    get dateranges_url, as: :json
    assert_response :success
  end

  test "should create daterange" do
    assert_difference('Daterange.count') do
      post dateranges_url, params: { daterange: { endDate: @daterange.endDate, name: @daterange.name, startDate: @daterange.startDate, user_id: @daterange.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show daterange" do
    get daterange_url(@daterange), as: :json
    assert_response :success
  end

  test "should update daterange" do
    patch daterange_url(@daterange), params: { daterange: { endDate: @daterange.endDate, name: @daterange.name, startDate: @daterange.startDate, user_id: @daterange.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy daterange" do
    assert_difference('Daterange.count', -1) do
      delete daterange_url(@daterange), as: :json
    end

    assert_response 204
  end
end
