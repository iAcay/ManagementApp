class Artifact < ApplicationRecord
  before_save :upload_to_s3
  attr_accessor :upload
  belongs_to :project

  MAX_FILE_SIZE = 10.megabytes

  validates :name, :upload, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validate :uploaded_file_size

  private

  def upload_to_s3
    s3 = Aws::S3::Resource.new(
      access_key_id: Rails.application.credentials.dig(:aws, :access_key),
      secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
      region: Rails.application.credentials.dig(:aws, :region))
    account_name = ActsAsTenant.current_tenant.name
    obj = s3.bucket(Rails.application.credentials.dig(:aws, :bucket_name)).object("#{account_name}/#{upload.original_filename}")
    obj.upload_file(upload.path)
    self.key = obj.public_url
  end

  def uploaded_file_size
    if upload
      errors.add(:upload, "File size must be less than #{self.class::MAX_FILE_SIZE}") unless upload.size <= self.class::MAX_FILE_SIZE
    end
  end
end
