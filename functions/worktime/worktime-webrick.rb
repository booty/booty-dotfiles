require "webrick"
require "openssl"

PUBLIC_HTML_ROOT = File.expand_path("/Users/booty/booty-dotfiles/functions/worktime/worktime-public")
SSL_CERT_PATH = File.expand_path("/Users/booty/booty-dotfiles/functions/worktime/worktime-private/worktime-certificate.crt")
SSL_PRIVATE_KEY_PATH = File.expand_path("/Users/booty/booty-dotfiles/functions/worktime/worktime-private/worktime-private-key-decrypted.key")

SERVER_PORT = 80
SECURE_SERVER_PORT = 443

server = secure_server = nil

server_thread = Thread.new do
  puts "What the fuck"
  begin
    server = WEBrick::HTTPServer.new(
      Port: SERVER_PORT,
      DocumentRoot: PUBLIC_HTML_ROOT,
    )
    puts "Server starting on port #{SERVER_PORT}"
    server.start
  rescue Errno::EADDRINUSE => e
    puts "No big deal, but: Another server is already running on port #{SERVER_PORT}."
  end
end

secure_server_thread = Thread.new do
  puts "What the shit"
  begin
    secure_server = WEBrick::HTTPServer.new(
      Port: SECURE_SERVER_PORT,
      DocumentRoot: PUBLIC_HTML_ROOT,
      SSLEnable: true,
      SSLCertificate: OpenSSL::X509::Certificate.new(File.read(SSL_CERT_PATH)),
      SSLPrivateKey: OpenSSL::PKey::RSA.new(File.read(SSL_PRIVATE_KEY_PATH)),
    )
    puts "Secure server starting on port #{SECURE_SERVER_PORT}"
    secure_server.start
  rescue Errno::EADDRINUSE => e
    puts "No big deal, but: Another server is already running on port #{SECURE_SERVER_PORT}."
  end
end

trap "INT" do
  puts "Shutting down servers..."
  server&.shutdown
  secure_server&.shutdown
end

server_thread.join
secure_server_thread.join
