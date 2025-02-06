require 'aws-sdk-core'

Aws.config.update({
  region: 'us-west-004',
  endpoint: 'https://s3.us-west-004.backblazeb2.com',
  credentials: Aws::Credentials.new(Rails.application.credentials.dig(:aws, :access_key_id),
                                    Rails.application.credentials.dig(:aws, :secret_access_key))
})
