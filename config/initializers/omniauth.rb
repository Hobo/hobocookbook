# Hack to work around http://stackoverflow.com/questions/3977303/omniauth-facebook-certificate-verify-failed
# since we're just redirecting to public URL's, this is safe for us, but it probably ISN'T safe for anybody else
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE 
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
end
