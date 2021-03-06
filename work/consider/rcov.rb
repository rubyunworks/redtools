module RedTools

  # Create new RCov tool with the specified +options+.
  def RCov(options={})
    RCov.new(options)
  end

  # RCov code coverage utility.
  #
  # NOTE: This tool currently shells out to the command line.
  class RCov < Tool

    # Default script files to run via rcov.
    DEFAULT_SCRIPTS = ['test/**/test_*.rb', 'test/**/*_test.rb']

    # Output directory. This defaults to an rcov/ folder in the
    # the project's log directory.
    attr :output

    # Pattern of script files to run for coverage check. Usually
    # these are your test files, but they can be any ruby scripts.
    # By default this is includes .rb file in the test/ directory
    # whose name begins with test_ or ends with _test.
    attr :scripts

    # Additional commandline options string passed to rcov.
    attr :options

    # TODO: Default scripts must be improved. How?
    def initialize_defaults
      @output  = project.log + 'rcov'
      @scripts = DEFAULT_SCRIPTS
    end

    # Shell out to rcov.
    def analyze
      files = scripts.map{ |s| Dir[s] }.flatten
      # create output directory if needed
      mkdir_p(output) unless File.exist?(output)
      # if nothing is out-of-date
      if outofdate?(output, *files) or force?
        sh "rcov #{options} -t -o #{output} #{files.join(' ')}"
        report "rcov updated (at #{output.sub(Dir.pwd,'')})"
      else
        report "rcov is current (at #{output.sub(Dir.pwd,'')})"
      end
    end

    # Reset output directory, ie. set mtime to oldest date possible.
    def reset
      if File.directory?(output)
        File.utime(0,0,output)
        report "reset #{output}" #unless trial?
      end
    end

    # Remove output directory and it's contents.
    def clean
      if File.directory?(output)
        rm_r(output)
        report "removed #{output}" #unless trial?
      end
    end

    # Require RCov library.
    #
    #def require_rubygems
    #  begin
    #    require 'rubygems/specification'
    #    ::Gem::manage_gems
    # rescue LoadError
    #    raise LoadError, "RubyGems is not installed."
    # end
    #end

  end

end
