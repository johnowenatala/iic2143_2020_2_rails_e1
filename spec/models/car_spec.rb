require 'rails_helper'

RSpec.describe Car, type: :model do

  describe '#brand_and_model' do

    let(:car) { create(:car) }

    it 'is not blank' do
      expect(car.brand_and_model).to_not be_blank
    end

    it 'includes brand' do
      expect(car.brand_and_model).to include(car.brand)
    end

    it 'includes model' do
      expect(car.brand_and_model).to include(car.model)
    end

  end

end
