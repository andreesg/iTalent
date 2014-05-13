require 'spec_helper'
include Warden::Test::Helpers

describe "Tag Pages" do

  subject { page }

  before :each do
    @user = create(:user)
    login_as @user
  end

  describe "Tag visualization" do

    before do
      @publication = create(:publication)
    end

    it "should be visible in timeline publications" do

      visit timeline_index_path

      within('.post-bubble') do
        expect(page).to have_content(@publication.tags.first.name)
      end
    end
  end

  after :each do
    @user.destroy
  end
end
