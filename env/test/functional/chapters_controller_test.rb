require 'test_helper'

class ChaptersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:chapters)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_chapters
    assert_difference('Chapters.count') do
      post :create, :chapters => { }
    end

    assert_redirected_to chapters_path(assigns(:chapters))
  end

  def test_should_show_chapters
    get :show, :id => chapters(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => chapters(:one).id
    assert_response :success
  end

  def test_should_update_chapters
    put :update, :id => chapters(:one).id, :chapters => { }
    assert_redirected_to chapters_path(assigns(:chapters))
  end

  def test_should_destroy_chapters
    assert_difference('Chapters.count', -1) do
      delete :destroy, :id => chapters(:one).id
    end

    assert_redirected_to chapters_path
  end
end
