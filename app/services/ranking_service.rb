class RankingService

  def self.show_rankers_by_orders(users)
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