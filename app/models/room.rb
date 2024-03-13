class Room < ApplicationRecord
    validates_uniqueness_of :name
    scope :public_rooms, -> {where(is_private: false)}
    after_create_commit {broadcast_if_public }

    has_many :messages
    has_many :participants, dependent: :destroy

    def broadcast_if_public
        broadcast_append_to "rooms" unless self.is_private
            
        end
    end
end
