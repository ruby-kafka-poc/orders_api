# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemsController, type: :routing do
  describe 'routing' do
    context 'Invoices' do
      it 'routes to #index' do
        expect(get: '/invoices/2/items').to route_to('items#index', invoice_id: '2')
      end

      it 'routes to #create' do
        expect(post: '/invoices/2/items').to route_to('items#create', invoice_id: '2')
      end

      it 'routes to #update via PUT' do
        expect(put: '/invoices/2/items/1').to route_to('items#update', id: '1', invoice_id: '2')
      end

      it 'routes to #update via PATCH' do
        expect(patch: '/invoices/2/items/1').to route_to('items#update', id: '1', invoice_id: '2')
      end

      it 'routes to #destroy' do
        expect(delete: '/invoices/2/items/1').to route_to('items#destroy', id: '1', invoice_id: '2')
      end
    end

    context 'Orders' do
      it 'routes to #index' do
        expect(get: '/orders/2/items').to route_to('items#index', order_id: '2')
      end

      it 'routes to #create' do
        expect(post: '/orders/2/items').to route_to('items#create', order_id: '2')
      end

      it 'routes to #update via PUT' do
        expect(put: '/orders/2/items/1').to route_to('items#update', id: '1', order_id: '2')
      end

      it 'routes to #update via PATCH' do
        expect(patch: '/orders/2/items/1').to route_to('items#update', id: '1', order_id: '2')
      end

      it 'routes to #destroy' do
        expect(delete: '/orders/2/items/1').to route_to('items#destroy', id: '1', order_id: '2')
      end
    end
  end
end
