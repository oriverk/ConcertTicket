# frozen_string_literal: true

# concert
# 20回分のコンサート、20組分のアーティストを作成
require 'active_support/all'
# 管理者
User.create!(name: 'おりばー', email: 'se.sterroristalqaeda@gmail.com', password: 'riverfield', admin: true)

# 一般ユーザ。とりあえず、20人作る。
20.times do |i|
  name = (1..5).map { ('あ'..'ん').to_a[rand(20)] }.join
  email = ('a'..'z').to_a.shuffle[1..5].join

  User.create!(name: name, email: "#{email}-#{i}@gmail.com", password: SecureRandom.base64)
end

concert_name = %w[雅楽 令和 ジャズ ラスト ロック アニソン]
local = %w[東京 札幌 名古屋 大阪 広島 宮崎 台南 Cebu Perth]
artists = []

# 20回分のコンサート、20組分のアーティストを作成
(1..20).each do |n|
  # コンサート開催日として、期間s1 ~ s2までのランダムな年月日を作成
  s1 = Date.new(2019, 5, 31)
  s2 = Date.new(2020, 3, 31)
  s = Random.rand(s1..s2)

  # 出演アーティストをランダムで作成して、配列に入れる。
  # 作成した配列の並びをシャッフルし、先頭から１～５アーティストを取得し、カンマで繋げた文字列に。
  artists << (1..3).map { ('A'..'Z').to_a[rand(20)] }.join.to_s
  who_join = artists.shuffle.take(rand(1..5)).join('、')

  # 試験問題の"クリスマスコンサート2018 in　東京　出演：Xバンド・・・"の表記に沿ってあげる。
  infomation = "#{concert_name.sample}コンサート #{s.strftime('%Y')} in #{local.sample} 出演：#{who_join}"
  # コンサート情報の開催年と、開催日時が合致するよう。
  Concert.create!(infomation: infomation, date: s.strftime('%Y-%-m-%-d'))

  concert = Concert.find(n)
  (0..2).each do |i|
    # seat_price S > A > B
    # prices = [price_s , price_a , price_b]
    # capacity= [sの席数、aの席数、bの席数]
    prices = [[40000, 35000, 30_000], [28000, 25000, 23000, 19000], [18000, 15000, 13000, 11000, 9000]]
    capacity = [Random.rand(50..100), Random.rand(100..500), Random.rand(500..1000)]
    ConcertDetail.create!(concert: concert, grade: i, price: prices[i].sample, capacity: capacity[i])
  end
end
