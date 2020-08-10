require "./lib/api"
require "./lib/printer"

require "crt"

begin
  bin_id = PostbinAPI.create
  data = [] of Array(String)
  win = Crt::Window.new
  loop do
    info = PostbinAPI.shift(bin_id)

    if info
      data << [
        info[:method],
        info[:path],
        info[:headers],
        info[:query],
        info[:body],
        info[:ip],
        info[:inserted],
      ]
    end
    Printer.run(data, win, bin_id)
    sleep 1
  end
rescue ex
  Crt.done
  puts ex.to_s
ensure
  Crt.done
  if bin_id
    PostbinAPI.delete bin_id
  end
end
