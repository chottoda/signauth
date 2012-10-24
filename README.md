# Signauth

Signature authentication.

## Installation

Add this line to your application's Gemfile:

    gem 'signauth'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install signauth

## Examples

Client example

```ruby
credentials = Signauth::Credentials.new('my_key', 'my_secret')
http_method = "GET"
host        = "localhost"
path        = "/action"
params      = { "some" => "param" }
sig_version = 1

req = Signauth::Request.new( http_method, host, path, params, sig_version)
req.add_authorization!(credentials)

p req.params # => {"some"=>"param", "access_key_id"=>"my_key", "signature_version"=>"1", "signature_method"=>"HMAC-SHA-256", "signature"=>"7JNcJhJuzcUAGj6azz2wslmqnVomhDIFXZzpXZR1nkI="}

HTTParty.get('http://localhost/action', { :query => req.params })
```

Server example (rails)

```ruby
request; # ActionController::Request object

begin
  access_key_id = request.query_parameters['access_key_id']
  credentials   = Signauth::Credentials.new(access_key_id, lookup_secret(access_key_id))

  req = Signauth::Request.new(
          request.request_method,
          request.domain,
          request.path,
          request.query_parameters)
  req.authenticate(credentials)
rescue => e
  render :status => :unauthorized, :text => "401 UNAUTHORIZED: #{e.message}\n"
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
