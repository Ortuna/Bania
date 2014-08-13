class S3Uploader
  attr_reader :content

  def initialize(content)
    @content = content
  end

  def perform
    object = s3_object
    object.content_type = "image/jpeg"
    object.content = content
    object.save
  end

  private
  def random_hex
    "#{SecureRandom.hex}.jpg"
  end

  def s3_object
    s3_bucket
      .objects.build(random_hex)
  end

  def s3_bucket
    bucket = Rails.application.config.s3_bucket
    key    = Rails.application.config.s3_key
    secret = Rails.application.config.s3_secret

    service = S3::Service.new(access_key_id: key,
      secret_access_key: secret,
      use_ssl: true)

    service.buckets.find(bucket)
  end
end
