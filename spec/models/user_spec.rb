require 'spec_helper'
require 'ar_or_where'


describe "User AR" do

  before :each do
    User.create! :first_name => "John", :last_name => "Brown"
    User.create! :first_name => "John", :last_name => "Smith"
    User.create! :first_name => "Tom", :last_name => "Smith"
    @tom_brown = User.create! :first_name => "Tom", :last_name => "Brown"
  end

  it "should support AND clause" do
    User.johnes.smiths.should have(1).item
  end

  it "should support OR clause" do
    sc = User.johnes.or(User.smiths)
    sc.should have(3).item
    sc.all.should_not include(@tom_brown)
  end

end
