def update_quality(items)
  items.each do |item|
    unless item.name == 'Sulfuras, Hand of Ragnaros'
      case item.name
      when 'Backstage passes to a TAFKAL80ETC concert'
        if item.quality < 50
          item.quality += 1
          if item.quality < 50
            case item.sell_in
            when 6 .. 10
              item.quality += 1
            when 0 .. 5
              item.quality += 2
            end
          end
        end
        if item.sell_in < 1
          item.quality = 0
        end
      when 'Aged Brie'
        if item.quality < 50
          item.quality += 1
        end
        if item.sell_in < 1 && item.quality < 50
          item.quality += 1
        end
      when 'Conjured Mana Cake'
        if item.quality > 0
          item.quality -= 2
        end
        if item.sell_in < 1 && item.quality > 0
          item.quality -= 2
        end
      else
        if item.quality > 0
          item.quality -= 1
        end
        if item.sell_in < 1 && item.quality > 0
          item.quality -= 1
        end
      end
      item.sell_in -= 1
    end
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]
