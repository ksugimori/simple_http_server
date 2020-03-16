require "simple_http_server"

describe SimpleHttpServer::HttpMessage do
  it "ヘッダーを hash のように使用できること" do
    message = SimpleHttpServer::HttpMessage.new
    message["Content-Type"] = "text/html"
    expect(message["Content-Type"]).to eql("text/html")
  end

  it "ヘッダーを文字列化したとき正しいフォーマットになること" do
    message = SimpleHttpServer::HttpMessage.new
    message["Content-Type"] = "text/html"
    message["Content-Length"] = 30

    expect(message.header_lines).to contain_exactly("Content-Type: text/html", "Content-Length: 30")
  end
end
