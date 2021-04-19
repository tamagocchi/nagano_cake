class Order < ApplicationRecord

  enum payment_method: {クレジットカード:1, 銀行振込:2}
  enum destination: {ご自身の住所:1, 登録住所からの選択:2, 新しいお届け先:3}

end
