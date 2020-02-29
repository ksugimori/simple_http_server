require "simple_http_server/message"

describe SimpleHttpServer::Message::HttpRequest do
  it "can parse GET request" do
    request_line = "GET /path/to/resource HTTP/1.1"
    request = SimpleHttpServer::Message.parse_request(request_line)
    expect(request.http_method).to eql("GET")
    expect(request.request_uri).to eql("/path/to/resource")
    expect(request.version).to eql("HTTP/1.1")
  end

  it "can also parse HTTP/1.0 GET request" do
    request_line = "GET /path/to/another HTTP/1.0"
    request = SimpleHttpServer::Message.parse_request(request_line)
    expect(request.http_method).to eql("GET")
    expect(request.request_uri).to eql("/path/to/another")
    expect(request.version).to eql("HTTP/1.0")
  end
end
