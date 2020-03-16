describe SimpleHttpServer::Message::HttpResponse do
  it "デフォルトで 200 OK として初期化されること" do
    response = SimpleHttpServer::Message::HttpResponse.new
    expect(response.status).to eql(:ok)
    expect(response.status_code).to eql(200)
    expect(response.reason_phrase).to eql("OK")
    expect(response.version).to eql("HTTP/1.1")
    expect(response.body).to be_nil
  end

  it "ステータスを指定して初期化できること" do
    response = SimpleHttpServer::Message::HttpResponse.new(:bad_request)
    expect(response.status).to eql(:bad_request)
    expect(response.status_code).to eql(400)
    expect(response.reason_phrase).to eql("Bad Request")
    expect(response.version).to eql("HTTP/1.1")
    expect(response.body).to be_nil
  end

  it "レスポンスボディをセットできること" do
    html = <<~EOT
      <!DOCTYPE html>
      <html>
        <body>hoge</body>
      </html>
    EOT
    response = SimpleHttpServer::Message::HttpResponse.new(:ok, html)
    expect(response.status).to eql(:ok)
    expect(response.body).to include("<body>hoge</body>")
  end

  it "レスポンスヘッダが保持されること" do
    response = SimpleHttpServer::Message::HttpResponse.new(:ok) do |r|
      r.header["Content-Length"] = 99
      r.header["Set-Cookie"] = "hoge=fuga"
    end

    expect(response.header["Content-Length"]).to eql(99)
    expect(response.header["Set-Cookie"]).to eql("hoge=fuga")
  end

  it "HTTPレスポンスとしてシリアライズできること" do
    response = SimpleHttpServer::Message::HttpResponse.new(:ok)
    response.header["Content-Type"] = "text/plain"
    response.header["Cookie"] = "hoge"
    response.body = "Hello world!"
    response.version = "HTTP/1.1"

    expected_string = <<~EOT.gsub("\n", "\r\n").chomp
      HTTP/1.1 200 OK
      Content-Type: text/plain
      Cookie: hoge

      Hello world!
    EOT

    expect(response.serialize).to eql(expected_string)
  end
end
