# BS::JWT

Simple library for verifying Auth0 JWTs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bs-jwt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bs-jwt

## Usage

Set the auth0 domain (in an initializer).

```ruby
  BsJwt.auth0_domain = ENV.fetch('AUTH0_DOMAIN', 'reverse-retail.eu.auth0.com')
```

Decode a JWT token:

```ruby
  jwt_token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6Ik5FTTNNRFZGTlRZME5VTkRRVEpEUWtFeE5rRkJSamhET0RBMlF6Y3hOemd4TkRrNU1FRXh' \
    'SUSJ9.eyJodHRwczovL2J1ZGR5LmJ1ZGR5YW5kc2VsbHkuY29tL2J1ZGR5X2lkIjozMzcsImh0dHBzOi8vYnVkZHkuYnVkZHlhbmRzZWxseS5jb20vc' \
    'm9sZXMiOlsiYWRtaW4iXSwibmlja25hbWUiOiJKYW5uaWsgR3JhdyIsIm5hbWUiOiJqLmdyYXdAYnVkZHlhbmRzZWxseS5jb20iLCJ1cGRhdGVkX2F0' \
    'IjoiMjAxOC0wNi0yMlQwOToxMDoyNS45NDhaIiwiaXNzIjoiaHR0cHM6Ly9yZXZlcnNlLXJldGFpbC5ldS5hdXRoMC5jb20vIiwic3ViIjoiYXV0aDB' \
    '8NGUzYTJmZWY3MWI1NzE5NjFjMWIyMjkiLCJhdWQiOiJDdE9kbDVkMERVNE9HMWJEdEZmT3ZWbFVoN0YxODlHMiIsImlhdCI6MTUyOTY1ODYyOSwiZX' \
    'hwIjoxNTI5Njk0NjI5fQ.omtjxv_4OJ1gG3RnfsBRn7jBY1oLExYcOrKKIrDIBKdtYoBtzbNZuLfXi2rfEnBMEd3f-MNPU9Ynot6VF6Ps16-V_LHGWb' \
    'jr4trkt2ACrXUKcg7cc3hxiMVauj2ehoofzsWXY78BGCZKXFWyUidnLcLBgY2yhAhTds5eWQpi7MOpDVTQqIcXuRpidS499myZnw0hueyztuM9yUhuN' \
    'E6l_ygqEglgQ8qr0p6ljiZvQ1lq6w_alOvzyfqRP4a5ClKM7LzlnP5DCsUJN1qJdoPhJNYyjxu7H-1qxJtJaaBoD74-dX3-bYkinSRqfro19tD0FSON' \
    'TOfdwWc1XPgJ-6bDzQ'
  BsJwt.verify_and_decode!(jwt_token)
```

Decode a JWT token directly from the omniauth hash:

```ruby
  BsJwt.verify_and_decode_auth0_hash!(request.env['omniauth.auth'])
```

## Testing support

Some `factory_bot` factories are included in this gem. To use them add

```ruby
require 'bs_jwt/factories'
```

before requiring `factory_bot` to your spec_helper.

## Publish new gem version

1) Set the new version in the [version file](lib/bs_jwt/version.rb).

2) Update the [changelog](CHANGELOG.md)

3) Make a bump version commit and push it

4) Visit https://gitlab.com/ReverseRetail/bs_jwt/pipelines. Wait for the tests to pass and trigger the publish_gem job.
