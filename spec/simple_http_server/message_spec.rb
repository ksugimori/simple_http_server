require "simple_http_server"

describe SimpleHttpServer::Message::HttpRequest do
  it "can parse GET request" do
    request_line = "GET /path/to/resource HTTP/1.1"
    request = SimpleHttpServer::Message.parse_request(request_line)
    expect(request.http_method).to eql(:get)
    expect(request.target).to eql("/path/to/resource")
    expect(request.version).to eql("HTTP/1.1")
  end

  it "can also parse HTTP/1.0 GET request" do
    request_line = "GET /path/to/another HTTP/1.0"
    request = SimpleHttpServer::Message.parse_request(request_line)
    expect(request.http_method).to eql(:get)
    expect(request.target).to eql("/path/to/another")
    expect(request.version).to eql("HTTP/1.0")
  end

  it "can parse methods" do
    put_request = SimpleHttpServer::Message.parse_request("PUT /hoge HTTP/1.1")
    post_request = SimpleHttpServer::Message.parse_request("POST /hoge HTTP/1.1")
    patch_request = SimpleHttpServer::Message.parse_request("PATCH /hoge HTTP/1.1")
    delete_request = SimpleHttpServer::Message.parse_request("DELETE /hoge HTTP/1.1")
    head_request = SimpleHttpServer::Message.parse_request("HEAD /hoge HTTP/1.1")

    expect(put_request.http_method).to eql(:put)
    expect(post_request.http_method).to eql(:post)
    expect(patch_request.http_method).to eql(:patch)
    expect(delete_request.http_method).to eql(:delete)
    expect(head_request.http_method).to eql(:head)
  end

  it "throw an InvalidRequestError" do
    request_line = "GET /hoge" # version 指定が無い
    expect { SimpleHttpServer::Message.parse_request(request_line) }.to raise_error(SimpleHttpServer::InvalidRequestError)
  end
end
