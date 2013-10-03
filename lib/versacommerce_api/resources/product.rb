# -*- encoding : utf-8 -*-
module VersacommerceAPI

  class Product < Base
    include Associatable
    
    # compute the price range
    def price_range
      prices = variants.collect(&:price)
      format =  "%0.2f"
      if prices.min != prices.max
        "#{format % prices.min} - #{format % prices.max}"
      else
        format % prices.min
      end
    end
    
    def available
      amount_available(0) && active
    end

    def amount_available(amount)
      if considers_stock
        stock >= amount
      else
        true
      end
    end
    
    def is_variant
      !product_id.nil?
    end
    
    def properties
       associated_resource "property"
    end
    
    def product_images
      associated_resource "product_image"
    end
    
    def variants
      associated_resource "variant"
    end
    
    def tags
      return [] if self.respond_to?("tag_list") && self.send("tag_list").blank?
      tag_list.split(",").map(&:strip)
    end
    
    def featured_image
      ProductImage.new(:src => featured_image_url)
    end
  end
  
end
