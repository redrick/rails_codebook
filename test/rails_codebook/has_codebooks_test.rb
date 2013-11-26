require 'test_helper'

module RailsCodebook

  class HasCodebooksTest < ActiveSupport::TestCase

    before do
      @article = FactoryGirl.create(:article)
    end

    test "has all methods" do
      assert @article.methods.include? :importance
      assert @article.methods.include? :importance_object
      assert Article.methods.include? :importance_object_all
      assert Article.methods.include? :importance_codebook_name
      assert Article.methods.include? :importance_values
      assert Article.methods.include? :importance_keys
      assert Article.methods.include? :importance_collection
      assert Article.methods.include? :importance_all
    end
    
    test "codebook_object method" do
      codebook_db = RailsCodebook::Codebook.find_by_value(@article.importance_object.value)
      codebook_rel = @article.importance_object

      assert (codebook_db === codebook_rel) 
    end

    test " self codebook_object_all method" do
      codebook_db = RailsCodebook::Codebook.find_all_by_cb_name(@article.importance_object.cb_name)
      codebook_rel = Article.importance_object_all

      assert (codebook_db === codebook_rel) 
    end

    test "self codebook_name method" do
      codebook_db = @article.importance_object.cb_name
      codebook_rel = Article.importance_codebook_name

      assert (codebook_db === codebook_rel) 
    end

    test "self codebook_keys method" do
      codebook_db = RailsCodebook::Codebook.find_all_by_cb_name(@article.importance_object.cb_name).map(&:value)
      codebook_rel = Article.importance_keys

      assert (codebook_rel.class.to_s == 'Array')
      assert (codebook_db === codebook_rel) 
    end

    test "self codebook_collection method" do
      codebook_db = RailsCodebook::Codebook.find_all_by_cb_name(@article.importance_object.cb_name)
      codebook_rel = Article.importance_collection

      assert (codebook_db === codebook_rel) 
    end

    test "self codebook_values method" do
      codebook_db = RailsCodebook::Codebook.find_all_by_cb_name(@article.importance_object.cb_name).map(&:t_name)
      codebook_rel = Article.importance_values

      assert (codebook_rel.class.to_s == 'Array')
      assert (codebook_db === codebook_rel) 
    end

    test "self codebook_all method" do
      codebook_db = RailsCodebook::Codebook.find_all_by_cb_name(@article.importance_object.cb_name).cb_serialize
      codebook_rel = Article.importance_all

      assert (codebook_db === codebook_rel)
    end
  end

end