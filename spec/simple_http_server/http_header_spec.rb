require "simple_http_server"

describe SimpleHttpServer::HttpHeader do
  it "hash のように使用できること" do
    header = SimpleHttpServer::HttpHeader.new
    header["Content-Type"] = "text/html"
    expect(header["Content-Type"]).to eql("text/html")
  end

  it "文字列化したとき正しいフォーマットになること" do
    header = SimpleHttpServer::HttpHeader.new
    header["Content-Type"] = "text/html"
    header["Content-Length"] = 30

    expect(header.lines).to contain_exactly("Content-Type: text/html", "Content-Length: 30")
  end
end
