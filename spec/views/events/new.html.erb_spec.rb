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
      end

      it "should create a event" do
        expect { click_button submit }.to change(Event, :count).by(1)
      end
    end
end
