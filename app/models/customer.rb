class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_products, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :last_name,  presence: true
  validates :first_name, presence: true
  validates :last_name_kana,  presence: true
  validates :first_name_kana, presence: true
  validates :email, presence: true
  validates :postcode,  presence: true
  validates :address, presence: true
  validates :phone_number, presence: true

  # ======= 会員ステータスが有効の場合TRUEを返す =======
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end
