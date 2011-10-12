require './lib/checkout.rb'
require './lib/item.rb'
require './lib/promotional_rules.rb'
 
describe Checkout do
  before(:all) do
    @promotional_rules = PromotionalRules.new()
    @co = Checkout.new(@promotional_rules)
    @item1 = Item.new("001", "Lavander heart", 9.25)
    @item2 = Item.new("002", "Personalised cufflinks", 45)
    @item3 = Item.new("003", "Kids T-shirt", 19.95)
  end

  after(:each) do
    @co.flush
    @item1.qty = 1
    @item2.qty = 1
    @item3.qty = 1
  end
 
  it "001,002,003 total should be: 66.78GBP" do
    @co.scan(@item1)
    @co.scan(@item2)
    @co.scan(@item3)
    @co.total.should == 66.78
  end
 
  it "001,003,001 total should be: 36.95" do
    @co.scan(@item1)
    @co.scan(@item3)
    @co.scan(@item1)
    @co.total.should == 36.95
  end

  it "001,002,001,003 total should be: 73.76" do
    @co.scan(@item1)
    @co.scan(@item2)
    @co.scan(@item1)
    @co.scan(@item3)
    @co.total.should == 73.76
  end
end