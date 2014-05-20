require 'spec_helper'
include Warden::Test::Helpers

describe "Publication pages" do


  before :each do
    @user = create(:user)
    login_as @user
  end

  describe "publication creation" do

    describe "with invalid information" do

      it "should not create a publication" do

        visit timeline_index_path

        find('#new-publication-btn').click

        within('#new-publication-modal') do
          expect { page.find('#create-publication-btn').click }.not_to change(Publication, :count)
        end
        
      end
    end


    describe "with valid information" do

      it "should create a publication" do

        @tag = create(:tag)

        visit timeline_index_path

        find('#new-publication-btn').click

        fill_in 'publication_text', with: 'I love Ruby!'

        select(@tag.name, :from => 'publication_tags')

        within('#new-publication-modal') do
          expect { page.find('#create-publication-btn').click }.to change(Publication, :count)
        end
        
      end

    end
  end

  after :each do
    @user.destroy
  end
end