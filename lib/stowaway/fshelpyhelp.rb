module Stowaway
  module FSHelpyHelp
    def ignore?(file)
      @ignore.each do |exp|
        if file.match(exp)
          return true
        end
      end
      false
    end

    def ignore_special_directories(root)
      @ignore << "/#{root}\/test$|spec$|vendor$|features$"
    end

    def recursively(path, &block)
      dir = Dir.new(path)

      dir.each do |f|
        next if ignore?(dir.path)
        next if ignore?(f)

        file_p = File.join(dir.path, f)

        if File.directory?(file_p)
          recursively(file_p, &block)
        else
          yield(file_p)
        end
      end
    end
  end
end
