require "tablo"

module Printer
  def self.run(data : Array(Array(String)), win, bin_id : String)
    table = Tablo::Table.new(data) do |t|
      t.add_column("Method") { |n| n[0] }
      t.add_column("Path", width: 30) { |n| n[1] }
      t.add_column("Headers", width: 35) { |n| n[2] }
      t.add_column("Query") { |n| n[3] }
      t.add_column("Body") { |n| n[4] }
      t.add_column("IP", width: 13) { |n| n[5] }
    end
    win.clear
    win.print(0, 0, bin_id)
    win.print(1, 0, table.to_s)
    win.refresh
  end
end
