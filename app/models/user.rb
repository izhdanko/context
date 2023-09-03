class User < ApplicationRecord

  attr_accessor :password

  # attr_accessible :email

  email_regex = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  # def show_password
  #   @password
  # end

  # Validations
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: email_regex }
  validates :password, presence: true,
                       confirmation: true, on: :create
  validates :password_confirmation, presence: true

  # validate :custom_validation

  # Associations
  has_many :tasks
  # has_many :tasksss, foreign_key: "user_id"
  # has_many :tasks, class_name: "Item"
  # has_one :task
  # has_and_belongs_to_many :tasks
  # has_many :taskusers
  # has_many :tasks, through: :taskusers

  # class TaskUser
  #   belongs_to :user
  #   belongs_to :task
  # end

  # Callbacks
  before_save :hash_password

  def self.authenticate email, password
    user = where(email: email).first
    if user && user.hashed_password == BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end

  # def email
  #   p 'Email :)'
  # end

  private

  def hash_password
    # puts "[User]: Create hashed password before save user"
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.hashed_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  # def show_message
  #   puts "[User]: Object #{self} has been destroyed"
  # end

  # def to_s
  #   puts "[User]: id=#{id}; email=#{email}"
  # end

  # def custom_validation
  #   errors[:email] << 'Error message' if email == 'space@mail.com'
  #   errors.add :email, I18n.t('error.key') if email == 'space@mail.com'
  #   errors.add :base, I18n.t('error.key') if email == 'space@mail.com'
  # end

end

# u = User.new email: 'example@mail.com', password: '12345678', password_confirmation: '12345678'

# # => hashed_password

# class User

#   def initialize attributes = {}
#     @email = attributes[:email]
#   end

# end

# u = User.new attributes
# # Before create
# # Before save
# u.save!
# # After save
# # Before update
# u.update_attributes
# # After update
# # Before destroy
# u.destroy
# # After destroy

# User.authenticate email, password
# true => user
# false => nil
