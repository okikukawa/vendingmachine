# $ ruby test/vendingmachine_test.rb でテストを実行
require 'minitest/autorun'
require './vendingmachine.rb'
require './money.rb'
require './drinkholder.rb'
require './operation.rb'

class VendingmachineTest < Minitest::Test
  def setup
    @vending_machine = VendingMachine.new
  end

  def test_vending_machine_new_自動販売機のインスタンスが作成できるか
    assert VendingMachine.new
  end

  def test_add_money_500_投入金額が500円になるか
    $stdin = Object.new
    def $stdin.gets
      "500"
    end
    # coin = gets.to_i の入力値を５００に設定($stdinで標準入力ができる)
    # https://docs.ruby-lang.org/ja/latest/method/Kernel/v/stdin.html
    assert_equal 500, @vending_machine.add_money
  end

  def test_add_money_600_600円を投入するとお金を返却するか
    $stdin = Object.new
    def $stdin.gets
      "600"
    end
    refute @vending_machine.add_money
  end
end
