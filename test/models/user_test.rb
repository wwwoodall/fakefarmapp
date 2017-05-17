require "test_helper"

describe User do

  it "must be valid" do
    user = users(:one)
    user.password = 'letmein'
    value(users(:one)).must_be :valid?
  end

  it "requires name to be valid" do
    user = User.new
    assert_equal user.save, false
  end
end
