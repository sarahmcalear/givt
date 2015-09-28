require 'rails_helper'

describe Api::V1::UsersController, type: :controller do

  setup { host! 'api.givt.com' }
  describe 'GET #new user' do
    it 'a user can sign up' do
      get :new, format: :json
      assert_equal 200, response.status
      refute_empty response.body
    end
  end

  describe 'Post #create' do
    context 'with valid attributes' do

      it 'saves the new contact in the database' do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User,:count).by(1)
      end
      it 'redirects to the homepage' do
        post :create, user: FactoryGirl.attributes_for(:user)
        # response.should redirect_to
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new contact in the database'
      it 're-renders the :new template'
    end
  end
end

