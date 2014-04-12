require 'spec_helper'

describe "Create new event" do
    before { visit new_event_path }

    let(:submit) { "Create event" }

    describe "with invalid information" do
      it "should not create a new event" do
        expect { click_button submit }.not_to change(Event, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Title",         with: "TTTTT"
        fill_in "Description",        with: "DDDD"
        fill_in "Date limit", with: "2014-04-07T13:01"
        fill_in "Date start", with: "2014-04-07T14:01"
      end

      it "should create a event" do
        expect { click_button submit }.to change(Event, :count).by(1)
      end
    end
end
