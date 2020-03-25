class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_create :set_public_id

  private
  	def set_public_id
  		# id未設定、または、すでに同じpublic_idのレコードが存在する場合はループに入る
    	while self.public_id.blank? || User.find_by(public_id: self.public_id).present? do
        	# ランダムな20文字をpublic_idに設定し、whileの条件検証に戻る
        	self.public_id = SecureRandom.alphanumeric(20)
    	end
  	end
end
