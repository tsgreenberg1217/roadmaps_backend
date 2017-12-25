module Sorter
  def self.recount(stops)
    stops.map.with_index{|stop,i|
      stop.order = i+1
      num = i}
  end
end
