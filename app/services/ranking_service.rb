class RankingService
  # 売買金額ランキング
  def self.rankers_by_trading_amount(users)
    ranking = []
    users.each do |user|
      amount = 0
      user.items.each do |item|
        amount += item.price if item.purchase
      end
      user.purchases.each do |purchase|
        amount += purchase.item.price
      end
      trading_amount = { user_id: user.id, user_nickname: user.nickname, user_avatar: user.avatar, amount: amount }
      ranking << trading_amount
    end
    # 売買金額が多い順（降順）に並べ替え
    ranking.sort_by { |ranker| ranker[:amount] }.reverse.slice(0, 3)
  end

  # 売買件数ランキング
  def self.rankers_by_trading_count(users)
    ranking = []
    users.each do |user|
      count = 0
      user.items.each do |item|
        count += 1 if item.purchase
      end
      count += user.purchases.count
      trading_count = { user_id: user.id, user_nickname: user.nickname, user_avatar: user.avatar, tradings: count }
      ranking << trading_count
    end
    # 売買件数が多い順（降順）に並べ替え
    ranking.sort_by { |ranker| ranker[:tradings] }.reverse.slice(0, 3)
  end

  # 売上金額ランキング
  def self.rankers_by_sales_amount(users)
    ranking = []
    users.each do |user|
      amount = 0
      user.items.each do |item|
        amount += item.price if item.purchase
      end
      sale_amount = { user_id: user.id, user_nickname: user.nickname, user_avatar: user.avatar, amount: amount }
      ranking << sale_amount
    end
    # 売上件数が多い順（降順）に並べ替え
    ranking.sort_by { |ranker| ranker[:amount] }.reverse.slice(0, 3)
  end

  # 売上件数ランキング
  def self.rankers_by_sale_count(users)
    ranking = []
    users.each do |user|
      count = 0
      user.items.each do |item|
        count += 1 if item.purchase
      end
      sale_count = { user_id: user.id, user_nickname: user.nickname, user_avatar: user.avatar, sales: count }
      ranking << sale_count
    end
    # 売上件数が多い順（降順）に並べ替え
    ranking.sort_by { |ranker| ranker[:sales] }.reverse.slice(0, 3)
  end

  # 購入金額ランキング
  def self.rankers_by_orders_amount(users)
    ranking = []
    users.each do |user|
      amount = 0
      user.purchases.each do |purchase|
        amount += purchase.item.price
      end
      order_amount = { user_id: user.id, user_nickname: user.nickname, user_avatar: user.avatar, amount: amount }
      ranking << order_amount
    end
    # 購入金額が多い順（降順）に並べ替え
    ranking.sort_by { |ranker| ranker[:amount] }.reverse.slice(0, 3)
  end

  # 購入件数ランキング
  def self.rankers_by_order_count(users)
    ranking = []
    users.each do |user|
      order_count = { user_id: user.id, user_nickname: user.nickname, user_avatar: user.avatar, orders: user.purchases.count }
      ranking << order_count
    end
    # 購入件数が多い順（降順）に並べ替え
    ranking.sort_by { |ranker| ranker[:orders] }.reverse.slice(0, 3)
  end
end
