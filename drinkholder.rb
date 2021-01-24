class DrinkHolder
  def initialize
    @coke = [{name: "コーラ",  price:120}] * 5
    @water = [{name: "水",  price:100}] * 5
    @redbull = [{name: "レッドブル",  price:200}] * 5
    @drink = []
  end

  def drink_stock
    puts <<~EOS
    コーラ：#{@coke.size}本
    水：#{@water.size}本
    レッドブル：#{@redbull.size}本
    EOS
  end

  def pickup(number)
    case number
    when 1
      if @coke.size > 0
        return @coke
      end
    when 2
      if @water.size > 0
        return @water
      end
    when 3
      if @redbull.size > 0
        return @redbull
      end
    else
      return nil
    end
  end
end
