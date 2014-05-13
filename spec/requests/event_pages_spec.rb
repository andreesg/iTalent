require 'spec_helper'
include Warden::Test::Helpers

describe "Event pages" do


  before :each do
    @user = create(:user)
    login_as @user
  end

  describe "event creation" do

    describe "with invalid information" do

      it "should not create an event" do

        visit timeline_index_path

        find('#new-event-btn').click

        within('#new-event-modal') do
          expect { page.find('#create-event-btn').click }.not_to change(Event, :count)
        end
        
      end
    end


    describe "with valid information" do

      it "should create a publication" do

        @tag = create(:tag)

        visit timeline_index_path

        find('#new-event-btn').click

        fill_in 'event_title', with: 'Ruby Workshop'
        fill_in 'event_description', with: 'The best Ruby Workshop given by the best PM ever.'
        fill_in 'event_date_start', with: '06:35 01-05-2014'
        fill_in 'event_date_end', with: '07:35 01-05-2014'
        fill_in 'event_date_limit', with: '06:35 01-05-2014'

        select(@tag.name, :from => 'event_tags')

        within('#new-event-modal') do
          expect { page.find('#create-event-btn').click }.to change(Event, :count)
        end
        
      end

    end
  end

  after :each do
    @user.destroy
  end
end