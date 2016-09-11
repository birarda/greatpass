Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:url] = ':s3_alias_url'
Paperclip::Attachment.default_options[:s3_host_alias] = Settings.s3.host_alias
Paperclip::Attachment.default_options[:s3_region] = 'us-west-1'
Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-1.amazonaws.com'
