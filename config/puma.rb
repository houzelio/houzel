require_relative "load_config"

# Specifies the `environment` that Puma will run in.
# #
environment AppConfig.server.environment

pidfile AppConfig.server.pid
threads_count = AppConfig.server.puma_thread.to_i
threads threads_count, threads_count
workers AppConfig.server.puma_workers.to_i

if AppConfig.server.std_log?
  std_log = AppConfig.server.std_log
  stdout_redirect std_log, std_log
end

bind AppConfig.server.listen
