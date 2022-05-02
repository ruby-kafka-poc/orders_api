# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/orders', type: :request do
  let(:valid_attributes) do
    {
      po: Faker::Movie.name,
      organization_id: Faker::Number.rand_in_range(1, 100),
      customer_id: Faker::Number.rand_in_range(1, 100),
      date: DateTime.now,
      deliver_date: Faker::Number.rand_in_range(1, 10).days.since,
      state: 'pending'
    }
  end

  let(:invalid_attributes) do
    {
      date: DateTime.now,
      deliver_date: Faker::Number.rand_in_range(1, 10).days.ago
    }
  end

  # TODO: add auth
  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # OrdersController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) do
    {}
  end

  let(:order) { FactoryBot.create(:order) }

  describe 'GET /index' do
    before { FactoryBot.create_list(:order, 3) }

    it 'renders a successful response' do
      get orders_url, headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body).count).to eq(3)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get order_url(order), as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)['organization_id']).to eq(order.organization_id)
      expect(JSON.parse(response.body)['customer_id']).to eq(order.customer_id)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Order' do
        expect do
          post orders_url,
               params: { order: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Order, :count).by(1)
      end

      it 'renders a JSON response with the new order' do
        post orders_url,
             params: { order: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Order' do
        expect do
          post orders_url,
               params: { order: invalid_attributes }, as: :json
        end.to change(Order, :count).by(0)
      end

      it 'renders a JSON response with errors for the new order' do
        post orders_url,
             params: { order: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          po: 'Edited'
        }
      end

      it 'updates the requested order' do
        patch order_url(order),
              params: { order: new_attributes }, headers: valid_headers, as: :json
        expect(order.reload.po).to eq('Edited')
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the order' do
        patch order_url(order),
              params: { order: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested order' do
      delete order_url(order.id), headers: valid_headers, as: :json
      expect(Order.all.count).to eq(0)
    end
  end
end
