# 現実世界でそのシステムを手動でやろうと、流れ、機能
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
  def drink_list
    ["コーラ", "水", "レッドブル"]
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
    if (@drink.nil?)
      return puts "この商品は購入できません"
    end
    if @slot_money >= @drink[0].price
      puts "#{@drink[0][:name]}を購入しました"
      @drink.shift
      puts "売上金額:#{@drink[0].price}円"
      @sale = @drink[0].price
      return { change: @slot_money - @drink[0].price }
    end
  end
  def add_money
    money_num = gets.to_i
    if !Money.is_valid(money_num)
      puts "想定外のものが入力されたため返却します"
      puts "#{money}円を返却しました"
    end
    @slot_money += money
  end
  def can_purchase_list
    puts　"購入できる飲み物:#{self.can_purchase_coke?} #{self.can_purchase_water?} #{self.can_purchase_redbull?}"
    puts <<~EOS
    現在の投入金額：#{@slot_money}円
    コーラ：#{@drink_list.coke.size}本
    水：#{@drink_list.water.size}本
    レッドブル：#{@drink_list.redbull.size}本
    EOS
  end
  private
  def can_purchase_coke?
    if @slot_money >= 120 && @drink_list.coke.size >= 1
      @coke[0][:name]
    end
  end
  def can_purchase_water?
    if @slot_money >= 100 && @drink_list.water.size >= 1
      @water[0][:name]
    end
  end
  def can_purchase_redbull?
    if @slot_money >= 200 && @drink_list.redbull.size >= 1
      @redbull[0][:name]
    end
  end
  def select_drink(number)
    puts "投入金額を入力してください(10、50、100、500、1000のいずれかの数値)"
    self.drink_holder.pickup(number)
  end
end
class VendingMachine
  def initialize
    @operations = []
    @current_operation
    @drink_holder = new DrinkHolder
  end
  def totalSale
    @operations.map(
      # operation.saleの総和を求める
    )
  end
  def add_money
    if @current_operation.nil?
      @current_operation = new Operation(@drink_holder)
    end
    @current_operation.add_money()
  end
  def purchase_drink
    if @current_operation.nil?
      @current_operation = new Operation(@drink_holder)
    end
    result = @current_operation.purchase()
    if result.change.nil?
    end
    @operations.push(@current_operation)
    @current_operation = nil
  end
  def disply_buyable
    if @current_operation.nil?
      @current_operation = new Operation(@drink_holder)
    end
    @current_operation.can_purchase_list()
  end
  def exit_operation
    puts "5"
    puts "購入を終了します"
    puts "お釣りは0円です"
  end
end
def main
  vending_machine = new VendingMachine
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
      vending_machine.add_money()
    when 2
      vending_machine.purchase_drink()
    when 3
      vending_machine.disply_buyable()
    when 4
      vending_machine.totalSale()
    when 5
      return vending_machine.exit_operation()
    else
      puts "1~5の数字を入力してください"
    end
 end
end
