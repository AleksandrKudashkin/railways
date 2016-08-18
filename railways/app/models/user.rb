class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable
  validates :first_name, presence: true, length: { in: 2..20 }
  validates :last_name, length: { maximum: 20 }, allow_blank: true
  has_many :tickets
end
