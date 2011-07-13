require 'spec_helper'

describe Micropost do
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :content => "value for content",
    }
  end

  it "should create a new instance given valid attributes" do
    @user.microposts.create!(@attr)
  end

  describe "user associations" do
    before(:each) do
      @micropost = @user.microposts.create!(@attr)
    end
    it "should have a user" do
      @micropost.should respond_to(:user)
    end
    it "should have the right user" do
      @micropost.user.should == @user
      @micropost.user_id.should == @user.id
    end
  end

  describe "validations" do
    it "should require a user id" do
      @micropost = Micropost.new(@attr)
      @micropost.should_not be_valid
    end
    it "should require nonblank content" do
      @user.microposts.build(:content => "  ").should_not be_valid
    end
    it "should reject long posts" do
      @user.microposts.build(:content => 'a' * 141).should_not be_valid
    end
  end
end
