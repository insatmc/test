def update_quality(items)
  items.each do |item|
    unless item.name == 'Sulfuras, Hand of Ragnaros'
      case item.name
      when 'Backstage passes to a TAFKAL80ETC concert'
        config = [
          {
            sell_in: [11, "*"],
            action: 'INC',
            value: 1
          },
          {
            sell_in: [6, 10],
            action: 'INC',
            value: 2
          },
          {
            sell_in: [1, 5],
            action: 'INC',
            value: 3
          },
          {
            sell_in: ["*", 0],
            action: 'SET',
            value: 0
          }
        ]
      when 'Aged Brie'
        config = [
          {
            sell_in: [1, "*"],
            action: "INC",
            value: 1
          },
          {
            sell_in: ["*", 0],
            action: "INC",
            value: 2
          }
        ]
      when 'Conjured Mana Cake'
        config = [
          {
            sell_in: [1, "*"],
            action: "DEC",
            value: 2
          },
          {
            sell_in: ["*", 0],
            action: "DEC",
            value: 4
          }
        ]
      else
        config = [
          {
            sell_in: [1, "*"],
            action: "DEC",
            value: 1
          },
          {
            sell_in: ["*", 0],
            action: "DEC",
            value: 2
          }
        ]
      end
      calculate_quality(item, config)
      item.sell_in -= 1
    end
  end
end


def calculate_quality(item, config)
  config.each do |c|
    if c[:sell_in].length == 2
      if c[:sell_in][0].instance_of?(String) && c[:sell_in][0] == "*" && item.sell_in <= c[:sell_in][1]
        change_quality(item, c[:action], c[:value])
        break
      elsif c[:sell_in][1].instance_of?(String) && c[:sell_in][1] == "*" && item.sell_in >= c[:sell_in][0]
        change_quality(item, c[:action], c[:value])
        break
      elsif c[:sell_in][0].instance_of?(String) == false &&
            c[:sell_in][1].instance_of?(String) == false &&
            item.sell_in >= c[:sell_in][0] &&
            item.sell_in <= c[:sell_in][1]
        change_quality(item, c[:action], c[:value])
        break
      end
    else
      raise 'Invalide interval!'
    end
  end
end


def change_quality(item, action, value)
  case action
  when "INC"
    if item.quality < ( 50 - value )
      item.quality += value
    else
      item.quality = 50
    end
  when "DEC"
    if item.quality > ( 0 + value )
      item.quality -= value
    else
      item.quality = 0
    end
  when "SET"
    item.quality = value
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
