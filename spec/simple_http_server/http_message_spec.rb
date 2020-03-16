require "simple_http_server"

describe SimpleHttpServer::HttpMessage do
  it "ヘッダーを hash のように使用できること" do
    message = SimpleHttpServer::HttpMessage.new
    message["Content-Type"] = "text/html"
    expect(message["Content-Type"]).to eql("text/html")
  end

  it "ヘッダーを key, value のペアとして取り出せること" do
    message = SimpleHttpServer::HttpMessage.new
    message["Content-Type"] = "text/html"
    message["Content-Length"] = 30

    lines = []
    message.headers do |k, v|
      lines << "#{k}: #{v}"
    end

    expect(lines).to contain_exactly("Content-Type: text/html", "Content-Length: 30")
  end
end
