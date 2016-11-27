module Enumex
  module Extenders
    class EveryTimeExtender
      Port = Module.new do
        def every_time(&block)
          EveryTimeExtender.new(self, &block).instance_eval { evaluate }
        end
      end

      def initialize(base, &block)
        @base = base
        @block = block
        base.extenders << self if block_given?
      end

      def reset
      end

      def execute(*args)
        block.call(*args) if block
      end

      private

      attr_reader :base, :block

      def evaluate
        base.enumerator ? base.attach_to(base.enumerator, &base.block) : base
      end
    end
  end
end
