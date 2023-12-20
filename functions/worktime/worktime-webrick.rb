require 'webrick'
require 'openssl'

# If you don't already have an SSL certificate and a private key, you can create them using OpenSSL:

# bash

# openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365

# This command generates a new private key (key.pem) and a self-signed certificate (cert.pem) valid for 365 days. You'll be prompted to enter some information for the certificate.


root = File.expand_path '/Users/booty/booty-dotfiles/functions/worktime/'  # Set this to your web server's root directory
server = WEBrick::HTTPServer.new(
  # Port: 8000,
  Port: 80,
  DocumentRoot: root,
  # SSLEnable: true,
  # SSLCertificate: OpenSSL::X509::Certificate.new(File.read("cert.pem")),
  # SSLPrivateKey: OpenSSL::PKey::RSA.new(File.read("key.pem"))
)

trap 'INT' do server.shutdown end

begin
  server.start
  puts "Server started on port #{server.config[:Port]}"
rescue Errno::EADDRINUSE => e
  puts "No big deal, but: Another server is already running on port #{server.config[:Port]}."
end
