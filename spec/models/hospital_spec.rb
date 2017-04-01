require 'rails_helper'

describe Hospital, type: :model do
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:postal_code) }
  end
end
