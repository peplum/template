require 'peplum/template'
require 'pp'
require_relative 'rest/helpers'

# Boot up our REST server for easy integration.
rest_pid = Peplum::Template::Application.spawn( :rest, daemonize: true )
at_exit { Cuboid::Processes::Manager.kill rest_pid }

# Wait for the REST server to boot up.
while sleep 1
  begin
    request :get
  rescue Errno::ECONNREFUSED
    next
  end

  break
end

# Assign an Agent to the REST service for it to provide us with Instances.
template_agent = Peplum::Template::Application.spawn( :agent, daemonize: true )
request :put, 'agent/url', template_agent.url
at_exit { template_agent.shutdown rescue nil }

# Create a new Instance and run with the following options.
request :post, 'instances', {
  peplum: {
    objects:     [1, 2, 3, 4, 5, 6, 7, 8, 9, 0],
    max_workers: 5
  },
  native: {
    my_option_bool:   true,
    my_option_array:  [1,2,3],
    my_option_hash:   { 4 => '5', '6' => 7 }
  }
}

# The ID is used to represent that instance and allow us to manage it from here on out.
instance_id = response_data['id']

while sleep( 1 )
  # Continue looping while instance status is 'busy'.
  request :get, "instances/#{instance_id}"
  break if !response_data['busy']
end

puts '*' * 88

# Get the report.
request :get, "instances/#{instance_id}/report.json"

# Print out the report.
puts JSON.pretty_generate( JSON.load( response_data['data'] ) )

# Shutdown the Instance.
request :delete, "instances/#{instance_id}"
