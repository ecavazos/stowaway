module FSHelpyHelp
  def ignore? file
    @ignore.each do |s|
      if file.match(/#{s}/i)
        return true
      end
    end
    false
  end
end