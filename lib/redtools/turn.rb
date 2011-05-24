module RedTools

  #
  def Turn(options={})
    Turn.new(options)
  end

  # The Turn tool your TestUnit or MiniTest
  # unit tests using Turn.
  #
  # NOTE: This tool currently shells out to the command line.
  class Turn < Tool

    # Default test file patterns.
    DEFAULT_TESTS = ["test/**/test_*.rb", "test/**/*_test.rb" ]

    # File glob pattern of tests to run.
    attr_accessor :tests

    # Test file patterns to specially exclude.
    attr_reader :exclude

    # Add these folders to the $LOAD_PATH.
    attr_reader :loadpath

    # Libs to require when running tests.
    attr_reader :requires

    # Test against live install (i.e. Don't use loadpath option).
    attr_accessor :live

    # Either a log file name or +true+/+false+.
    attr_accessor :log

    # Special writer to ensure the value is a list.
    def loadpath=(val)
      @loadpath = val.to_list
    end

    # Special writer to ensure the value is a list.
    def exclude=(val)
      @exclude = val.to_list
    end

    # Special writer to ensure the value is a list.
    def requires=(val)
      @requires = val.to_list
    end

    # In case you forget the 's'.
    alias_method :require=, :requires=

    #
    def logfile
      case log
      when String
        project.log + log
      else
        project.log + 'turn.log'
      end
    end

    #
    def run
      run_tests
    end

    private

    # Setup default attribute values.
    def initialize_defaults
      @loadpath = metadata.loadpath
      @tests    = DEFAULT_TESTS
      @exclude  = []
      @reqiures = []
      @live     = false
    end

    # Collect test configuation.
    #def test_configuration(options=nil)
    #  #options = configure_options(options, 'test')
    #  #options['loadpath'] ||= metadata.loadpath
    #
    #  options['tests']    ||= self.tests
    #  options['loadpath'] ||= self.loadpath
    #  options['requires'] ||= self.requires
    #  options['live']     ||= self.live
    #  options['exclude']  ||= self.exclude
    #
    #  #options['tests']    = options['tests'].to_list
    #  options['loadpath'] = options['loadpath'].to_list
    #  options['exclude']  = options['exclude'].to_list
    #  options['require']  = options['require'].to_list
    #
    #  return options
    #end

    # Run unit tests. Unlike test-solo and test-cross this loads
    # all tests and runs them together in a single process.
    #
    # Note that this shells out to the testrb program.
    #
    # TODO: Generate a test log entry?
    #
    def run_tests
      tests    = self.tests
      exclude  = self.exclude
      loadpath = self.loadpath
      requires = self.requires
      live     = self.live

      #log      = options['log'] != false
      #logfile  = File.join('log', apply_naming_policy('test', 'log'))

      # what about arguments for selecting specific tests?
      #tests = EVN['TESTS'] if ENV['TESTS']

      #unless live
      #  loadpath.each do |lp|
      #    $LOAD_PATH.unshift(File.expand_path(lp))
      #  end
      #end

      files = multiglob_r(*tests) - multiglob_r(*exclude)

      if files.empty?
        report "WARNING: NO TESTS TO RUN"
        return
      end

      filelist = files.select{|file| !File.directory?(file) }

      argv = []

      if !live
        argv.concat ['-I', loadpath.join(':')]
      end

      # TODO: Use a subdirectory for log?
      # TODO: Does turn logging work?
      if log
        argv.concat ['--log', logfile]
      end

      argv.concat filelist

      command = "turn " + argv.join(' ')

      trace command

      # TODO: Make sure turn returns a failing exist code if tests fail.
      success = sh(command) #, :show=>true)

      # TODO: Why can't we do this? It just says 'No tests'.
      #begin
      #  success = ::Turn::Command.main(*argv)
      #rescue SystemExit => err
      #end
    end

    #
    def initialize_requires
      #require 'turn/command'
    end
  end

end

=begin
    # Load each test independently to ensure there are no
    # require dependency issues. This is actually a bit redundant
    # as test-solo will also cover these results. So we may deprecate
    # this in the future. This does not generate a test log entry.

    def test_load(options=nil)
      options = test_configuration(options)

      tests    = options['tests']
      loadpath = options['loadpath']
      requires = options['requires']
      live     = options['live']
      exclude  = options['exclude']

      files = multiglob_r(*tests) - multiglob_r(*exclude)

      return puts("No tests.") if files.empty?

      max   = files.collect{ |f| f.size }.max
      list  = []

      files.each do |f|
        next unless File.file?(f)
        if r = system("ruby -I#{loadpath.join(':')} #{f} > /dev/null 2>&1")
          puts "%-#{max}s  [PASS]" % [f]  #if verbose?
        else
          puts "%-#{max}s  [FAIL]" % [f]  #if verbose?
          list << f
        end
      end

      puts "  #{list.size} Load Failures"

      if verbose?
        unless list.empty?
          puts "\n-- Load Failures --\n"
          list.each do |f|
            print "* "
            system "ruby -I#{loadpath} #{f} 2>&1"
            #puts
          end
          puts
        end
      end
    end
=end
