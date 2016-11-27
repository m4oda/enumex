module Enumex
  class Base
    attr_reader :enumerator, :extenders

    def attach_to(enumerator, &block)
      raise TypeError unless enumerator.is_a?(Enumerator)

      @enumerator = enumerator
      @block = block

      actions.empty? ? self : run
    end

    Actions.types.each do |nm|
      define_method "#{nm}_action", -> { actions.public_send(nm) }
    end

    def run
      return unless enumerator

      enm = new_enumerator
      block ? enm.each(&block) : enm
    end

    private

    attr_reader :block

    def actions
      @actions ||= Actions.new(self)
    end

    def new_enumerator
      Enumerator.new do |y|
        actions.reset
        enumerator.each do |*args|
          actions.pre.extenders.each {|e| e.execute(*args) }
          result = y.yield(*args)
          actions.post.extenders.each {|e| e.execute(*args) }
          result
        end
      end
    end
  end
end
