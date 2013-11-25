require 'test_helper'

module RailsCodebook
  module Admin
    class CodebooksTest < Capybara::Rails::TestCase

      feature "Administration" do
        scenario "homepage" do
          visit rails_codebook_root_path
          within("h1") do
            assert page.has_content? 'Codebooks'
          end
        end

        scenario "index" do
          visit admin_codebooks_path
          within("h1") do
            assert page.has_content? 'Codebooks'
          end
        end

        scenario "paginate" do
          25.times do
            FactoryGirl.build(:codebook).save 
          end


        end

        scenario "search" do
          5.times do
            FactoryGirl.build(:codebook).save
          end
          visit admin_codebooks_path
          fill_in('query', with: 'trans')
          click_button('Search')  
          results = page.all(:css, "tr.codebook_line").length
          
          assert page.has_css?('#codebooks-table')
          assert results > 3, "got #{results}, should have gotten >3"
        end

        scenario "cb_name select" do  
          4.times do
            FactoryGirl.build(:codebook).save
          end
          visit admin_codebooks_path
          select('the_same', :from => 'cb_name')
          results = page.all(:css, "tr.codebook_line").length

          assert results > 3, "got #{results}, should have gotten >3"
        end

        scenario "both searches together" do
          4.times do
            FactoryGirl.build(:codebook).save
          end
          visit admin_codebooks_path
          fill_in('query', with: 'trans')
          select('the_same', :from => 'cb_name')

          click_button('Search')    
          results = page.all(:css, "tr.codebook_line").length
          
          assert page.has_css?('#codebooks-table')
          assert results > 3, "got #{results}, should have gotten >3"
        end

        scenario "both_searches_together_and_then_clear" do
          10.times do
            FactoryGirl.build(:codebook).save
          end

          visit admin_codebooks_path
          fill_in('query', with: 'trans')
          select('the_same', :from => 'cb_name')

          click_button('Search')
          results = page.all(:css, "tr.codebook_line").length
          
          assert page.has_css?('#codebooks-table')
          assert results > 3, "got #{results}, should have gotten >3"

          click_link('Clear')
          
          assert page.has_css?('#codebooks-table')
          assert (results == RailsCodebook::Codebook.all.paginate(page: 1).length), "got #{results}, should have gotten 10"       
        end

        scenario "codebook link" do
          4.times do
            FactoryGirl.build(:codebook).save
          end
          visit admin_codebooks_path
          click_link('the_same')    
          results = page.all(:css, "tr.codebook_line").length
          
          assert page.has_css?('#codebooks-table')
          assert results > 3, "got #{results}, should have gotten >3"
        end

        scenario "create new cb", js: true do
          visit admin_codebooks_path
          click_link "New"
          assert page.has_content? 'Codebook'

          fill_in('Value', with: "something")
          fill_in('Name', with: "something.else")
          fill_in('Codebook name', with: "andagain")        
          click_button "Submit"

          assert page.has_content? 'andagain'
          assert page.has_content? 'something'
        end

        scenario "edit submit", js: true do
          4.times do
            FactoryGirl.build(:codebook).save
          end
          visit admin_codebooks_path
          select('the_same', :from => 'cb_name')
          within(:css, "tr.codebook_line", match: :first) do
            page.find(:css, 'a.btn.btn-primary.dropdown-toggle').click
          end
          click_link('Edit')
          assert page.has_content? 'Codebook'
          fill_in('codebook_cb_name', with: "thesameagain")
          click_button "Submit"

          assert page.has_content? 'thesameagain'
        end

        scenario "edit cancel", js: true do
          4.times do
            FactoryGirl.build(:codebook).save
          end
          visit admin_codebooks_path
          select('the_same', :from => 'cb_name')
          within(:css, "tr.codebook_line", match: :first) do
            page.find(:css, 'a.btn.btn-primary.dropdown-toggle').click
          end
          click_link('Edit')
          assert page.has_content? 'Codebook'
          fill_in('codebook_cb_name', with: "thesameagainandagain")
          click_link "Close"

          assert !(page.has_content? 'thesameagainandagain')
        end

        scenario "delete", js: true do
          4.times do
            FactoryGirl.build(:codebook).save
          end
          visit admin_codebooks_path
          select('the_same', :from => 'cb_name')
          results_before = page.all(:css, "tr.codebook_line").length
          within(:css, "tr.codebook_line", match: :first) do
            page.find(:css, 'a.btn.btn-primary.dropdown-toggle').click
          end
          click_link('Delete')
          page.driver.browser.switch_to.alert.accept
          sleep 1
          results_after = page.all(:css, "tr.codebook_line").length
          
          assert !(results_before == results_after), "This: #{results_before} should be bigger than: #{results_after}"
        end

      end
    end
  end
end