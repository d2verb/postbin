require "tablo"

module Printer
  def self.run(data : Array(Array(String)), win : Crt::Window, bin_id : String)
    table = Tablo::Table.new(data) do |t|
      t.add_column("Method") { |n| n[0] }
      t.add_column("Path", width: 30) { |n| n[1] }
      t.add_column("Headers", width: 35) { |n| n[2] }
      t.add_column("Query") { |n| n[3] }
      t.add_column("Body") { |n| n[4] }
      t.add_column("IP", width: 13) { |n| n[5] }
      t.add_column("Inserted") do |n|
        time = Time.unix_ms(n[6].as(String).to_i64).to_local
        time.to_s("%Y-%m-%d %H:%M:%S")
      end
    end
    win.clear
    win.print(0, 0, "bin URL: https://postb.in/#{bin_id}")
    win.print(1, 0, table.to_s)
    win.refresh
  end
end
