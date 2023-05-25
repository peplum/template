module Peplum
class Template
class Application

module Payload

  # TODO: Populate it with some actual payload code.
  #
  # Run payload against `objects` based on given `options`
  #
  # @param  [Array] objects Objects that this worker should process.
  # @param  [Hash, NilClass]  options Worker options.
  # @abstract
  def run( objects, options )
    # Signal that we started work or something to our peers by PID.
    Template::Application.my_hash.set( Process.pid, options )

    # Access peer's services.
    Template::Application.peers.each do |peer|
      p peer.my_service.foo
      pp peer.my_service.my_hash_to_hash
    end

    # We're setting our status to 2, or something.
    Template::Application.shared_hash.set( Cuboid::Options.rpc.url, 2 )

    # Wait for the last peer to set its status.
    last_peer_url = Template::Application.peers.to_a.last.url
    Template::Application.shared_hash.on_set last_peer_url do |v|
      ap "[#{last_peer_url}] Status: #{v}"
    end

    ap Template::Application.my_hash.to_h

    pp [objects, options]
  end

  # Distribute `objects` into `groups_of` amount of groups, one for each worker.
  #
  # @param  [Array] objects All objects that need to be processed.
  # @param  [Integer] groups_of  Amount of object groups that should be generated.
  #
  # @return [Array<Array<Object>>]  `objects` split in `chunks` amount of groups
  # @abstract
  def split( objects, groups_of )
    objects.chunk groups_of
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
