class Operation
  def initialize(drink_holder)
    @drink_list = drink_holder
    @slot_money = 0
    @sale = 0
  end

  def purchase
    index = ["---------------------",
             "以下の中から購入する商品の番号を入力してください",
             "1:コーラ 120円",
             "2:水 100円",
             "3:レッドブル 200円",
             "---------------------"]
    index.each do |navigation|
      puts navigation
    end
    drink_number = gets.to_i
    @drink = self.select_drink(drink_number)
    if @drink.nil?
      puts "この商品は購入できません"
    elsif @slot_money >= @drink[0][:price]
      puts "#{@drink[0][:name]}を購入しました"
      # puts "売上金額:#{@sale}円"
      @slot_money -= @drink[0][:price]
      @sale = @drink[0][:price]
      @drink.shift
      self.return_money
      return @sale
    else
      puts "この商品は購入できません"
    end
  end

  def return_money
    puts "お釣りは#{@slot_money}円です"
  end

  def select_drink(number)
    @drink_list.pickup(number)
  end

  def add_money
    puts "投入金額を入力してください(10、50、100、500、1000のいずれかの数値)"
    coin = gets.to_i
    if Money.is_valid(coin)
      @slot_money += coin
    else
      puts "想定外のものが入力されたため返却します"
      puts "#{coin}円を返却しました"
    end
  end

  def can_purchase_list
    puts "現在の投入金額：#{@slot_money}円"
    @drink_list.drink_stock
  end
end
