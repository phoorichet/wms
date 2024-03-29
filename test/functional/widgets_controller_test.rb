require 'test_helper'

class WidgetsControllerTest < ActionController::TestCase
  setup do
    @widget = widgets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:widgets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create widget" do
    assert_difference('Widget.count') do
      post :create, widget: { collection: @widget.collection, config_file_path: @widget.config_file_path, database: @widget.database, description: @widget.description, is_disable: @widget.is_disable, last_run_at: @widget.last_run_at, last_run_at: @widget.last_run_at, name: @widget.name, run_interval: @widget.run_interval, url: @widget.url, user_id: @widget.user_id, version: @widget.version }
    end

    assert_redirected_to widget_path(assigns(:widget))
  end

  test "should show widget" do
    get :show, id: @widget
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @widget
    assert_response :success
  end

  test "should update widget" do
    put :update, id: @widget, widget: { collection: @widget.collection, config_file_path: @widget.config_file_path, database: @widget.database, description: @widget.description, is_disable: @widget.is_disable, last_run_at: @widget.last_run_at, last_run_at: @widget.last_run_at, name: @widget.name, run_interval: @widget.run_interval, url: @widget.url, user_id: @widget.user_id, version: @widget.version }
    assert_redirected_to widget_path(assigns(:widget))
  end

  test "should destroy widget" do
    assert_difference('Widget.count', -1) do
      delete :destroy, id: @widget
    end

    assert_redirected_to widgets_path
  end
end
