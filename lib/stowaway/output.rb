module Stowaway
  module Output
    RESET = "\r\e[0K"

    def clr_print(msg)
      print "#{RESET}#{msg}"
    end

    def flush
      print RESET
      $stdout.flush
    end

    def new_line(count = 1)
      count.times do
        print "\n"
      end
    end
  end
end
