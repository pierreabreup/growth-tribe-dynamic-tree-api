require 'rails_helper'


RSpec.describe Node, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:children).dependent(:destroy) }
    it { is_expected.to belong_to(:tree) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :tree_id }
  end
end
