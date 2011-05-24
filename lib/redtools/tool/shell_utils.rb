#require 'ratch/shell'
require 'redtools/core_ext/shell_extensions'

module RedTools

  #
  module ShellUtils

    def initialize
      extend fileutils
      super() if defined?(super)
    end

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
    def trial?   ; @trial   ; end

    def trace?   ; @trace   ; end
    def debug?   ; @debug   ; end

    def verbose? ; @verbose ; end
    def noop?    ; @trial   ; end
    def dryrun?  ; verbose? && noop? ; end

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
    #def shell(path=Dir.pwd)
    #  @shell ||= {}
    #  @shell[path] ||= (
    #    mode = {
    #      :noop    => trial?,
    #      :verbose => trace? || (trial? && !quiet?),
    #      :quiet   => quiet?
    #    }
    #    Ratch::Shell.new(path, mode)
    #  )
    #end

    ## If method is missing, try +shell+.
    #def method_missing(meth, *args)
    #  if shell.respond_to?(meth)
    #    shell.__send__(meth, *args)
    #  else
    #    super(meth, *args) if defined?(super)
    #  end
    #end

    # TODO: Ultimately merge #glob and #multiglob.
    def multiglob(*args, &blk)
      Dir.multiglob(*args, &blk)
    end

    def multiglob_r(*args, &blk)
      Dir.multiglob_r(*args, &blk)
    end

    # Shell runner.
    def sh(cmd)
      #puts "--> system call: #{cmd}" if trace?
      trace cmd #if trace?
      return true if noop?

      if quiet?
        silently{ system(cmd) }
      else
        system(cmd)
      end
    end

    # -- File IO Shortcuts ----------------------------------------------------

    # Read file.
    def read(path)
      File.read(path)
    end

    # Write file.
    def write(path, text)
      $stderr.puts "write #{path}" if trace?
      File.open(path, 'w'){ |f| f << text } unless noop?
    end

    # Append to file.
    def append(path, text)
      $stderr.puts "append #{path}" if trace?
      File.open(path, 'a'){ |f| f << text } unless noop?
    end

    # -- File Testing ---------------------------------------------------------

    def size(path)        ; FileTest.size(path)       ; end
    def size?(path)       ; FileTest.size?(path)      ; end
    def directory?(path)  ; FileTest.directory?(path) ; end
    def symlink?(path)    ; FileTest.symlink?(path)   ; end
    def readable?(path)   ; FileTest.readable?(path)  ; end
    def chardev?(path)    ; FileTest.chardev?(path)   ; end
    def exist?(path)      ; FileTest.exist?(path)     ; end
    def exists?(path)     ; FileTest.exists?(path)    ; end
    def zero?(path)       ; FileTest.zero?(path)      ; end
    def pipe?(path)       ; FileTest.pipe?(path)      ; end
    def file?(path)       ; FileTest.file?(path)      ; end
    def sticky?(path)     ; FileTest.sticky?(path)    ; end
    def blockdev?(path)   ; FileTest.blockdev?(path)  ; end
    def grpowned?(path)   ; FileTest.grpowned?(path)  ; end
    def setgid?(path)     ; FileTest.setgid?(path)    ; end
    def setuid?(path)     ; FileTest.setuid?(path)    ; end
    def socket?(path)     ; FileTest.socket?(path)    ; end
    def owned?(path)      ; FileTest.owned?(path)     ; end
    def writable?(path)   ; FileTest.writable?(path)  ; end
    def executable?(path) ; FileTest.executable?(path); end

    def safe?(path)       ; FileTest.safe?(path)      ; end

    def relative?(path)   ; FileTest.relative?(path)  ; end
    def absolute?(path)   ; FileTest.absolute?(path)  ; end

    def writable_real?(path)   ; FileTest.writable_real?(path)   ; end
    def executable_real?(path) ; FileTest.executable_real?(path) ; end
    def readable_real?(path)   ; FileTest.readable_real?(path)   ; end

    def identical?(path, other)
      FileTest.identical?(path, other)
    end
    alias_method :compare_file, :identical?

    private # -----------------------------------------------------------------

    # Returns FileUtils module based on mode.
    def fileutils
      if dryrun?
        ::FileUtils::DryRun
      elsif noop? or trial?
        ::FileUtils::Noop
      elsif trace?
        ::FileUtils::Verbose
      else
        ::FileUtils
      end
    end

  end

end
