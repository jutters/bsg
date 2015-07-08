class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  has_secure_password

  after_destroy :ensure_an_admin_remains

  has_many :shop_favorites, dependent: :destroy

private

  def ensure_an_admin_remains
  	if User.count.zero?
  	  raise "Can't delete last user"
  	end
  end

end
