# -*- encoding : utf-8 -*-
module VersacommerceAPI

  class ShippingAddres < Base
    def fullname
      [firstname, lastname].delete_if(&:blank?).compact * " "
    end
  end
  
end
