require "stowaway/file_marker"

module Stowaway
  class Matcher
    def match?(line, file)
      @line, @file = line, file
      html_attr_ref? ||
      haml_attr_ref? ||
      rails_js_ref?  ||
      rails_css_ref? ||
      css_url_ref?
    end

    private

    def html_attr_ref?
      exp = /(src|href)\s?=\s?(["|'])(%s)(\2)/
      direct_or_public_dir_match?(exp)
    end

    def haml_attr_ref?
      exp = /(:src|:href)(\s?=>\s?)(["|'])(%s)(\3)/
      direct_or_public_dir_match?(exp)
    end

    def rails_js_ref?
      rails_helper_ref?("javascript_include", "javascripts", "js")
    end

    def rails_css_ref?
      rails_helper_ref?("stylesheet_link", "stylesheets", "css")
    end

    def css_url_ref?
      exp = /url\((["|'])?(%s)(\1)?\)/
      direct_or_public_dir_match?(exp)
    end

    def rails_helper_ref?(helper_name, directory, extension)
      expression = Regexp.new(/=\s?(%s_tag)?\s(["|'])(.+)(\2)/.to_s % helper_name)
      return false if @line !~ expression
      params = $3.gsub(/[\s|"|']/, "").split(",")
      params.each do |f|
          path = @file.root_path
          return true if "/public/#{directory}/#{f}" == path ||
                         "/public/#{directory}/#{f}.#{extension}" == path
      end
      false
    end

    def direct_or_public_dir_match?(expression)
      expression = expression.to_s
      @line =~ Regexp.new(expression % @file.root_path) ||
      @line =~ Regexp.new(expression % trim_public)
    end

    def trim_public
      # remove /public from the beginning of the path
      @file.root_path.sub(/\/public/, "")
    end

  end
end
