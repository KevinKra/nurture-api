require 'rails_helper'

RSpec.describe "Registrations API", type: :request do
  let(:valid_attributes) { {user: { email: "user@gmail.com", password: "password", password_confirmation: "password" }} }

  context "when request is valid" do
    before { post '/registrations', params: valid_attributes }

    it "registers the user" do
      expect(json['user']['email']).to eq("user@gmail.com")
    end

    it "returns a status code of 201" do
      expect(response).to have_http_status(200)
    end
  end

  context "when the request is invalid" do
    before { post '/registrations', params: { user: { email: "incorrect", password: "password"  } }  }

    it "returns a status code of 422" do
      expect(response).to have_http_status(422)
    end

    it "returns a validation failure message" do
      expect(response.body).to match(/Validation failed: Password confirmation can't be blank/)
    end
  end

end