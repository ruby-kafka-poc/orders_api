# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/invoices', type: :request do
  let(:order) { FactoryBot.create(:order) }

  let(:valid_attributes) do
    {
      po: Faker::Movie.name,
      organization_id: Faker::Number.rand_in_range(1, 100),
      customer_id: Faker::Number.rand_in_range(1, 100),
      date: DateTime.now,
      deliver_date: Faker::Number.rand_in_range(1, 10).days.since,
      state: 'pending',
      order_id: order.id
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
  # in invoice to pass any filters (e.g. authentication) defined in
  # InvoicesController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) do
    {}
  end

  let(:invoice) { FactoryBot.create(:invoice) }

  describe 'GET /index' do
    before { FactoryBot.create_list(:invoice, 3) }

    it 'renders a successful response' do
      get invoices_url, headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body).count).to eq(3)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get invoice_url(invoice), as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)['organization_id']).to eq(invoice.organization_id)
      expect(JSON.parse(response.body)['customer_id']).to eq(invoice.customer_id)
      expect(JSON.parse(response.body)['order_id']).to eq(invoice.order_id)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Invoice' do
        expect do
          post invoices_url,
               params: { invoice: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Invoice, :count).by(1)
      end

      it 'renders a JSON response with the new invoice' do
        post invoices_url,
             params: { invoice: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Invoice' do
        expect do
          post invoices_url,
               params: { invoice: invalid_attributes }, as: :json
        end.to change(Invoice, :count).by(0)
      end

      it 'renders a JSON response with errors for the new invoice' do
        post invoices_url,
             params: { invoice: invalid_attributes }, headers: valid_headers, as: :json
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

      it 'updates the requested invoice' do
        patch invoice_url(invoice),
              params: { invoice: new_attributes }, headers: valid_headers, as: :json
        expect(invoice.reload.po).to eq('Edited')
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the invoice' do
        patch invoice_url(invoice),
              params: { invoice: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested invoice' do
      delete invoice_url(invoice.id), headers: valid_headers, as: :json
      expect(Invoice.all.count).to eq(0)
    end
  end
end
