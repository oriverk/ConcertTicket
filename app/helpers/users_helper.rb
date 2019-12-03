# frozen_string_literal: true

module UsersHelper
  def newLineConcertInfo(sale)
    str = Concert.find(sale.concert_id).information.split('出演：')
    str[0] << "\r\n"
    str.join
  end
end
