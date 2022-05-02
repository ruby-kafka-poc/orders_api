# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/items', type: :request do
  context '/invoices/id' do
    let(:invoice) { FactoryBot.create(:invoice) }

    let(:valid_attributes) do
      {
        quantity: rand(10),
        description: Faker::Lorem.sentence,
        code: Faker::Lorem.word,
        amount: rand(1..1000) / 100,
        invoice_id: invoice.id
      }
    end

    let(:invalid_attributes) do
      {
        amount: -12.34
      }
    end

    # TODO: add auth
    # This should return the minimal set of values that should be in the headers
    # in item to pass any filters (e.g. authentication) defined in
    # ItemsController, or in your router and rack
    # middleware. Be sure to keep this updated too.
    let(:valid_headers) do
      {}
    end

    let(:item) { FactoryBot.create(:item, itemable: invoice) }

    describe 'GET /index' do
      before { FactoryBot.create_list(:item, 3, itemable: invoice) }

      it 'renders a successful response' do
        get invoice_items_url(invoice), headers: valid_headers, as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body).count).to eq(3)
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new Item' do
          expect do
            post invoice_items_url(invoice),
                 params: { item: valid_attributes }, headers: valid_headers, as: :json
          end.to change(Item, :count).by(1)
        end

        it 'renders a JSON response with the new item' do
          post invoice_items_url(invoice),
               params: { item: valid_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Item' do
          expect do
            post invoice_items_url(invoice),
                 params: { item: invalid_attributes }, as: :json
          end.to change(Item, :count).by(0)
        end

        it 'renders a JSON response with errors for the new item' do
          post invoice_items_url(invoice),
               params: { item: invalid_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) do
          {
            amount: 23.34
          }
        end

        it 'updates the requested item' do
          patch invoice_item_url(invoice.id, item.id),
                params: { item: new_attributes }, headers: valid_headers, as: :json
          expect(item.reload.amount).to eq(23.34)
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end

      context 'with invalid parameters' do
        it 'renders a JSON response with errors for the item' do
          patch invoice_item_url(invoice.id, item.id),
                params: { item: invalid_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested item' do
        delete invoice_item_url(invoice.id, item.id), headers: valid_headers, as: :json
        expect(Item.all.count).to eq(0)
      end
    end
  end

  context '/orders/id' do
    let(:order) { FactoryBot.create(:order) }

    let(:valid_attributes) do
      {
        quantity: rand(10),
        description: Faker::Lorem.sentence,
        code: Faker::Lorem.word,
        amount: rand(1..1000) / 100,
        order_id: order.id
      }
    end

    let(:invalid_attributes) do
      {
        amount: -12.34
      }
    end

    # TODO: add auth
    # This should return the minimal set of values that should be in the headers
    # in item to pass any filters (e.g. authentication) defined in
    # ItemsController, or in your router and rack
    # middleware. Be sure to keep this updated too.
    let(:valid_headers) do
      {}
    end

    let(:item) { FactoryBot.create(:item, itemable: order) }

    describe 'GET /index' do
      before { FactoryBot.create_list(:item, 3, itemable: order) }

      it 'renders a successful response' do
        get order_items_url(order), headers: valid_headers, as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body).count).to eq(3)
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new Item' do
          expect do
            post order_items_url(order),
                 params: { item: valid_attributes }, headers: valid_headers, as: :json
          end.to change(Item, :count).by(1)
        end

        it 'renders a JSON response with the new item' do
          post order_items_url(order),
               params: { item: valid_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Item' do
          expect do
            post order_items_url(order),
                 params: { item: invalid_attributes }, as: :json
          end.to change(Item, :count).by(0)
        end

        it 'renders a JSON response with errors for the new item' do
          post order_items_url(order),
               params: { item: invalid_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) do
          {
            amount: 23.34
          }
        end

        it 'updates the requested item' do
          patch order_item_url(order.id, item.id),
                params: { item: new_attributes }, headers: valid_headers, as: :json
          expect(item.reload.amount).to eq(23.34)
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end

      context 'with invalid parameters' do
        it 'renders a JSON response with errors for the item' do
          patch order_item_url(order.id, item.id),
                params: { item: invalid_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested item' do
        delete order_item_url(order.id, item.id), headers: valid_headers, as: :json
        expect(Item.all.count).to eq(0)
      end
    end
  end
end
