# -*- encoding : utf-8 -*-
module VersacommerceAPI

  # An order comes by default with three associations: shipping_address, billing_address and customer.
  # because we already know the amount of data. if you want to include order items use the :include option like:
  # VersaCommerceShopApi::Order.find(:all, :params => {:include => 'items', :limit => 10})
  class Order < Base
    include Associatable
    include Metafieldable

    def items
      associated_resource "items"
    end

    def payments
      associated_resource "payment"
    end

    def shipments
      associated_resource "shipments"
    end

    def shipping_address
      associated_resource "shipping_address", false
    end

    def billing_address
      associated_resource "billing_address", false
    end
  end

end
