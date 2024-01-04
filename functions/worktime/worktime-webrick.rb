require "puma"
require "rack"

PUBLIC_HTML_ROOT = File.expand_path("/Users/booty/booty-dotfiles/functions/worktime/worktime-public")
SSL_CERT_PATH = File.expand_path("/Users/booty/booty-dotfiles/functions/worktime/worktime-private/worktime-certificate.crt")
SSL_PRIVATE_KEY_PATH = File.expand_path("/Users/booty/booty-dotfiles/functions/worktime/worktime-private/worktime-private-key-decrypted.key")

app = Rack::Directory.new(PUBLIC_HTML_ROOT)

# HTTP server
http_server = Puma::Server.new(app)
http_server.add_tcp_listener("0.0.0.0", 80)
http_thread = Thread.new { http_server.run }

# HTTPS server
https_server = Puma::Server.new(app)
https_server.add_ssl_listener("0.0.0.0", 443, {
                                cert: SSL_CERT_PATH,
                                key: SSL_PRIVATE_KEY_PATH,
                              })
https_thread = Thread.new { https_server.run }

puts "HTTP Server starting on port 80"
puts "HTTPS Server starting on port 443"

trap "INT" do
  puts "Shutting down servers..."
  http_server.stop(true)
  https_server.stop(true)
end

http_thread.join
https_thread.join
