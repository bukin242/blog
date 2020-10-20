require 'rails_helper'

describe PostTag, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:post).class_name('Post') }
    it { is_expected.to belong_to(:tag).class_name('Tag') }
  end
end
