module Enumex
  class Action
    extend Forwardable

    def_delegators :@root,
                   :attach_to, :enumerator, :run,
                   *Actions.types.map {|nm| "#{nm}_action" }

    attr_reader :root, :extenders

    def initialize(root)
      @root = root
      @extenders = []
    end
  end
end
