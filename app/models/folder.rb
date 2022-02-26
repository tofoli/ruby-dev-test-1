class Folder < ApplicationRecord
  belongs_to :folder, required: false
  has_many :folders

  has_many_attached :files

  validates :label, presence: true, uniqueness: { scope: :folder_id }

  scope :root, -> { where(folder_id: nil) }
end
