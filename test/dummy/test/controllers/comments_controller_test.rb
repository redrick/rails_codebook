require "test_helper"

class CommentsControllerTest < ActionController::TestCase

  before do
    @comment = create(:comment)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Comment.count') do
      post :create, comment: { author: "Me", content: "What is up ?" }
    end

    assert_redirected_to comment_path(assigns(:comment))
  end

  def test_show
    get :show, id: @comment
    assert_response :success
  end

  def test_edit
    get :edit, id: @comment
    assert_response :success
  end

  def test_update
    put :update, id: @comment, comment: { author: "You", content: "How are you doing ?" }
    assert_redirected_to comment_path(assigns(:comment))
  end

  def test_destroy
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment
    end

    assert_redirected_to comments_path
  end
end
