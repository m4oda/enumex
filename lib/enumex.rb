require 'forwardable'
require 'enumex/version'

module Enumex
  # Enumex.attach_to([1, 2, 3, 4, 5].each) {|n|
  #   puts n
  # }.every_once(3).times {
  #   puts "\n"
  # }
  #
  # enm = Enumex.every_once(3).times do
  #   "\n"
  # end
  #
  # enum.attach_to([1, 2, 3, 4, 5].each) do |n|
  #   puts n
  # end

  autoload :Base, 'enumex/base'
  autoload :Action, 'enumex/action'
  autoload :Actions, 'enumex/actions'

  module Extenders
    autoload :EveryOnceExtender, 'enumex/extenders/every_once_extender'
    autoload :EveryTimeExtender, 'enumex/extenders/every_time_extender'
  end

  class << self
    def new(enumerator = nil, &block)
      Base.new.tap {|enmx| enmx.attach_to(enumerator, &block) if enumerator }
    end
  end

  Extenders.constants.map {|nm|
    Extenders.const_get(nm)
  }.each do |klass|
    Action.instance_eval { include klass::Port }
  end

  refine Object do
    define_method :enumex, ->(enumerator = nil, &block) do
      Enumex.new(enumerator, &block)
    end
  end
end
