#  require 'active_support/all'

# namespace :manage_unpaid_ticket do
#   desc "seek unpaid and over-deadline records on Sale and create Payment records as unpaid "
#   task manage_record_over deadline: :environment do
#     # バッチ処理日が支払期限日+1日となる販売表レコードを探す
#     records_over_deadline = Sale.where(payment_deadline: Date.current - 1.days)
#     records_over_payment_deadline.each do |record|
#       # 該当recordのidが決済表テーブルに存在しなかったら
# 	    if Payment.find(id: record.id).nil?
#         Payment.new(sale: sale.id, date: Null, payment: -1)
#         Payment.save
# 	    end
#     end
#   end 
# end
