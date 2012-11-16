require 'spec_helper'

describe "Pages" do
  
  subject { page }
  
  shared_examples_for "all pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) { "peterkimblog" }
    let(:page_title) { "" }
    it_should_behave_like "all pages"
    it { should_not have_selector('title', text: ' | Home') }
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading) { "Help" }
    let(:page_title) { "Help" }
    it_should_behave_like "all pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading) { "About" }
    let(:page_title) { "About" }
    it_should_behave_like "all pages"
  end
  
  describe "Contact page" do
    before { visit contact_path }
    let(:heading) { "Contact" }
    let(:page_title) { "Contact" }
    it_should_behave_like "all pages"
  end

  it "should have right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector('title', text: full_title('About'))
    click_link "Contact"
    page.should have_selector('title', text: full_title('Contact'))
    click_link "Help"
    page.should have_selector('title', text: full_title('Help'))    
  end
end
