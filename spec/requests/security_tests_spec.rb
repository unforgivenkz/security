require 'spec_helper'

describe "SecurityTests" do
  describe "Home page" do
    it "should have the content 'ДБиЗИ'" do
      visit '/oib/home'
      expect(page).to have_content('ДБиЗИ')
    end
  end

describe "News page" do
    it "should have the content 'нужно соблюдать'" do
      visit '/oib/news'
      expect(page).to have_content('нужно соблюдать')
    end
  end

describe "Structure page" do
    it "should have the content 'команда'" do
      visit '/oib/structure'
      expect(page).to have_content('команда')
    end
  end

describe "Help page" do
    it "should have the content 'База'" do
      visit '/oib/help'
      expect(page).to have_content('База')
    end
  end

describe "Room page" do
    it "should have the content 'Поговорим'" do
      visit '/oib/room'
      expect(page).to have_content('Поговорим')
    end
  end  
end
