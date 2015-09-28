require 'rails_helper'

RSpec.describe Api::V1::SessionsController, :type => :controller do

  setup { host! 'api.givt.com' }
  describe "POST #create" do
    before(:each) do
      # set this as recommended by Devise so tests pass.
      @request.env["devise.mapping"] = Devise.mappings[:user]

      @user = FactoryGirl.create :user
    end

    context "when the credentials are correct" do
      before(:each) do
        credentials = { :user => {email: @user.email, password: @user.password } }
        post :create, credentials
      end

      it "returns response status 200 given credentials" do
        #puts @user
        #@user.reload
        expect(response.status).to eq(200)
      end

      it "returns the user authentication token" do
        result = JSON.parse(response.body)
        expect(result['auth_token']).to eq @user.authentication_token
      end

      it "returns the username" do
        result = JSON.parse(response.body)
        expect(result['username']).to eq @user.username
      end

      it "returns the email" do
        result = JSON.parse(response.body)
        expect(result['email']).to eq @user.email
      end
    end
  end
end

