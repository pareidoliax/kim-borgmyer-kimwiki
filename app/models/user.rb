class User < ActiveRecord::Base
  after_initialize :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :collaborations
  has_many :wikis, through: :collaborations

  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end

  def premium?
    role == 'member' && premium
  end

  def standard?
    !admin? && !moderator? && !premium?
  end
  
  private

  def assign_default_role
    self.role ||= 'member'
  end
end
