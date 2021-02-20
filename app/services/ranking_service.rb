class RankingService

  # 売買金額ランキング
  def self.rankers_by_trading_amount(users)
    
  end
  
  # 売買件数ランキング
  def self.rankers_by_trading_count(users)
    
  end
  
  # 売上金額ランキング
  def self.rankers_by_sales_amount(users)
    
  end

  # 売上件数ランキング
  def self.rankers_by_sale_count(users)
    # ranking = []
    # users.each do |user|
    #   sale_count = {user_nickname: user.nickname, user_avatar: user.avatar, orders: user.purchases.count}
    #   ranking << order_count
    # end
    # # 購入数が多い順（降順）に並べ替え
    # ranking = ranking.sort_by { |ranker| ranker[:orders] }.reverse.slice(0, 3)
    # return ranking
  end

  # 購入金額ランキング
  def self.rankers_by_orders_amount(users)
    ranking = []
    users.each do |user|
      amount = 0
      user.purchases.each do |purchase|
        amount += purchase.item.price
      end
      order_amount = {user_nickname: user.nickname, user_avatar: user.avatar, orders: amount.to_s(:delimited, delimiter: ',')}
      ranking << order_amount
    end
    # 購入数が多い順（降順）に並べ替え
    ranking = ranking.sort_by { |ranker| ranker[:orders] }.reverse.slice(0, 3)
    return ranking
  end
  
  # 購入件数ランキング
  def self.rankers_by_order_count(users)
    ranking = []
    users.each do |user|
      order_count = {user_nickname: user.nickname, user_avatar: user.avatar, orders: user.purchases.count}
      ranking << order_count
    end
    # 購入数が多い順（降順）に並べ替え
    ranking = ranking.sort_by { |ranker| ranker[:orders] }.reverse.slice(0, 3)
    return ranking
  end

end