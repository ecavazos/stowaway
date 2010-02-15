module Stowaway
  class Matcher
    def match?(line, file)
      @line, @file = line, file
      return true if html_attr_ref?
      return true if haml_attr_ref?
      return true if rails_js_ref?
      return true if rails_css_ref?
    end

    private

    def html_attr_ref?
      @line =~ /(src|link|href|:href)\s?[=|=>]\s?(["|'])(#{@file.fullpath})(\2)/
    end

    def haml_attr_ref?
      @line =~ /(:src|:link|:href)(\s?=>\s?)(["|'])(#{@file.fullpath})(\3)/
    end

    def rails_js_ref?
      return false unless @line =~ /=?\s(javascript_include_tag)?\s(["|'])(.+)(\2)/
      params = $3.gsub(/[\s|"]/, "").split(",")
      params.each do |f|
        if f =~ /\.js$/
          return true if "/public/javascripts/#{f}" == @file.fullpath
        else
          return true if "/public/javascripts/#{f}.js" == @file.fullpath
        end
      end
      false
    end

    def rails_css_ref?
      return false unless @line =~ /=?\s(stylesheet_link_tag)?\s(["|'])(.+)(\2)/
      params = $3.gsub(/[\s|"]/, "").split(",")
      params.each do |f|
        if f =~ /\.css$/
          return true if "/public/stylesheets/#{f}" == @file.fullpath
        else
          return true if "/public/stylesheets/#{f}.css" == @file.fullpath
        end
      end
      false
    end

  end
end
