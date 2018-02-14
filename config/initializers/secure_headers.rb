SecureHeaders::Configuration.default do |config|
  config.csp = {
    default_src: %w('none'),
    connect_src: %w('self'),
    font_src: %w('self' data: fonts.gstatic.com),
    img_src:  %w['self' data: blob: *],
    script_src: %w['self' 'unsafe-inline'] ,
    style_src: %w['self' 'unsafe-inline' fonts.googleapis.com]
  }

  config.hsts = SecureHeaders::OPT_OUT # added by Rack::SSL

end
