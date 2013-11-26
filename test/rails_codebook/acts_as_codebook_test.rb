require 'test_helper'

module RailsCodebook

  class ActsAsCodebookTest < ActiveSupport::TestCase

    before do
      @article = FactoryGirl.create(:article)
    end

    test "cb_model" do
      article_orig = Article.class
      article_cb_name = Article.send('cb_model').class

      assert (article_orig === article_cb_name) 
    end

    test "has all methods" do
      assert @article.methods.include? :article_cb_this
      assert @article.methods.include? :article_cb_object
      assert Article.methods.include? :article_cb_name
      assert Article.methods.include? :article_cb_object_all
      assert Article.methods.include? :article_cb_keys
      assert Article.methods.include? :article_cb_values
      assert Article.methods.include? :article_cb_all
    end
    
    test "codebook_object method" do
      article_orig = Article.where(["id=?", @article.id]).select("id, title")
      article_cb = @article.article_cb_object

      assert (article_cb === article_orig)
    end

    test "codebook_this method" do
      article_orig = @article.codebookify
      article_cb = @article.article_cb_this

      assert (article_cb === article_orig)
    end

    test "self codebook_object_all method" do
      article_orig = Article.all.select("id, title")
      article_cb = Article.article_cb_object_all

      assert (article_cb === article_orig)
    end

    test "self codebook_name method" do
      article_orig = (@article.class.to_s.downcase+"_cb").to_s
      article_cb = Article.article_cb_name

      assert (article_cb === article_orig)
    end

    test "self codebook_keys method" do
      article_orig = Article.all.map(&:id)
      article_cb = Article.article_cb_keys

      assert (article_cb === article_orig)
    end

    test "self codebook_values method" do
      article_orig = Article.all.map(&:title)
      article_cb = Article.article_cb_values

      assert (article_cb === article_orig)
    end

    test "self codebook_all method" do
      article_orig = []
      Article.all.each {|row| article_orig <<  row.codebookify}
      article_cb = Article.article_cb_all

      assert (article_cb === article_orig)
    end

    test "codebookify" do
      article_orig = @article.codebookify
      article_cb = { key: @article.id, value: @article.title}

      assert (article_cb === article_orig)
    end

  end

end