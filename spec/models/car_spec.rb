require 'rails_helper'

RSpec.describe Car, type: :model do

  describe '#brand_and_model' do

    let(:car) { create(:car) }

    it 'has a model' do
      expect(car.model).to be_present
    end
    it 'has a brand' do
      expect(car.brand).to be_present
    end
    it 'is not blank' do
      expect(car.brand_and_model).to_not be_blank
    end

    it 'includes brand' do
      expect(car.brand_and_model).to include(car.brand_name)
    end

    it 'includes model' do
      expect(car.brand_and_model).to include(car.car_model_name)
    end

  end

end
