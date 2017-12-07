require "rails_helper"

describe PeopleController do
  describe "#create" do
    context "when person is valid" do
      it "redirects to #show" do
        post :create, person: { first_name: "Dong" }

        expect(response).to redirect_to person_path(assigns(:person))
      end
    end

    context "when person is invalid" do
      it "renders the 'new' template" do
        post :create, person: { first_name: "" }

        expect(response).to render_template :new
      end
    end
  end
end
