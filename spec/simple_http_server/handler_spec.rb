require "simple_http_server"

describe SimpleHttpServer::Handler do
  it "ファイルが存在しなければ404エラーを返す" do
    request = SimpleHttpServer::Message.parse_request("GET /foo/bar.html HTTP/1.1")

    response = SimpleHttpServer::Handler.handle(request)

    expect(response.status).to eql(:not_found)
    expect(response.status_code).to eql(404)
    expect(response.reason_phrase).to eql("Not Found")
  end
end
