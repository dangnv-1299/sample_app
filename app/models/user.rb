class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token, :activation_token, :reset_token

  before_save{email.downcase!}
  before_create :create_activation_digest

  UPDATABLE_ATTRS = %i(name email password password_confirmation).freeze
  validates :name, presence: true, length: {maximum: Settings.user.max_name}
  validates :email, presence: true, length: {maximum: Settings.user.max_email},
                    format: {with: Settings.user.email_regex},
                    uniqueness: true
  has_secure_password
  validates :password, presence: true,
             length: {minimum: Settings.user.min_password}, allow_nil: true

  scope :activated, ->{where activated: true}
  scope :sort_by_name, ->{order :name}

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.blank?

    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.user.deadline_expiration.hours.ago
  end

  def feed
    Micropost.search_by_id(id).recent
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
