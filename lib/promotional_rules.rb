class PromotionalRules
  attr_accessor :rules
  def initialize
    # Readed from config file (yaml, xml) in production environment
    # We can catch the config file url from the constructor parameter
    @rules = {
      "spent_over" => [ [60, 0.9], [1200, 0.6] ],
      "buy_more" => {"001" => [2, 8.50]}
    }
  end
end