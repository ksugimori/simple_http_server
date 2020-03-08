# SimpleHttpServer

HTTP と Ruby 勉強用に作成した HTTP サーバです。
GET リクエストにのみ対応しています。

## 注意

あくまでも学習目的に作成したものなので、多数の脆弱性が存在します。本番環境では **絶対に** 使用しないでください。


## Usage

`simple_http_server start` でサーバが起動します。
ポート番号、ドキュメントルートはオプションで変更可能。デフォルトでは `-p 3000 -r /va/www` として起動します。

```
Usage:
  simple_http_server start

Options:
  p, [--port=<port>]          
  r, [--docroot=<directory>] 
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/simple_http_server.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
