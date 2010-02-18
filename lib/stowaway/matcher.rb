module Stowaway
  class Matcher
    def match?(line, file)
      @line, @file = line, file
      html_attr_ref? ||
      haml_attr_ref? ||
      rails_js_ref?  ||
      rails_css_ref? ||
      css_url_ref?   ||
      line.include?(file.name)
    end

    private

    def html_attr_ref?
      exp = /(src|link|href|:href)\s?[=|=>]\s?(["|'])(%s)(\2)/
      direct_or_public_dir_match?(exp)
    end

    def haml_attr_ref?
      exp = /(:src|:link|:href)(\s?=>\s?)(["|'])(%s)(\3)/
      direct_or_public_dir_match?(exp)
    end

    def rails_js_ref?
      return false unless @line =~ /=?\s(javascript_include_tag)?\s(["|'])(.+)(\2)/
      params = $3.gsub(/[\s|"]/, "").split(",")
      params.each do |f|
          return true if "/public/javascripts/#{f}" == @file.root_path || 
                         "/public/javascripts/#{f}.js" == @file.root_path
      end
      false
    end

    def rails_css_ref?
      return false unless @line =~ /=?\s(stylesheet_link_tag)?\s(["|'])(.+)(\2)/
      params = $3.gsub(/[\s|"]/, "").split(",")
      params.each do |f|
          return true if "/public/stylesheets/#{f}" == @file.root_path ||
                         "/public/stylesheets/#{f}.css" == @file.root_path
      end
      false
    end

    def css_url_ref?
      exp = /url\(["|']?(%s)\)/
      direct_or_public_dir_match?(exp)
    end

    def direct_or_public_dir_match?(exp)
      @line =~ Regexp.new(exp.to_s % @file.fullpath) ||
      @line =~ Regexp.new(exp.to_s % trim_public)
    end

    def trim_public
      # remove /public from the beginning of the path
      @file.root_path.sub(/\/public/, "")
    end

  end
end
