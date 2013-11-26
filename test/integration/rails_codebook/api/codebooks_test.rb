require 'test_helper'

module RailsCodebook
  module Admin
    class CodebooksTest < Capybara::Rails::TestCase

      feature "Api" do

        scenario "index" do
          10.times do
            FactoryGirl.build(:codebook).save 
          end

          visit api_codebooks_path

          assert JSON.parse(page.body).count == 10
        end

        scenario "index pagination" do
          25.times do
            FactoryGirl.build(:codebook).save 
          end

          visit api_codebooks_path
          index = page.body
          visit api_codebooks_path(page: 1)
          index_paginated = page.body

          assert (index == index_paginated)
        end

        scenario "search" do
          5.times do
            FactoryGirl.build(:api_cb).save 
          end

          visit api_codebooks_path(q: 'api')
          results  = JSON.parse(page.body).count
          assert (results == 5)
        end

        scenario "codebook search" do
          5.times do
            FactoryGirl.build(:api_cb).save 
          end

          visit api_codebooks_path(cb_name: 'api_test',q: 'api')
          results  = JSON.parse(page.body).count
          real_results = RailsCodebook::Codebook.find_all_by_cb_name('api_test').count

          assert (results == real_results)
        end

        scenario "codebook" do
          5.times do
            FactoryGirl.build(:api_cb).save 
          end

          visit api_codebook_path(cb_name: 'api_test')
          results  = JSON.parse(page.body)
          results.each do |result|
            assert (result['cb_name'] == 'api_test') , "Got: #{result['cb_name']}, expected: api_test"
          end
        end

        scenario "language change index" do
          5.times do
            FactoryGirl.build(:codebook).save 
          end

          visit api_codebooks_path(lang: 'cs')
          results  = JSON.parse(page.body)
          results.each do |result|
            assert (result['name'] =~ /missing: cs./) , "Got: #{result['name']}, expected: matches /missing: cs./"
          end
        end

        scenario "language change codebook" do
          5.times do
            FactoryGirl.build(:codebook).save 
          end

          visit api_codebook_path(lang: 'cs', cb_name: 'api_test')
          results  = JSON.parse(page.body)
          results.each do |result|
            assert (result['name'] =~ /missing: cs./) , "Got: #{result['name']}, expected: matches /missing: cs./"
          end
        end

        scenario "show" do
          cb = FactoryGirl.build(:codebook)      
          cb.save

          visit api_codebook_show_path(cb_name: cb.cb_name, id: cb.id)
          result  = JSON.parse(page.body)
          assert (result['name'] == cb.t_name) , "Got: #{result['name']}, expected: #{cb.t_name}"
          assert (result['cb_name'] == cb.cb_name) , "Got: #{result['cb_name']}, expected: #{cb.cb_name}"
          assert (result['value'] == cb.value) , "Got: #{result['value']}, expected: #{cb.value}"
        end

      end
    end
  end
end