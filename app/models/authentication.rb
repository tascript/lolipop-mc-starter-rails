# frozen_string_literal: true

class Authentication < ApplicationRecord
  include GenerateId
  include Crypto
  before_save :create_token
  before_save :encrypt_token
  belongs_to :user

  def token
    if self[:id].present?
      decrypt(self[:token])
    else
      self[:token]
    end
  end

  private

  def encrypt_token
    self.token = encrypt(self[:token])
  end

  def create_token
    self.token = encrypt(SecureRandom.urlsafe_base64)
  end
end
