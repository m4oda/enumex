module Enumex
  module Extenders
    class EveryOnceExtender
      extend Forwardable

      Port = Module.new do
        def every_once(number)
          EveryOnceExtender.new(self, number)
        end
      end

      def_delegators :@executor, :execute, :reset

      def initialize(base, number)
        raise ArgumentError if number.to_i <= 0
        @base = base
        @executor = Counter.new(number)
      end

      def times(&block)
        executor.block = block
        base.extenders << self if block_given?

        base.enumerator ? base.attach_to(base.enumerator, &base.block) : base
      end

      private

      attr_reader :base, :executor

      class Counter
        attr_reader :counter, :max_number
        attr_accessor :block

        def initialize(number)
          @counter = (1..number).cycle
          @max_number = number
        end

        def reset
          counter.rewind
        end

        def execute(*args)
          return if counter.next != max_number
          block.call(*args) if block
        end
      end
    end
  end
end
