require 'rails_helper'

describe User, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:posts).class_name('Post') }
  end
end
