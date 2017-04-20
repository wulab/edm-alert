require 'rails_helper'

describe UnsubscribesController do
  include UnsubscribesHelper

  describe "#show" do
    context "with a valid unsubscribe token" do
      it "updates the user's unsubscribe preference" do
        user = create(:user, location: build(:location))

        get :show, token: unsubscribe_token_for(user)

        expect(user.reload).to be_unsubscribed_from_emails
      end
    end

    context "with an invalid token" do
      it "display a relavant error status to the user" do
        get :show, token: 'fake-token'

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when the user can't be found" do
      it "displays a relavant error status to the user" do
        get :show, token: unsubscribe_token_for(double("fake-user", id: 123))

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  def unsubscribe_token_for(user)
    unsubscribe_token_verifier.generate(user.id)
  end
end
