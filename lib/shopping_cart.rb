class ShoppingCart
  attr_reader :name,
              :capacity,
              :products
  def initialize(name, capacity)
    @name = name
    @capacity = capacity.delete('items').to_i
    @products = []
  end

  def add_product(product)
    @products << product
  end

  def details
    {
      name: @name,
      capacity: @capacity
    }
  end

  def total_number_of_products
    @products.reduce(0) do |total_products, product|
      total_products + product.quantity
    end
  end

  def is_full?
    total_number_of_products > @capacity
  end

  def products_by_category(category)
    @products.select do |product|
      product.category == category
    end
  end

  def percentage_occupied
    ((total_number_of_products.to_f / @capacity) * 100).round(2)
  end

  def sorted_products_by_quantity
    @products.sort_by do |product|
      -product.quantity
    end
  end

  def product_breakdown
    product_breakdown_hash = Hash.new
    @products.each do |product|
      if !product_breakdown_hash[product.category]
        product_breakdown_hash[product.category] = [product]
      else
        product_breakdown_hash[product.category] << product
      end
    end
    product_breakdown_hash
  end
end