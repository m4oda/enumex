module Enumex
  class ActionContainers
    class << self
      def types
        [:post, :pre]
      end
    end

    def initialize(base)
      @base = base
    end

    types.each do |nm|
      define_method nm, -> do
        name = "@#{nm}"
        v = instance_variable_get(name)
        v ? v : instance_variable_set(name, ActionContainer.new(base))
      end
    end

    define_method :types, -> { self.class.types }

    def reset
      types.each {|nm| public_send(nm).extenders.each(&:reset) }
    end

    def empty?
      types.all? {|t| public_send(t).extenders.empty? }
    end

    private

    attr_reader :base
  end
end
