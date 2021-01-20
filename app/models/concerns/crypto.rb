# frozen_string_literal: true

module Crypto
  def encrypt(value)
    crypt = ActiveSupport::MessageEncryptor.new(ENV['COLUMN_ENCRYPT_KEY'])
    crypt.encrypt_and_sign(value)
  end

  def decrypt(encrypted)
    crypt = ActiveSupport::MessageEncryptor.new(ENV['COLUMN_ENCRYPT_KEY'])
    crypt.decrypt_and_verify(encrypted)
  end
end
