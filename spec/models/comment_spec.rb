require 'rails_helper'

describe Comment, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to belong_to(:post).class_name('Post') }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:text) }
  end
end
