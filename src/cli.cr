require "./main"
require "clim"

class Cli < Clim
  main do
    run do |opts, args|
      Postbin.run
    end
  end
end

Cli.start(ARGV)
