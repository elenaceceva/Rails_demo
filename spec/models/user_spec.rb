require 'rails_helper'

RSpec.describe User, type: :model do

  before { @user = FactoryBot.build(:user) }
  subject { @user }

  describe 'validations' do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:nickname) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:nickname) }
  it { should validate_length_of(:email).is_at_most(120) }
  it { should validate_length_of(:nickname).is_at_most(20) }
  it { should validate_length_of(:firstname).is_at_most(40) }
  it { should validate_length_of(:lastname).is_at_most(40) }
  end

  describe 'associations' do
  it { should belong_to(:location).optional(true) }
  it { should have_many(:posts) }
  end
  it { is_expected.to callback(:assign_location).before(:save) }
end
