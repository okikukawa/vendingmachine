# irb
# require '/Users/mlkuri/workspace/vm/sample.rb'

class DrinkHolder
  def initialize
    @coke = [{name: "コーラ",  price:120}] * 5
    @water = [{name: "水",  price:100}] * 5
    @redbull = [{name: "レッドブル",  price:200}] * 5
    @drink = []
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

class Money
  MONEY = [10, 50, 100, 500, 1000].freeze
  def self.is_valid(money)
    if MONEY.include?(money)
      return true
    end
  end
end

class Operation
  def initialize(drink_holder)
    @drink_list = drink_holder
    @slot_money = 0
    @sale = 0
  end
  def purchase
    drink_number = gets.to_i
    @drink = self.select_drink(drink_number)
    if @drink.nil?
      puts "この商品は品切れのため購入できません"
    elsif @slot_money >= @drink[0][:price]
      # @sale += @drink[0][:price]
      puts "#{@drink[0][:name]}を購入しました"
      puts "売上金額:#{@sale}円"
      @slot_money -= @drink[0][:price]
      @drink.shift
    else
      puts "この商品は購入できません"
    end
  end

  def select_drink(number)
    index = ["---------------------",
             "以下の中から購入する商品の番号を入力してください",
             "1:コーラ",
             "2:水",
             "3:レッドブル",
             "---------------------"]
    index.each do |navigation|
      puts navigation
    end
    self.drink_holder.pickup(number)
  end

  def can_purchase_coke?
    if @slot_money >= 120 && @coke.size >= 1
      @coke[0][:name]
    end
  end
  def can_purchase_water?
    if @slot_money >= 100 && @water.size >= 1
      @water[0][:name]
    end
  end
  def can_purchase_redbull?
    if @slot_money >= 200 && @redbull.size >= 1
      @redbull[0][:name]
    end
  end

  def can_purchase_list
    puts "購入できる飲み物:#{self.can_purchase_coke?} #{self.can_purchase_water?} #{self.can_purchase_redbull?}"
    puts <<~EOS
    現在の投入金額：#{@slot_money}円
    コーラ：#{@coke.size}本
    水：#{@water.size}本
    レッドブル：#{@redbull.size}本
    EOS
  end

  def select_drink(number)
    puts “投入金額を入力してください(10、50、100、500、1000のいずれかの数値)”
    self.drink_holder.pickup(number)
  end

  def current_slot_money
    puts "現在の投入金額は#{@slot_money}円です"
  end

  def slot_money(coin)
    puts "投入金額を入力してください(10、50、100、500、1000のいずれかの数値)"
    coin = gets.to_i
    if Money.is_valid(coin)
      @slot_money += coin
    else
      puts "想定外のものが入力されたため返却します"
      puts "#{coin}円を返却しました"
    end
  end

  def return_money
    puts "お釣りは#{@slot_money}円です"
    @slot_money = 0
  end
end

class VendingMachine

  vm = VendingMachine.new
  drink = DrinkHolder.new
  money = Money.new
  operation = Operation.new

  while true
    index = ["---------------------",
             "以下の中から行う操作を選んでください",
             "1:お金を入れる",
             "2:飲み物を買う",
             "3:購入できる商品を確認する",
             "4:売上金額を確認する",
             "5:購入をやめる",
             "---------------------"]
    index.each do |navigation|
      puts navigation
    end
    number = gets.to_i
    case number
    when 1
      money.slot_money(coin)
      money.current_slot_money
    when 2
      operation.purchase
    when 3
      operation.can_purchase_list
    when 4
      money.earnings
    when 5
      puts "購入を終了します"
      money.return_money
      break
    else
      puts "1~5の数字を入力してください"
    end
  end
end
