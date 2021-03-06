require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do  
  describe "POST /api/v1/sessions" do
    let(:valid_attributes) { { user: { email: 'user@gmail.com', password: "password" } } }

    context "when the request is valid" do
      before {
        user = User.create!({ email: 'user@gmail.com', password: "password", password_confirmation: "password" })
      }
      before { post '/api/v1/sessions', params: valid_attributes }

      it "logs in the user" do
        expect(json['logged_in']).to eq(true)
        expect(json['user']['email']).to eq('user@gmail.com')
      end

      it "returns a status code of 201" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      before { 
        post '/api/v1/sessions', params: { user: { email: "incorrect" } } 
      }

      it "returns a status code of 401" do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Username or Password does not match./)
      end
    end
  end
end