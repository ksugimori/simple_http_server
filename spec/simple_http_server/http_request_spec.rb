describe SimpleHttpServer::Message::HttpRequest do
  it "メソッド、パス、バージョンを保持できること" do
    request = SimpleHttpServer::Message::HttpRequest.new(:get, "/hoge/fuga", "HTTP/2")

    expect(request.http_method).to eql(:get)
    expect(request.target).to eql("/hoge/fuga")
    expect(request.version).to eql("HTTP/2")
  end
end
