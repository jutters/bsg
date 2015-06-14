class ShopFilter
  include ActiveModel::Model

private
  def convert_to_bool(val)
    bVal = (val != "0" && val != "false" && val != false);
  end

public

  # def ignore_price_segment
  #   # default to true
  #   #@ignore_price_segment.nil? ? false || @ignore_price_segment;
    
  #   # default to false
  #   @ignore_price_segment || false;
  # end

  def price_segment_low
    @price_segment_low || false;
  end

  def price_segment_low=(newValue)
    Rails.logger.debug "setting price_segment_low to #{newValue}"
    @price_segment_low = convert_to_bool(newValue);
  end

  def price_segment_middle
    @price_segment_middle || false;
  end

  def price_segment_middle=(newValue)
    Rails.logger.debug "setting price_segment_middle to #{newValue}"
    @price_segment_middle = convert_to_bool(newValue);
  end

  def price_segment_high
    @price_segment_high || false;
  end

  def price_segment_high=(newValue)
    Rails.logger.debug "setting price_segment_high to #{newValue}"
    @price_segment_high = convert_to_bool(newValue);
  end

  def ignore_price_segment
    (self.price_segment_high == self.price_segment_middle) && (self.price_segment_middle == self.price_segment_high);
  end

  def locale_de_shop
    @locale_de_shop || false;
  end

  def locale_de_shop=(newValue)
    Rails.logger.debug "setting locale_de_shop to #{newValue}"
    @locale_de_shop = convert_to_bool(newValue);
  end

  def locale_foreign_shop_de_website
    @locale_foreign_shop_de_website || false;
  end

  def locale_foreign_shop_de_website=(newValue)
    Rails.logger.debug "setting locale_foreign_shop_de_website to #{newValue}"
    @locale_foreign_shop_de_website = convert_to_bool(newValue);
  end

  def locale_foreign_shop_de_delivery
    @locale_foreign_shop_de_delivery || false;
  end

  def locale_foreign_shop_de_delivery=(newValue)
    Rails.logger.debug "setting locale_foreign_shop_de_delivery to #{newValue}"
    @locale_foreign_shop_de_delivery = convert_to_bool(newValue);
  end

  def ignore_locale
    (self.locale_de_shop == self.locale_foreign_shop_de_website) && (self.locale_foreign_shop_de_website == self.locale_foreign_shop_de_delivery);
  end

  def brand_type_single
    @brand_type_single || false;
  end

  def brand_type_single=(newValue)
    Rails.logger.debug "setting brand_type_single to #{newValue}"
    @brand_type_single = convert_to_bool(newValue);
  end

  def brand_type_multi
    @brand_type_multi || false;
  end

  def brand_type_multi=(newValue)
    Rails.logger.debug "setting brand_type_multi to #{newValue}"
    @brand_type_multi = convert_to_bool(newValue);
  end

  def ignore_brand_type
    (self.brand_type_single == self.brand_type_multi);
  end

  def update_filter_settings(settings)
    initialize(settings);
  end

  def get_filter_settings()
    settings = {};
    settings[:price_segment_low]                = self.price_segment_low;
    settings[:price_segment_middle]             = self.price_segment_middle;
    settings[:price_segment_high]               = self.price_segment_high;
    settings[:locale_de_shop]                   = self.locale_de_shop;
    settings[:locale_foreign_shop_de_website]   = self.locale_foreign_shop_de_website;
    settings[:locale_foreign_shop_de_delivery]  = self.locale_foreign_shop_de_delivery;
    settings[:brand_type_single]                = self.brand_type_single;
    settings[:brand_type_multi]                 = self.brand_type_multi;
    settings;
  end

  # TODO: use module with method bool_attr_accessor to auto-type cast filter settings of boolean type and 
  # and continue on using them as boolean (e.g. in conditions below)
  # see: http://stackoverflow.com/questions/11561141/type-cast-an-activerecord-model-virtual-attribute
  def get_filtered_shops(shop_type)
    
    shops = Shop.where(shop_type => true).order(:name);
    
    sub_queries = [];

    if !self.ignore_price_segment
      conditions_price_segment = [];
      if self.price_segment_low
        Rails.logger.debug "include price_segment_low"
        conditions_price_segment << "(price_segment_low = :price_segment_low)"
      end
      if self.price_segment_middle
        Rails.logger.debug "include price_segment_middle"
        conditions_price_segment << "(price_segment_middle = :price_segment_middle)"
      end
      if price_segment_high
        Rails.logger.debug "include price_segment_high"
        conditions_price_segment << "(price_segment_high = :price_segment_high)"
      end
      sub_query_price_segment = "(" << conditions_price_segment.join(" OR ") << ")";
      sub_queries << sub_query_price_segment;
    end
    
    if !self.ignore_locale
      conditions_locale = [];
      if self.locale_de_shop
        Rails.logger.debug "include locale_de_shop"
        conditions_locale << "(locale_de_shop = :locale_de_shop)"
      end
      if self.locale_foreign_shop_de_website
        Rails.logger.debug "include locale_foreign_shop_de_website"
        conditions_locale << "(locale_foreign_shop_de_website = :locale_foreign_shop_de_website)"
      end
      if self.locale_foreign_shop_de_delivery
        Rails.logger.debug "include locale_foreign_shop_de_delivery"
        conditions_locale << "(locale_foreign_shop_de_delivery= :locale_foreign_shop_de_delivery)"
      end
      sub_query_locale = "(" << conditions_locale.join(" OR ") << ")";
      sub_queries << sub_query_locale;
    end
    
    if !self.ignore_brand_type
      conditions_brand_type = [];
      if self.brand_type_single
        Rails.logger.debug "include brand_type_single"
        conditions_brand_type << "(brand_type_single = :brand_type_single)"
      end      
      if self.brand_type_multi
        Rails.logger.debug "include brand_type_multi"
        conditions_brand_type << "(brand_type_multi = :brand_type_multi)"
      end
      sub_query_brand_type = "(" << conditions_brand_type.join(" OR ") << ")";
      sub_queries << sub_query_brand_type;
    end
    complete_query = sub_queries.join(" AND ");

    shops = shops.where(complete_query, get_filter_settings);
    Rails.logger.debug "SQL: #{shops.to_sql}"

    shops.all
  end
end