# spec/requests/cars_request_spec.rb
require 'rails_helper'

RSpec.describe "Cars", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/cars/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/cars/new"
      expect(response).to have_http_status(:success)
    end

    it "renders new form" do
      get "/cars/new"
      expect(response).to render_template(:new)
    end
  end

  describe "POST /create" do

    let(:new_brand){ create(:brand) }
    let(:new_model){ create(:model, brand: new_brand) }
    let(:new_price){ rand(8_000_000..15_000_000) }

    let(:creating_params) do
      {
        car: {
          model_id: new_model.id,
          price: new_price
        }
      }
    end

    it 'forwards to index' do
      post "/cars/create", params: creating_params
      expect(response).to redirect_to("/cars/index")
    end

    it 'creates a new car' do
      previous_quantity = Car.count
      post "/cars/create", params: creating_params
      expect(Car.count).to eq(previous_quantity + 1)
    end

    it 'creates a new car with expected brand and model' do
      post "/cars/create", params: creating_params
      expect(Car.last).to have_attributes(
        brand: new_brand,
        model: new_model
      )
    end

    context 'given too lower pricing' do
      let(:new_price){ rand(1_000_000..3_000_000) }

      it 'renders new' do
        post "/cars/create", params: creating_params
        expect(response).to render_template(:new)
      end
      it 'marks @car with error' do
        post "/cars/create", params: creating_params
        expect(assigns(:car)).to have_attributes(valid?: false)
      end
      it 'marks @car with price error' do
        post "/cars/create", params: creating_params
        expect(assigns(:car).errors[:price]).to be_present
      end
    end

  end # describe "POST /create"
end # describe "Cars"
