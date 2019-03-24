require 'rails_helper'


RSpec.describe Tree, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:nodes).dependent(:destroy) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :json_data }
  end
end
