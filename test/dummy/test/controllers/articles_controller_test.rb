require "test_helper"

class ArticlesControllerTest < ActionController::TestCase

  before do
    @article = create(:article)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Article.count') do
      post :create, article: { title: "Hello", text: "World", importance_cb: "low" }
    end

    assert_redirected_to article_path(assigns(:article))
  end

  def test_show
    get :show, id: @article
    assert_response :success
  end

  def test_edit
    get :edit, id: @article
    assert_response :success
  end

  def test_update
    put :update, id: @article, article: { title: "Hi", text: "There", importance_cb: "high" }
    assert_redirected_to article_path(assigns(:article))
  end

  def test_destroy
    assert_difference('Article.count', -1) do
      delete :destroy, id: @article
    end

    assert_redirected_to articles_path
  end
end
