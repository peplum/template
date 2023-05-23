module Peplum
class Template

module Native

  # Run payload against `objects`.
  def run( objects, options = nil )
  end

  # Distribute `objects` into `chunks` amount of groups, one for each worker.
  def group( objects, chunks )
  end

  # Merge result `data` for reporting.
  def merge( data )
  end

  extend self
end

end
end
