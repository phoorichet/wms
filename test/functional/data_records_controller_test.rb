require 'test_helper'

class DataRecordsControllerTest < ActionController::TestCase
  setup do
    @data_record = data_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create data_record" do
    assert_difference('DataRecord.count') do
      post :create, data_record: {  }
    end

    assert_redirected_to data_record_path(assigns(:data_record))
  end

  test "should show data_record" do
    get :show, id: @data_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @data_record
    assert_response :success
  end

  test "should update data_record" do
    put :update, id: @data_record, data_record: {  }
    assert_redirected_to data_record_path(assigns(:data_record))
  end

  test "should destroy data_record" do
    assert_difference('DataRecord.count', -1) do
      delete :destroy, id: @data_record
    end

    assert_redirected_to data_records_path
  end
end
