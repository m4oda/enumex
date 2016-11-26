module Enumex
  class Base
    attr_reader :enumerator, :extenders

    def attach_to(enumerator, &block)
      @enumerator = enumerator
      @block = block

      actions.empty? ? self : run
    end

    Actions.types.each do |nm|
      define_method "#{nm}_action", -> { actions.public_send(nm) }
    end

    def run
      actions.reset

      enumerator.each do |*args|
        actions.pre.extenders.any? {|ext| ext.execute(*args) }

        block.call(*args).tap do |result|
          actions.post.extenders.each {|ext| ext.execute(*args) }
        end
      end
    end

    private

    attr_reader :block

    def actions
      @actions ||= Actions.new(self)
    end
  end
end
