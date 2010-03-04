class IOMock
  def initialize
    @counter = 0
  end
  def gets
    return nil if @counter > 0
    @counter += 1
    "\xA9".force_encoding("utf-8")
  end
end
