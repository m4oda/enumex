module Enumex
  module Extenders
    class EveryTimeExtender
      Port = Module.new do
        def every_time(&block)
          EveryTimeExtender.new(self, &block).value
        end
      end

      def initialize(base, &block)
        @base = base
        @block = block
        base.extenders << self if block_given?
        base.enumerator ? base.run : base
      end

      def reset
      end

      def execute(*args)
        block.call(*args) if block
      end

      def value
        base.enumerator ? base.run : base
      end

      private

      attr_reader :base, :block
    end
  end
end
