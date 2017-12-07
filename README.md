# Upcase: Testing Fundamentals

## Write a Controller Spec

Implementing a simple spec for the [Testing Fundamentals](https://thoughtbot.com/upcase/testing-fundamentals) course.

```ruby
# people_controller_spec.rb

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
```

### What's Going On?

Make a person to use in the test.

```ruby
person_double = Person.new
```

When the controller calls `Person.new`, then return `person_double`.

```ruby
allow(Person).to receive(:new).and_return(person_double)
```

When the controller calls `save` on this person, return `true`.

```ruby
allow(person_double).to receive(:save).and_return(true)
```

### Why?

This avoids returning a new person. We're stubbing the result of the call to `Person.new`.
