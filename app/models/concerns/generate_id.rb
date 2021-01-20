# frozen_string_literal: true

module GenerateId
  def self.included(model)
    model.before_create :set_id
  end

  def set_id
    self.id = SecureRandom.uuid
  end
end
