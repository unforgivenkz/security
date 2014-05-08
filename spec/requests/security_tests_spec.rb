require 'spec_helper'

describe "SecurityTests" do
  describe "Home page" do
    it "should have the content 'ДБиЗИ'" do
      visit '/oib/home'
      expect(page).to have_content('ДБиЗИ')
    end
  end
end
