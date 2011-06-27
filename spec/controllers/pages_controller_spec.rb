require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                                    :content =>
      "Ruby on Rails Tutorial Sample App | Home")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    #title_test('contact')
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                                    :content =>
      "Ruby on Rails Tutorial Sample App | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                                    :content =>
      "Ruby on Rails Tutorial Sample App | About")
    end
  end

  ['home', 'contact', 'about'].each do |n|
    describe "#{n} Page titles" do
    end
  end

  def title_test(title)
    it "should have the right title" do
      get title
      response.should_have_selector(title,
                                    :content =>
      "Ruby on Rails Tutorial Sample App | #{title[0].upcase + title.slice(1..title.length)}")
    end
  end
end
