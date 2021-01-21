require "rails_helper"

RSpec.describe User, type: :model do
  describe "validates" do
    context "first_name" do
      it "requires a first_name" do
        user = FactoryBot.build(:user, first_name: nil)
        user.valid?
        expect(user.errors.messages).to(have_key(:first_name))
      end
    end
    context "last_name" do
      it "requires a last_name" do
        user = FactoryBot.build(:user, last_name: nil)
        user.valid?
        expect(user.errors.messages).to(have_key(:last_name))
      end
    end
    context "email" do
      it "requires a unique email" do
        user = FactoryBot.build(:user)
        second_user = FactoryBot.build(:user, email: user.email)
        second_user.valid?
        expect(second_user.errors.messages).to(have_key(:email))
      end
    end

    context "full_name check" do
      it "returns full name from first and last names and capitalizes it" do
        user = FactoryBot.build(:user, first_name: "john", last_name: "doe")
        expect(user.full_name).to(eq("John Doe"))
      end
    end
  end
end
