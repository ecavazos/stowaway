module FSHelpyHelp
  def ignore?(file)
    @ignore.each do |exp|
      if file.match(exp)
        return true
      end
    end
    false
  end
end
