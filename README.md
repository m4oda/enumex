Enumex
============================================================

Enumex is a utility for Enumerator.

Usage
------------------------------------------------------------

```ruby
using Enumex

extension = enumex.pre_action.every_time { print "- " }
extension.post_action.every_once(3).times { puts "sleep" }
extension.attach_to((1..10).each) do |n|
  puts n
end
```

```ruby
using Enumex

enumex((1..10).each) {|n|
  puts "- #{n}"
}.post_action.every_once(3).times {
  puts "sleep"
}
```