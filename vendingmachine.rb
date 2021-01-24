# irb
# require '/Users/mlkuri/workspace/vm/sample.rb'
require './money.rb'
require './drinkholder.rb'
require './operation.rb'

class VendingMachine
  def initialize
    @total_sales = 0
    @total_money = 0
    @current_operation
    @drink_holder = DrinkHolder.new
  end

  def total_sales
    puts "現在の売上金額は#{@total_sales}円です"
  end

  def add_money
    if @current_operation.nil?
      @current_operation = Operation.new(@drink_holder)
    end
    result = @current_operation.add_money
    @total_money += result
  end

  def purchase_drink
    if @current_operation.nil?
      @current_operation = Operation.new(@drink_holder)
    end
    result = @current_operation.purchase
    if result.class == Integer
      @total_sales += result
      @total_money -= result
      @current_operation = nil
    else
      result
    end
  end

  def disply_buyable
    if @current_operation.nil?
      @current_operation = Operation.new(@drink_holder)
    end
    @current_operation.can_purchase_list
  end

  def exit_operation
    puts "購入を終了します"
    puts "お釣りは#{@total_money}円です"
  end

  vending_machine = VendingMachine.new
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
      vending_machine.add_money
    when 2
      vending_machine.purchase_drink
    when 3
      vending_machine.disply_buyable
    when 4
      vending_machine.total_sales
    when 5
      vending_machine.exit_operation
      break
    else
      puts "1~5の数字を入力してください"
    end
  end
end
