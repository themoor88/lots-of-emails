require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "orders by last name" do
    lindeman = User.create!(email: "wjkagzi@gmal.com", password: "heycools", first_name: "Andy", last_name: "Lindeman")
    chelimsky = User.create!(email: "hey@me.com", password: "whazzuos", first_name: "David", last_name: "Chelimsky")

    expect(User.ordered_by_last_name).to eq([chelimsky, lindeman])
  end
end