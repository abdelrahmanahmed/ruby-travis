class Group < ApplicationRecord
  belongs_to :user
  has_many :group_users, dependent: :destroy

def set_user!(user)
 self.user_id=user.id
 self.save!
end
end
