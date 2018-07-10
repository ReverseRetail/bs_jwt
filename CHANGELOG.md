# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).
## Unreleased

## [1.2.0] - 2018-07-10
### Added
- Add issued_at to the authentication model

## [1.1.0] - 2018-07-09
### Added
- Authentication#to_h returns the instance attributes as hash.

### Changed
- Authentication.new now accepts an attribute hash.

## [1.0.3] - 2018-07-02
### Changed
- Rename factory authentication to bs_jwt_authentication.

## [1.0.2] - 2018-06-26
### Changed
- Set email and display_name in the authentication factory for better testing support.

## [1.0.1] - 2018-06-22
### Added
- `BsJwt.verify_and_decode/1` and `BsJwt.verify_and_decode_auth0_hash`, which basically do
the same as the bang version, but instead of raising exceptions, they return `nil`.

## [1.0.0] - 2018-06-22
### Added
- `Authentication` class, which is now returned by the `BsJwt.verify_and_decode!/1` and
`BsJwt.verify_and_decode_auth0_hash!/1` (formerly `process_auth0_hash/1`) in place of
a payload Hash.

### Changed
- `BsJwt.process_auth0_hash/1` has been renamed to `BsJwt.verify_and_decode_auth0_hash!/1`
- `BsJwt.process_jwt/1` has been renamed to `BsJwt.verify_and_decode!/1`
Due to the change in public method names, major version has been bumped to 1.

## Unreleased
### Added
- First version of this gem.
-----------------------------------------------------------------------------------------

Template:
## [0.0.0] - 2014-05-31
### Added
- something was added

### Changed
- something changed

### Deprecated
- something is deprecated

### Removed
- something was removed

### Fixed
- something was fixed

### Security
- a security fix

Following "[Keep a CHANGELOG](http://keepachangelog.com/)"
