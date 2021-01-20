# frozen_string_literal: true

class Blog < ApplicationRecord
  include GenerateId
  include Crypto
  before_save :encrypt_title
  before_save :encrypt_document
  belongs_to :user

  def title
    if self[:id].present?
      decrypt(self[:title])
    else
      self[:title]
    end
  end

  def document
    if self[:id].present?
      decrypt(self[:document])
    else
      self[:document]
    end
  end

  private

  def encrypt_title
    self.title = encrypt(self[:title])
  end

  def encrypt_document
    self.document = encrypt(self[:document])
  end
end
