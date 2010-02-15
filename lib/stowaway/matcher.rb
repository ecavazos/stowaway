module Stowaway
  class Matcher
    def match?(line, file)
      return true if attr_ref?(line, file)
      return true if rails_js_ref?(line, file)
      return true if rails_css_ref?(line, file)
    end

    private

    def attr_ref?(line, file)
      line =~ /(src|link|href)=(["|'])(#{file.fullpath})(\2)/
    end

    def rails_js_ref?(line, file)
      return false unless line =~ /=?\s(javascript_include_tag)?\s(["|'])(.+)(\2)/
      params = $3.gsub(/[\s|"]/, "").split(",")
      params.each do |f|
        if f =~ /\.js$/
          return true if "/public/javascripts/#{f}" == file.fullpath
        else
          return true if "/public/javascripts/#{f}.js" == file.fullpath
        end
      end
      false
    end

    def rails_css_ref?(line, file)
      return false unless line =~ /=?\s(stylesheet_link_tag)?\s(["|'])(.+)(\2)/
      params = $3.gsub(/[\s|"]/, "").split(",")
      params.each do |f|
        if f =~ /\.css$/
          return true if "/public/stylesheets/#{f}" == file.fullpath
        else
          return true if "/public/stylesheets/#{f}.css" == file.fullpath
        end
      end
      false
    end

  end
end
