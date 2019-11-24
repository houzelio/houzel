require_relative "load_config"

# Specifies the `environment` that Puma will run in.
# #
environment AppConfig.server.environment

# Daemonize the server into the background.
# Highly suggest that this be combined with
# "pidfile" and "stdout_redirect". (default="false")
# daemonize
# daemonize false

# Store the pid of the server in the file at "path"
#pidfile "#{shared_dir}/tmp/pids/puma.pid"

# Use "path" as the file to store the server info
# state. This is used by "pumactl" to query and
# control the server.
#state_path '#{shared_dir}/pids/puma.state'
#activate_control_app

# Redirect STDOUT and STDERR to files specified.
# The 3rd parameter ("append") specifies whether
# the output is appended. (default="false")
#stdout_redirect 'log/puma.stdout.log', 'log/puma.stderr.log'
#stdout_redirect 'log/puma.stdout.log', 'log/puma.stderr.log', true

# Disable request logging. (default="false")
#quiet

# Bind the server to "url". "tcp://", "unix://" and "ssl://" are the only
# accepted protocols.
#
# bind "unix://#{shared_dir}/sockets/puma.sock"
# bind 'unix:///var/run/puma.sock?umask=0111'
# bind 'ssl://127.0.0.1:9292?key=path_to_key&cert=path_to_cert'
bind "tcp://0.0.0.0:3000"

# Additionally, you can specify a block in
# your configuration file that will be run
# on boot of each worker
#on_worker_boot do
#
#end
