require 'rails_helper'

describe Location, type: :model do
  context "associations" do
    it { should have_many(:events) }
    it { should have_many(:users) }
  end

  context "validations" do
    it { should validate_presence_of(:postal_code) }
  end
end
