require 'rails_helper'

describe PostController, type: :controller do
  render_views

  let!(:user) { create :user }

  context "#index" do
    let!(:post) { create :post, user: user }

    before do
      sign_in user
      get :index
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(response.body).to include(post.name) }
    it { expect(response.body).to include(post.annonce) }
  end

  context '#show' do
    let!(:post) { create :post, user: user }
    let!(:comment) { create :comment, post: post, user: user }

    before do
      sign_in user
      get :show, params: {id: post.id}
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(response.body).to include(post.name) }
    it { expect(response.body).to include(post.text) }
    it { expect(response.body).to include(comment.text) }
  end

  context '#create' do
    let(:data) do
      {
        post: {
          active: true,
          name: 'Name',
          annonce: 'Annonce',
          text: 'Text'
        }
      }
    end
    before { sign_in user }

    it do
      expect { post :create, params: data }.to change { Post.count }.to(1)
    end
  end

  context '#update' do
    let!(:new_post) { create :post, user: user }
    let(:data) do
      {
        id: new_post.id,
        post: {
          name: 'Name test',
          annonce: 'Annonce',
          text: 'Text',
          created_at: DateTime.current.to_s
        }
      }
    end
    before { sign_in user }

    it do
      expect { post :update, params: data }.to change { Post.last.name }.from(new_post.name).to('Name test')
    end
  end

  context '#destroy' do
    let!(:post) { create :post, user: user }
    before { sign_in user }

    it do
      expect { delete :destroy, params: {id: post.id} }.to change { Post.count }.from(1).to(0)
    end
  end
end
