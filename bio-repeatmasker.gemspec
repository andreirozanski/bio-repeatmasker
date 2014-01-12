Gem::Specification.new do |s|
  s.name = "bio-repeatmasker"
  s.version = "0.0.2"
  s.date = %q{2014-01-11}
  s.summary = %q{bio-repeatmasker}
  s.description = %q{A simple gem to parse, filter/search raw Repeat Masker output file from GoldenPath}
  s.authors = ["Andrei Rozanski"]
  s.email = %q{andrei@ruivo.org}
  s.files = ["lib/bio-repeatmasker.rb"]
  s.test_files = ["test/test_bio-repeatmasker.rb", "test/chr1.fa.out_head100"]
  s.default_executable = "bio-repeatmasker"
  s.homepage = %q{http://rubygems.org/gems/bio-repeatmasker}
  s.require_paths = ["lib"]
end
