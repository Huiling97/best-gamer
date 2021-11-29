class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :coach_games

  validates :email, presence: true, uniqueness: true, format: { with: /\w+(\.\w+)?@\w+.\w{2,3}/ }
  validates :password, presence: true
  validates :username, uniqueness: true
  validates :rates, numericality: true, allow_nil: true
end
