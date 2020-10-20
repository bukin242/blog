require 'rails_helper'

describe Post, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to have_many(:post_tags).class_name('PostTag') }
    it { is_expected.to have_many(:tags).through(:post_tags) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:text) }
  end
end
