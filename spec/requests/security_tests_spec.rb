require 'spec_helper'

describe "SecurityTests" do
  describe "Home page" do
    it "should have the content 'ДБиЗИ'" do
      visit '/oib/home'
      expect(page).to have_content('ДБиЗИ')
    end
    it "should have the right title" do
      visit '/oib/home'
      expect(page).to have_title("ДБиЗИ | Главная")
    end
  end

describe "News page" do
    it "should have the content 'нужно соблюдать'" do
      visit '/oib/news'
      expect(page).to have_content('нужно соблюдать')
    end
    it "should have the right title" do
      visit '/oib/news'
      expect(page).to have_title("ДБиЗИ | Новости")
    end
  end

describe "Structure page" do
    it "should have the content 'команда'" do
      visit '/oib/structure'
      expect(page).to have_content('команда')
    end
    it "should have the right title" do
      visit '/oib/structure'
      expect(page).to have_title("ДБиЗИ | Структура")
    end
  end

describe "Help page" do
    it "should have the content 'База'" do
      visit '/oib/help'
      expect(page).to have_content('База')
    end
    it "should have the right title" do
      visit '/oib/help'
      expect(page).to have_title("ДБиЗИ | Скорая помощь")
    end
  end

describe "Room page" do
    it "should have the content 'Поговорим'" do
      visit '/oib/room'
      expect(page).to have_content('Поговорим')
    end
    it "should have the right title" do
      visit '/oib/room'
      expect(page).to have_title("ДБиЗИ | Курилка")
    end
  end  
end
