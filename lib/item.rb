class Item
  attr_accessor :code, :name, :price, :qty
  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price
    @qty = 1
  end
end