require 'rails_helper'

describe Comment, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to belong_to(:post).class_name('Post') }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:text) }
  end

  context '#expires?' do
    context 'not expires' do
      let!(:comment) { create :comment }

      it { expect(comment.expires?).to eq false }
    end

    context 'expires time' do
      let!(:comment) { create :comment, created_at: 16.minutes.ago }

      it { expect(comment.expires?).to eq true }
    end
  end
end
