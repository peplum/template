require 'pp'
require 'peplum/template'

# Spawn an Agent as a daemon.
template_agent = Peplum::Template::Application.spawn( :agent, daemonize: true )
at_exit { template_agent.shutdown rescue nil }

# Spawn and connect to an Instance.
template = Peplum::Template::Application.connect( template_agent.spawn )
# Don't forget this!
at_exit { template.shutdown }

template.run(
  peplum: {
    objects:     [1, 2, 3, 4, 5, 6, 7, 8, 9, 0],
    max_workers: 5
  },
  native: {
    my_option_bool:   true,
    my_option_array:  [1,2,3],
    my_option_hash:   { 4 => '5', '6' => 7 }
  }
)

# Waiting to complete.
sleep 1 while template.running?

# Hooray!
puts JSON.pretty_generate( template.generate_report.data )
