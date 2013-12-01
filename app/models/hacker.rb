class Hacker < ActiveRecord::Base
  has_many :solutions, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true,
                   length: { minimum: 1, maximum: 20 },
                   format: { with: /\A[a-z0-9_-]+\Z/ }
end
