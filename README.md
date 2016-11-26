Enumex
============================================================

Enumex is enumerator attachment.

Usage
------------------------------------------------------------

```
enmx = Enumex.new.post_action.every_once(3).times do
         puts "sleep"
       end
enmx.attach_to((1..10).each) do |n|
  puts n
end
```
