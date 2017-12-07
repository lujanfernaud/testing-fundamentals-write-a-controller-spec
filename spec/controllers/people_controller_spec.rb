require "rails_helper"

describe PeopleController do
  describe "#create" do
    context "when person is valid" do
      it "redirects to #show" do
        person = valid_person

        post :create, person: { first_name: "Dong" }

        expect(response).to redirect_to person
      end
    end

    context "when person is invalid" do
      it "renders the 'new' template" do
        person = invalid_person

        post :create, person: { first_name: "" }

        expect(response).to render_template :new
      end
    end
  end

  def valid_person
    person_double = Person.new

    allow(Person).to receive(:new).and_return(person_double)
    allow(person_double).to receive(:save).and_return(true)

    person_double
  end

  def invalid_person
    person_double = Person.new

    allow(Person).to receive(:new).and_return(person_double)
    allow(person_double).to receive(:save).and_return(false)
  end
end
