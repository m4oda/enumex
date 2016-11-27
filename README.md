Enumex
============================================================

Enumex is a utility to attach preprocessing and postprocessing
to Enumerator.

Usage
------------------------------------------------------------

```ruby
using Enumex

extension = enumex.pre_action.every_time { print "- " }
extension.post_action.every_once(3).times { puts "sleep" }
extension.attach_to((1..10).each) do |n|
  puts n
end

# - 1
# - 2
# - 3
# sleep
# - 4
# - 5
# - 6
# sleep
# - 7
# - 8
# - 9
# sleep
# - 10
# => 1..10
```

```ruby
using Enumex

enumex((1..10).each) {|n|
  puts "- #{n}"
}.post_action.every_once(3).times {
  puts "sleep"
}
```

```ruby
using Enumex

enumex.post_action.every_once(3).times {
  print "Fizz"
}.every_once(5).times {
  print "Buzz"
}.every_time {
  print "\n"
}.attach_to((1..100).each) do |n|
  print "#{n}: "
end
```