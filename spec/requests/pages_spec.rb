require 'spec_helper'

describe "Pages" do
  describe "Home page" do
    it "should have the title 'Home'" do
      visit root_path
      page.should have_selector('title', text: '| Home')
    end
  end

  describe "Help page" do
  it "should have the title 'Help'" do
      visit help_path
      page.should have_selector('title', text: '| Help')
    end
  end

  describe "About page" do
  it "should have the title 'About'" do
      visit about_path
      page.should have_selector('title', text: '| About')
    end
  end

  describe "Contact page" do
  it "should have the title 'Contact'" do
     visit contact_path
      page.should have_selector('title', text: '| Contact')
    end
  end
end
