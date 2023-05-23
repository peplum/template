module Peplum
class Template
class Application

module Native

  # TODO: Populate it with some actual payload code.
  #
  # Run payload against `objects` based on given `options`
  #
  # @param  [Array] objects Objects that this worker should process.
  # @param  [Hash, NilClass]  options Worker options.
  # @abstract
  def run( objects, options )
    # Signal that we started work or something to our peers...
    Template::Application.shared_hash.set( Process.pid, options )

    # Access peer's services.
    Template::Application.peers.each do |peer|
      p peer.my_service.foo
      pp peer.my_service.shared_hash_to_hash
    end

    pp [objects, options]
  end

  # Distribute `objects` into `chunks` amount of groups, one for each worker.
  #
  # @param  [Array] objects All objects that need to be processed.
  # @param  [Integer] chunks  Amount of object groups that should be generated.
  #
  # @return [Array<Array<Object>>]  `objects` split in `chunks` amount of groups
  # @abstract
  def group( objects, chunks )
    objects.chunk chunks
  end

  # TODO: Populate it with some actual merging code.
  #
  # Merge result `data` for reporting.
  #
  # @param  [Array] data  Report data from workers.
  # @abstract
  def merge( data )
    data
  end

  extend self
end

end
end
end