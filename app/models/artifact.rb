class Artifact < ApplicationRecord
  attr_accessor :upload
  belongs_to :project

  MAX_FILE_SIZE = 10.megabytes

  validates :name, :upload, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validate :uploaded_file_size

  private

  def uploaded_file_size
    if upload
      errors.add(:upload, "File size must be less than #{self.class::MAX_FILE_SIZE}") unless upload.size <= self.class::MAX_FILE_SIZE
    end
  end
end
