--- !ruby/object:Gem::Specification 
name: redtools
version: !ruby/object:Gem::Version 
  hash: 27
  prerelease: 
  segments: 
  - 0
  - 1
  - 0
  version: 0.1.0
platform: ruby
authors: 
- Thomas Sawyer
autorequire: 
bindir: bin
cert_chain: []

date: 2011-05-23 00:00:00 Z
dependencies: 
- !ruby/object:Gem::Dependency 
  name: ratch
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
- HISTORY.rdoc
- doc
- doc/RedTools.html
- doc/top-level-namespace.html
- doc/js
- doc/js/app.js
- doc/js/full_list.js
- doc/js/jquery.js
- doc/frames.html
- doc/_index.html
- doc/RedTools
- doc/RedTools/RubyProf.html
- doc/RedTools/Tool.html
- doc/RedTools/Gem.html
- doc/RedTools/RI.html
- doc/RedTools/RCov.html
- doc/RedTools/Syntax.html
- doc/RedTools/Grancher.html
- doc/RedTools/Make.html
- doc/RedTools/Tool
- doc/RedTools/Tool/ShellAccess.html
- doc/RedTools/Tool/ProjectAccess.html
- doc/RedTools/Yard.html
- doc/RedTools/Testrb.html
- doc/RedTools/Email.html
- doc/RedTools/Turn.html
- doc/RedTools/RSpec.html
- doc/RedTools/RDoc.html
- doc/class_list.html
- doc/method_list.html
- doc/index.html
- doc/css
- doc/css/full_list.css
- doc/css/common.css
- doc/css/style.css
- doc/file.README.html
- doc/file_list.html
- test
- Profile
- README.rdoc
- pkg
- lib
- lib/redtools
- lib/redtools/syntax.rb
- lib/redtools/ri.rb
- lib/redtools/yard.rb
- lib/redtools/rdoc.rb
- lib/redtools/testrb.rb
- lib/redtools/make.rb
- lib/redtools/turn.rb
- lib/redtools/grancher.rb
- lib/redtools/gem.rb
- lib/redtools/excellent.rb
- lib/redtools/tool.rb
- lib/redtools/rcov.rb
- lib/redtools/rubyprof.rb
- lib/redtools/tool
- lib/redtools/tool/project_access.rb
- lib/redtools/tool/shell_access.rb
- lib/redtools/rspec.rb
- lib/redtools/email.rb
- lib/redtools.rb
- Version
- work
- work/sandbox
- work/sandbox/README
- work/sandbox/lib
- work/sandbox/lib/foo.rb
homepage: http://rubyworks.github.com/redtools
licenses: 
- Apache 2.0
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

