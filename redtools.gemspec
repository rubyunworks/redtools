--- !ruby/object:Gem::Specification 
name: redtools
version: !ruby/object:Gem::Version 
  hash: 21
  prerelease: 
  segments: 
  - 0
  - 2
  - 1
  version: 0.2.1
platform: ruby
authors: 
- Thomas Sawyer
autorequire: 
bindir: bin
cert_chain: []

date: 2011-05-29 00:00:00 Z
dependencies: 
- !ruby/object:Gem::Dependency 
  name: facets
  prerelease: false
  requirement: &id001 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        hash: 3
        segments: 
        - 0
        version: "0"
  type: :runtime
  version_requirements: *id001
- !ruby/object:Gem::Dependency 
  name: reap
  prerelease: false
  requirement: &id002 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        hash: 3
        segments: 
        - 0
        version: "0"
  type: :development
  version_requirements: *id002
- !ruby/object:Gem::Dependency 
  name: redline
  prerelease: false
  requirement: &id003 !ruby/object:Gem::Requirement 
    none: false
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        hash: 3
        segments: 
        - 0
        version: "0"
  type: :development
  version_requirements: *id003
description: |-
  RedTools is a uniform collection of interfaces to common Ruby project
  development tools.
email: transfire@gmail.com
executables: []

extensions: []

extra_rdoc_files: 
- README.rdoc
files: 
- lib/redtools/announce.rb
- lib/redtools/core_ext/facets.rb
- lib/redtools/core_ext/filetest.rb
- lib/redtools/core_ext/shell_extensions.rb
- lib/redtools/core_ext/to_actual_filename.rb
- lib/redtools/core_ext/to_console.rb
- lib/redtools/core_ext/to_list.rb
- lib/redtools/core_ext/to_yamlfrag.rb
- lib/redtools/core_ext/unfold_paragraphs.rb
- lib/redtools/core_ext.rb
- lib/redtools/dnote.rb
- lib/redtools/extconf.rb
- lib/redtools/gem.rb
- lib/redtools/grancher.rb
- lib/redtools/rdoc.rb
- lib/redtools/ri.rb
- lib/redtools/rspec.rb
- lib/redtools/syntax.rb
- lib/redtools/testrb.rb
- lib/redtools/tool.rb
- lib/redtools/turn.rb
- lib/redtools/utils/email_utils.rb
- lib/redtools/utils/project_utils.rb
- lib/redtools/utils/shell_utils.rb
- lib/redtools/yard.rb
- lib/redtools.rb
- test/case_gem.rb
- test/case_rdoc.rb
- test/case_ri.rb
- test/case_rspec.rb
- test/case_syntax.rb
- test/case_testrb.rb
- test/case_turn.rb
- test/case_yard.rb
- test/fixtures/Profile
- test/fixtures/README
- test/fixtures/lib/foo.rb
- test/fixtures/spec/example_spec.rb
- test/fixtures/test/example2_test.rb
- test/fixtures/test/example_test.rb
- HISTORY.rdoc
- README.rdoc
- GPL3.txt
- COPYING.rdoc
homepage: http://rubyworks.github.com/redtools
licenses: 
- GPL3
post_install_message: 
rdoc_options: 
- --title
- RedTools API
- --main
- README.rdoc
require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      hash: 3
      segments: 
      - 0
      version: "0"
required_rubygems_version: !ruby/object:Gem::Requirement 
  none: false
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      hash: 3
      segments: 
      - 0
      version: "0"
requirements: []

rubyforge_project: redtools
rubygems_version: 1.8.2
signing_key: 
specification_version: 3
summary: Easy access to Ruby project tools.
test_files: []

