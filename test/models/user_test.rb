require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not allow duplicate user" do
    user1 = User.create(firstname: "rony", lastname: "sharma" , email: "rog12@gmail.com")
    user2 = User.new(firstname: "rony", lastname: "sharma" , email: "rog12@gmail.com")
    user1.save
    assert_not user2.save, "Saved a user with duplicate value"
  end
  
  test "user attributes must not be empty" do 
   user = User.new
   assert user.invalid?
   assert user.errors[:firstname].any?
   assert user.errors[:lastname].any? 
   assert user.errors[:email].any? 
  end
end
