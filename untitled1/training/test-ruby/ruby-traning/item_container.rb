require_relative 'item_container.rb'

module ItemContaine

  def add_item(item)
    @items.push item unless item.price < self.class.min_price
  end

  def remove_item
    @items.pop
  end

  def validate
    @items.each do |i|
      puts 'Item has no price' if i.price.nil?
    end
  end

  def delete_invalid_items
    @items.delete_if { |i| i.price.nil? }
  end

  def count_valid_items
    @items.count { |i| i.price }
  end
end

