
# NipPeselRegon

[![Build Status](https://travis-ci.org/psagan/nip_pesel_regon.svg?branch=master)](https://travis-ci.org/psagan/nip_pesel_regon)
[![Gem Version](https://badge.fury.io/rb/nip_pesel_regon.svg)](https://badge.fury.io/rb/nip_pesel_regon)
[![Code Climate](https://codeclimate.com/github/psagan/nip_pesel_regon/badges/gpa.svg)](https://codeclimate.com/github/psagan/nip_pesel_regon)

Validates polish identification numbers NIP, PESEL, REGON. Can be used in any ruby script or integrated with Rails validation.
Validates both REGON numbers 9-digit and 14-digit.

**Ruby compatibility:**

- 1.9.3
- 2.0
- 2.1
- 2.2

**Rails compatibility:**

- Rails 4.x

## 1 Installation

Add this line to your application's Gemfile:

```ruby
gem 'nip_pesel_regon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nip_pesel_regon

## 2 Usage

### 2.1 Rails

Gem introduces 3 methods to use in ActiveRecord models:
- validates_nip_of
- validates_pesel_of
- validates_regon_of

**Example:**


**_All NIP, PESEL, REGON numbers used in examples are randomly generated by online generator_**

```ruby
class Company < ActiveRecord::Base
    validates_nip_of :my_nip_field
    validates_pesel_of :my_pesel_field
    validates_regon_of :my_regon_field
end

c = Company.new(my_nip_field: '1464791822', my_pesel_field: '00291600815', my_regon_field: '632188483')
c.valid? # true
```

Each of these methods have 3 options available:
- _message_ - to provide custom validation message
- _strict_ - to determine if strict validation, without normalization, should be used **(false by default)**
- _save_normalized_ - to determine if model saves normalized number or raw (as provided by user) **(true by default)**

**Normalization**

Before validation occurs and with strict option set by default to false following normalization has place:
```ruby
number.gsub(/[-\s]/, '') # all whitespace and dash characters are removed
```
additionaly NIP validation removes 'PL prefix from number (other prefixes like DE, FR, etc. are not not removed because they are not valid in polish NIP validation)


**Options example:**

**default options**
```ruby
class Company < ActiveRecord::Base
   validates_nip_of :nip
end

c = Company.new
c.nip = 'PL146-479-18-22'
c.valid? # true
c.save! # model will save normalized version: '1464791822'
``` 
 
**save_normalized**
```ruby
class Company < ActiveRecord::Base
  validates_nip_of :nip, save_normalized: false
end

c = Company.new
c.nip = 'PL146-479-18-22'
c.valid? # true
c.save! # model will save raw version: 'PL146-479-18-22'
```
 
**strict validation**
```ruby
class Company < ActiveRecord::Base
  validates_nip_of :nip, strict: true
end

c = Company.new
c.nip = '146-479-18-22'
c.valid? # false 

c.nip = '1464791822' # without any characters
c.valid? # true

c.nip = 'PL1464791822' # valid with prefix
c.valid? # true

c.nip = 'PL 1464791822' # with whitespace is not valid
c.valid? false
```

**custom message**
```ruby
class Company < ActiveRecord::Base
  validates_nip_of :nip, message: 'My custom message'
end
 
c = Company.new
c.nip = 'xxx'
c.valid? # false
c.errors[:nip] # contains 'My custom message' instead of default one
```

### 2.2 Ruby
Validators can be used in raw ruby code:
```ruby
require 'nip_pesel_regon'

NipPeselRegon::Validator::Nip.new('1464791822').valid? # true
NipPeselRegon::Validator::Nip.new('14647918Xa').valid? # false

NipPeselRegon::Validator::Pesel.new('00291600815').valid? # true
NipPeselRegon::Validator::Pesel.new('0029xxx815').valid? # false

NipPeselRegon::Validator::Regon.new('632188483').valid? # true
NipPeselRegon::Validator::Regon.new('001010107').valid? # false
```
 
## 3 Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/psagan/nip_pesel_regon.


## 4 License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

