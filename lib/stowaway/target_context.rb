module Stowaway
  class TargetContext
    def initialize(root)
      @root = root
    end

    attr_reader :root

    def path_relative_to_root(file_p)
      root = @root.split("/").last
      file_p.sub(/^.+\/(#{root})/, "")
    end
  end
end
