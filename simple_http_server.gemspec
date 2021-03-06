require_relative "lib/simple_http_server/version"

Gem::Specification.new do |spec|
  spec.name = "simple_http_server"
  spec.version = SimpleHttpServer::VERSION
  spec.authors = ["ksugimori"]
  spec.email = ["hoge@example.com"]

  spec.summary = %q{Simple HTTP Server}
  spec.description = %q{Simple HTTP Server. It can accept only GET method.}
  spec.homepage = "https://github.com/ksugimori/simple_http_server"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://github.com/ksugimori/simple_http_server"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ksugimori/simple_http_server"
  spec.metadata["changelog_uri"] = "https://github.com/ksugimori/simple_http_server"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # dependencies
  spec.add_development_dependency "rspec", "~> 3.9.0"
  spec.add_development_dependency "yard"
  spec.add_dependency "thor"
end
