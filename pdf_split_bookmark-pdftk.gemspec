Gem::Specification.new do |spec|
  spec.platform = Gem::Platform::RUBY
  spec.version = "0.0.1"
  spec.name = "pdf_split_bookmark-pdftk"
  spec.summary = "split pdfs on bookmarks"
  spec.description = "Use pdftk to split pdfs on bookmark level. Limited functionality, see README.md for more info."
  spec.required_ruby_version = ">= 1.9.2"
  spec.required_rubygems_version = ">= 1.3.6"
  spec.author = "Aaron Breckenridge"
  spec.email = "aaronbreckenridge@gmail.com"
  spec.homepage = "https://github.com/breckenedge/pdf_split_bookmark-pdftk"
  spec.files = Dir['README.md', 'lib/**/*']
  spec.require_path = 'lib'
  spec.add_runtime_dependency "crowd_support"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
end
