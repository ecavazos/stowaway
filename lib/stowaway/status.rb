module Stowaway
  class Status
    RESET = "\r\e[0K"
    def out(msg)
      print "#{RESET}#{msg}"
    end

    def flush
      print RESET 
      $stdout.flush
    end
  end
end
