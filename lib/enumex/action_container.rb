module Enumex
  class ActionContainer
    extend Forwardable

    def_delegators :@root,
                   :attach_to, :enumerator, :block, :run,
                   *ActionContainers.types.map {|nm| "#{nm}_action" }

    attr_reader :extenders

    def initialize(root)
      @root = root
      @extenders = []
    end

    private

    attr_reader :root
  end
end
