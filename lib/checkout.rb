class Checkout
  attr_accessor :items, :promotional_rules

  def initialize(promotional_rules)
    @promotional_rules = promotional_rules.rules
  end

  def scan(item)
    found = nil
    if @items
      @items.each do |i|
        if i.code == item.code
          found = i
          found.qty += 1
        end
      end
    else
      @items = Array.new
    end
    @items << item unless found
  end

  def flush
    @items = nil
  end

  def total
    total = 0
    @items.each do |i|
      price = i.price
      if @promotional_rules["buy_more"] && @promotional_rules["buy_more"][i.code]
        if @promotional_rules["buy_more"][i.code][0] <= i.qty
          price = @promotional_rules["buy_more"][i.code][1]
        end
      end
      total = total + (price * i.qty)
    end

    multiplier = 1
    if @promotional_rules["spent_over"]
      @promotional_rules["spent_over"].each do |so|
        multiplier = so[1] if so[0] < total
      end
    end

    (total * multiplier).round(2)
  end
  
end