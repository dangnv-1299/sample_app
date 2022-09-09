class User < ApplicationRecord
  before_save{email.downcase!}
  UPDATABLE_ATTRS = %i(name email password password_confirmation).freeze
  validates :name, presence: true, length: {maximum: Settings.user.max_name}
  validates :email, presence: true, length: {maximum: Settings.user.max_email},
                    format: {with: Settings.user.email_regex},
                    uniqueness: true
  has_secure_password
  validates :password, presence: true,
             length: {minimum: Settings.user.min_password}
end
