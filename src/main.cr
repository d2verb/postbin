require "./lib/api"
require "./lib/printer"

require "crt"

module Postbin
  VERSION = "0.1.0"

  def self.run
    bin_id = PostbinAPI.create
    data = [] of Array(String)
    win = Crt::Window.new
    loop do
      info = PostbinAPI.shift(bin_id)
      if info
        data << [info[:method], info[:path], info[:headers], info[:query], info[:body], info[:ip]]
      end
      Printer.run(data, win, bin_id)
      sleep 1
    end
  rescue ex
    puts ex.to_s
  ensure
    Crt.done
  end
end
