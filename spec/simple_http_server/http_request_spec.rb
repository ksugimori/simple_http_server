describe SimpleHttpServer::HttpRequest do
  it "メソッド、パス、バージョンを保持できること" do
    request = SimpleHttpServer::HttpRequest.new(:get, "/hoge/fuga", "HTTP/2")

    expect(request.http_method).to eql(:get)
    expect(request.target).to eql("/hoge/fuga")
    expect(request.version).to eql("HTTP/2")
  end

  it "リクエストヘッダ、ボディが保持されること" do
    request = SimpleHttpServer::HttpRequest.new(:get, "/foo", "HTTP/1.1") do |r|
      r["Content-Length"] = 10
      r["User-Agent"] = "hoge"
      r.body = "This is a test."
    end

    expect(request["Content-Length"]).to eql(10)
    expect(request["User-Agent"]).to eql("hoge")
    expect(request.body).to eql("This is a test.")
  end
end
