require 'rails_helper'

RSpec.describe Post, type: :model do
  before { @post = FactoryBot.build(:post) }
  subject { @post }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:title).is_at_most(120) }
    it { should validate_length_of(:description).is_at_most(1000) }
  end
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:location).optional(true) }
  end

  it { is_expected.to callback(:assign_location).before(:save) }
end
