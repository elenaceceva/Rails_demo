require 'rails_helper'

RSpec.describe Location, type: :model do
  before { @location = FactoryBot.build(:location) }
  subject { @location }

  describe 'validations' do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:latitude) }
    it { should validate_length_of(:city).is_at_most(120) }
    it { should validate_length_of(:country).is_at_most(120) }
  end

  describe 'associations' do
    it { should have_many(:users) }
    it { should have_many(:posts) }
  end
end
