require 'ratch/shell'

module RedTools

  #
  module Tool::ShellAccess
    # A path is required for shell methods to operate.
    # If no path is set than the current working path is used.
    def path
      @path ||= Dir.pwd
    end

    # Set shell path.
    def path=(dir)
      @path = dir
    end

    attr_writer :stdout
    attr_writer :stdin
    attr_writer :stderr

    def stdout
      @stdout ||= $stdout
    end

    def stdin
      @stdin ||= $stdin
    end

    def stderr
      @stdout ||= $stderr
    end

    attr_writer :force
    attr_writer :quiet
    attr_writer :trace
    attr_writer :trial
    attr_writer :debug
    attr_writer :verbose

    def force?   ; @force   ; end
    def quiet?   ; @quiet   ; end
    def verbose? ; @verbose ; end

    def trace?   ; @trace   ; end
    def trial?   ; @trial   ; end
    def debug?   ; @debug   ; end

    #
    def print(str=nil)
      stdout.print(str.to_s) unless quiet?
    end

    #
    def puts(str=nil)
      stdout.puts(str.to_s) unless quiet?
    end

    # TODO: deprecate in favor of #report ?
    def status(message)
      stderr.puts message unless quiet?
    end

    # Internal report. Only output if in verbose mode.
    #
    # TODO: rename to #warn ?
    def trace(message)
      stderr.puts message if verbose?
    end

    # Convenient method to get simple console reply.
    def ask(question)
      stdout.print "#{question} "
      stdout.flush
      input = stdin.gets #until inp = stdin.gets ; sleep 1 ; end
      input.strip
    end

    # TODO: Until we have better support for getting input across
    # platforms, we are using #ask for passwords too.
    def password(prompt=nil)
      prompt ||= "Enter Password: "
      ask(prompt)
    end

    # Delegate to Ratch::Shell instance.
    def shell(path=Dir.pwd)
      @shell ||= {}
      @shell[path] ||= (
        mode = {
          :noop    => trial?,
          :verbose => trace? || (trial? && !quiet?),
          :quiet   => quiet?
        }
        Ratch::Shell.new(path, mode)
      )
    end

    # If method is missing, try +shell+.
    def method_missing(meth, *args)
      if shell.respond_to?(meth)
        shell.__send__(meth, *args)
      else
        super(meth, *args) if defined?(super)
      end
    end
  end

end
