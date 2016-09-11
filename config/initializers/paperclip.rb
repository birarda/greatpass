Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:url] = ':s3_alias_url'
Paperclip::Attachment.default_options[:s3_host_alias] = Settings.s3.host_alias
Paperclip::Attachment.default_options[:s3_region] = 'us-west-1'

Paperclip::Attachment.default_options[:s3_credentials] = {
  bucket: Settings.s3.bucket_name,
  access_key_id: ENV['GP_AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['GP_AWS_SECRET_KEY_ID'],
  s3_host_name: 's3-us-west-1.amazonaws.com'
}
