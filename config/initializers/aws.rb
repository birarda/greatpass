Aws.config.update({
  region: 'us-west-1',
  credentials: Aws::Credentials.new(ENV['GP_AWS_ACCESS_KEY_ID'], ENV['GP_AWS_SECRET_KEY_ID'])
})
