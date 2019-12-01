require 'active_support/all'

# 管理者
User.create(name: 'おりばー', email: 'se.sterroristalqaeda@gmail.com', password: 'riverfield', admin: true)

# 一般ユーザを10作成。
10.times do |i|
  name = (1..5).map { ('あ'..'ん').to_a[rand(20)] }.join
  email = ('a'..'z').to_a.shuffle[1..5].join

  User.create(name: name, email: "#{email}-#{i}@gmail.com", password: SecureRandom.base64)
end

concert_name = %w[雅楽 令和 ジャズ ラスト ロック]
local = %w[東京 札幌 大阪 宮崎 台南 Cebu Perth]
artists = []

# 10回分のコンサート、20組分のアーティストを作成
(1..10).each do |n|
  # コンサート開催日として、期間s1 ~ s2までのランダムな年月日を作成
  s1 = Date.new(2019, 11, 1)
  s2 = Date.new(2020, 3, 31)
  s = Random.rand(s1..s2)

  # 出演アーティストをランダムで作成して、配列に入れる。
  # 作成した配列の並びをシャッフルし、先頭から１～５アーティストを取得し、カンマで繋げた文字列に。
  artists << (1..3).map { ('A'..'Z').to_a[rand(20)] }.join.to_s
  who_join = artists.shuffle.take(rand(1..3)).join('、')

  # 例："雅楽コンサート in　東京　出演：BZZ, MON"
  information = "#{concert_name.sample}コンサート in #{local.sample} 出演：#{who_join}"
  Concert.create(information: information, date: s.strftime('%Y/%m/%d'))

  concert = Concert.find(n)
  (0..2).each do |i|
    # seat_price S > A > B
    # prices = [price_s , price_a , price_b]
    # capacity= [sの席数、aの席数、bの席数]
    prices = [[40_000, 35_000, 30_000], [28_000, 25_000, 23_000, 19_000], [18_000, 15_000, 13_000]]
    capacity = [Random.rand(50..100), Random.rand(100..500), Random.rand(500..1000)]
    ConcertDetail.create(concert: concert, grade: i, price: prices[i].sample, capacity: capacity)
  end
end
