require 'rails_helper'

describe CommentController, type: :controller do
  let!(:user) { create :user }

  context '#create' do
    let!(:new_post) { create :post, user: user }
    let(:data) do
      {
        post_id: new_post.id,
        comment: {
          text: 'Text'
        }
      }
    end
    before { sign_in user }

    it do
      expect { post :create, params: data }.to change { Comment.count }.to(1)
    end
  end

  context '#update' do
    context 'not expires' do
      let!(:new_post) { create :post, user: user }
      let!(:comment) { create :comment, post: new_post, user: user }
      let(:data) do
        {
          post_id: new_post.id,
          id: comment.id,
          comment: {
            text: 'Text test'
          }
        }
      end
      before { sign_in user }

      it do
        expect { post :update, params: data }.to change { Comment.last.text }.from(comment.text).to('Text test')
      end
    end

    context 'expires time' do
      let!(:new_post) { create :post, user: user }
      let!(:comment) { create :comment, post: new_post, user: user, expires_at: 1.minutes.ago }
      let(:data) do
        {
          post_id: new_post.id,
          id: comment.id,
          comment: {
            text: 'Text test'
          }
        }
      end
      before do
        sign_in user
        post :update, params: data
      end

      it { expect(response).to redirect_to(post_path(new_post.id)) }
      it { expect { post :update, params: data }.not_to change { Comment.last.text } }
    end
  end

  context '#destroy' do
    context 'not expires' do
      let!(:post) { create :post, user: user }
      let!(:comment) { create :comment, post: post, user: user }
      before { sign_in user }

      it do
        expect { delete :destroy, params: {post_id: post.id, id: comment.id} }.to change { Comment.count }.from(1).to(0)
      end
    end

    context 'expires time' do
      let!(:post) { create :post, user: user }
      let!(:comment) { create :comment, post: post, user: user, expires_at: 1.minutes.ago }
      before do
        sign_in user
        delete :destroy, params: {post_id: post.id, id: comment.id}
      end

      it { expect(response).to redirect_to(post_path(post.id)) }

      it do
        expect { delete :destroy, params: {post_id: post.id, id: comment.id} }.not_to change { Comment.count }
      end
    end
  end
end
