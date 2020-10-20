require 'rails_helper'

describe ProfileController, type: :controller do
  let!(:user) { create :user }

  context '#update' do
    let(:data) do
      {
        user: {
          name: 'Name test'
        }
      }
    end
    before { sign_in user }

    it do
      expect { post :update, params: data }.to change { User.last.name }.from(user.name).to('Name test')
    end
  end
end
