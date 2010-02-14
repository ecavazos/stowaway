require_relative 'fshelpyhelp'
require_relative 'status'

module Stowaway
  class Sweeper
    include FSHelpyHelp

    def initialize(files_to_find, status = Status.new, ext_to_ignore = nil)
      @files_to_find = files_to_find
      @ignore = ext_to_ignore || [/^\.|\.jpg$|\.gif$|.png$/i]
      @status = status
    end
  
  
    def sweep(path)
      dir = Dir.new(path)
      @root = path if @root.nil?
    
      dir.each do |f|
        next if ignore?(f)
      
        file = File.join(dir.path, f)
      
        if File.directory?(file)
          sweep(file)
        else
          inspect_file(file)
        end
      end
      @files_to_find
    end

    private

    def inspect_file(file)
      @status.out "Sweeping: #{file}"
      File.open(file, 'r') do |i|
        while line = i.gets
          remove_match(line)
        end
      end
      @status.flush
    end

    def remove_match(line)
      @files_to_find.delete_if { |file| match?(line, file) }
    end

    def match?(line, file)
      return true if line =~ /(src|link|href)=(["|'])(#{file.fullpath})(\2)/
      if line =~ /=?\s(javascript_include_tag)?\s(["|'])(.+)(\2)/
        params = $3.gsub(/[\s|"]/, "").split(",")
        params.each { |f| return true if "/public/javascripts/#{f}" == file.fullpath }
      elsif line =~ /=?\s(stylesheet_link_tag)?\s(["|'])(.+)(\2)/
        params = $3.gsub(/[\s|"]/, "").split(",")
        params.each do |f|
          if f =~ /\.css$/
            return true if "/public/stylesheets/#{f}" == file.fullpath
          else
            return true if "/public/stylesheets/#{f}.css" == file.fullpath
          end
        end
      end
      false
    end
  end
end
