# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_item, only: %i[update destroy]

  # GET /invoices/1/items
  # GET /orders/1/items
  def index
    @items = Item.all

    render json: @items
  end

  # POST /invoices/1/items
  # POST /orders/1/items
  def create
    @item = Item.new(create_params)

    if @item.save
      render json: @item, status: :created
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invoices/1/items/1
  # PATCH/PUT /orders/1/items/1
  def update
    if @item.update(update_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invoices/1/items/1
  # DELETE /orders/1/items/1
  def destroy
    @item.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(
      %w[
        invoice_id order_id quantity description code amount
      ]
    )
  end

  def create_params
    itemable = item_params[:order_id] ? order : invoice
    item_params.except(:invoice_id, :order_id).merge(itemable:)
  end

  def order
    Order.new(id: item_params[:order_id])
  end

  def invoice
    Invoice.new(id: item_params[:invoice_id])
  end

  def update_params
    item_params.except(:invoice_id, :order_id)
  end
end
