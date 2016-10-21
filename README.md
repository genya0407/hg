# Hg

Hg is a simple hash generator.

"Hg" stands for "Hash Generator".

## Installation

In `Gemfile`, write:

```ruby
gem 'hg'
```

Or install it yourself as:

```shell
$ gem install hg
```

## Usage

```ruby
require 'hg'

# basic usage
hg = Hg::Hg.create do |hg|
  hg.headers :x, :y
  hg.body <<BODY
  1, 2
  3, 4
  5, 6
BODY
end

hg.hash # => { x: [1,3,5], y: [2,4,6] }

# convert to daru's dataframe
require 'daru'

hg.daru_dataframe # equivalent to Daru::DataFrame.new(hg.hash)
```

