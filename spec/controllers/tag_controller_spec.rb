require 'rails_helper'

describe TagController, type: :controller do
  render_views

  let!(:user) { create :user }

  context "#index" do
    let!(:tag) { create :tag }

    before do
      sign_in user
      get :index
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(response.body).to include(tag.name) }
  end

  context '#create' do
    let(:data) do
      {
        tag: {
          name: 'Name'
        }
      }
    end
    before { sign_in user }

    it do
      expect { post :create, params: data }.to change { Tag.count }.to(1)
    end
  end

  context '#update' do
    let!(:tag) { create :tag }
    let(:data) do
      {
        id: tag.id,
        tag: {
          name: 'Name test'
        }
      }
    end
    before { sign_in user }

    it do
      expect { post :update, params: data }.to change { Tag.last.name }.from(tag.name).to('Name test')
    end
  end

  context '#destroy' do
    let!(:tag) { create :tag }
    before { sign_in user }

    it do
      expect { delete :destroy, params: {id: tag.id} }.to change { Tag.count }.from(1).to(0)
    end
  end
end
