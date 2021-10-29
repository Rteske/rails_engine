require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:items) }
  end

  describe 'class methods' do
    let(:merchants) { create_list :merchants }
    it 'can find partial matches to a given string' do
      expect(Merchant.search_by_name())
    end
  end
end
