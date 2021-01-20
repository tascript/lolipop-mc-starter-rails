# frozen_string_literal: true

class User < ApplicationRecord
  include GenerateId
  include Crypto
  has_secure_password
  before_save :encrypt_email
  before_save :create_token
  has_many :users
  has_one :authenticate

  validates :name, length: { minimum: 1 }
  validates :password, length: { in: 8..50 }

  def email
    if self[:id].present?
      decrypt(self[:email])
    else
      self[:email]
    end
  end

  def token
    if self[:id].present?
      decrypt(self[:token])
    else
      self[:token]
    end
  end

  def authed?(value)
    token == value
  end

  private

  def encrypt_email
    self.email = encrypt(self[:email])
  end

  def create_token
    self.token = encrypt(SecureRandom.urlsafe_base64)
  end
end
