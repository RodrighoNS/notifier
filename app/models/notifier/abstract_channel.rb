module Notifier
  class AbstractChannel < ApplicationRecord
    self.abstract_class = true
    self.inheritance_column = nil  # Disable STI completely

    # Polymorphic relationship - a channel can have many notifications
    has_many :notifications, as: :channel, dependent: :destroy

    validates :name, presence: true, uniqueness: true

    # Convention-based method that all channels must implement
    def self.default
      find_or_create_by(name: default_name)
    end

    # Default naming convention - subclasses can override
    def self.default_name
      "Default #{name.demodulize.gsub('Channel', '')} Channel"
    end
  end
end
