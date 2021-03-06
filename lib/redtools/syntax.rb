module RedTools

  # Create a new Syntax tool with the specified +options+.
  def Syntax(options={})
    Syntax.new(options)
  end

  # The Syntax tool simply checks all Ruby code for syntax errors.
  # It is a rather trivial tool, and is here mainly for example sake.
  #
  # NOTE: This method shells out to the command line using `ruby -c`.
  class Syntax < Tool

    # Add these folders to the $LOAD_PATH.
    def loadpath
      @loadpath
    end

    #
    def loadpath=(x)
      @loadpath = x.to_list
    end

    # Lib files to exclude.
    def exclude
      @exclude
    end

    #
    def exclude=(x)
      @exclude = x.to_list
    end

    # File name of log file or +true+ to use default `log/syntax.rdoc` file.
    def log=(file_or_bool)
      @log = file_or_bool
    end

    # Log syntax errors?
    def log
      @log
    end

    #
    def logfile
      case log
      when String
        Pathname.new(log)
      else
        project.log + 'syntax.rdoc'
      end
    end

    # Verify syntax of ruby scripts.
    def check
      #loadpath = options['loadpath'] || loadpath()
      #exclude  = options['exclude']  || exclude()

      loadpath = self.loadpath.to_list
      exclude  = self.exclude.to_list

      files   = multiglob_r(*loadpath) - multiglob_r(exclude)
      files   = files.select{ |f| File.extname(f) == '.rb' }
      max     = files.collect{ |f| f.size }.max
      list    = []

      if logfile.outofdate?(*files) or force?
        puts "Started"

        start = Time.now

        files.each do |file|
          pass = syntax_check_file(file, max)
          list << file if !pass
        end

        puts "\nFinished in %.6f seconds." % [Time.now - start]
        puts "\n#{list.size} Syntax Errors"

        log_syntax_errors(list) if log

        list.size == 0 ? true : false
      else
        puts "Syntax check is up to date."
      end
    end

    private

    #
    def syntax_check_file(file, max=nil)
      return unless File.file?(file)
      max  = max || file.size + 2
      #libs = loadpath.join(';')
      #r = system "ruby -c -Ibin:lib:test #{s} &> /dev/null"
      r = system "ruby -c -I#{libsI} #{file} > /dev/null 2>&1"
      if r
        if verbose?
          printline("%-#{max}s" % file, "[PASS]")
        else
          print '.'
        end
        true
      else
        if verbose?
          printline("%-#{max}s" % file, "[FAIL]")
          #puts("%-#{max}s  [FAIL]" % [s])
        else
          print 'E'
        end
        false
      end
    end

    # Create syntax log.
    def log_syntax_errors(list)
      #logfile = project.log + 'syntax.log'
      if list.empty?
        mkdir_p(logfile.parent)
        #logfile.write('') #logfile.clear
        File.open(logfile, 'w'){ |f| f << '' }
      else
        puts "\n-- Syntax Errors --\n"
        list.each do |file|
          print "* #{file}"
          err = `ruby -c -I#{libsI} #{file} 2>&1`
          puts(err) if verbose?
          mkdir_p(logfile.parent)
          # logfile.write("=== #{file}\n#{err}\n\n")
          File.open(logfile, 'w') do |f|
            f << "=== #{file}\n#{err}\n\n"
          end
        end
      end
    end

    private

    #
    def libsI
      loadpath.join(';')
    end

    #
    def initialize_defaults
      @loadpath = metadata.loadpath
      @exclude  = []
    end

  end

end

=begin
    # Load each script independently to ensure there are no
    # require dependency issues.
    #
    # WARNING! You should only run this on scripts that have no
    # toplevel side-effects!!!
    #
    # This takes one option +:libpath+ which is a glob or list of globs
    # of the scripts to check. By default this is all scripts in the libpath(s).
    #
    # FIXME: This isn't routing output to dev/null as expected ?

    def check_load(options={})
      #options = configure_options(options, 'check-load', 'check')

      make if compiles?

      libpath = options['libpath'] || loadpath()
      exclude = options['exclude'] || exclude()

      libpath = libpath.to_list
      exclude = exclude.to_list

      files = multiglob_r(*libpath) - multiglob_r(*exclude)
      files   = files.select{ |f| File.extname(f) == '.rb' }
      max   = files.collect{ |f| f.size }.max
      list  = []

      files.each do |s|
        next unless File.file?(s)
        #if not system "ruby -c -Ibin:lib:test #{s} &> /dev/null" then
        cmd = "ruby -I#{libpath.join(':')} #{s} > /dev/null 2>&1"
        puts cmd if debug?
        if r = system(cmd)
          puts "%-#{max}s  [PASS]" % [s]
        else
          puts "%-#{max}s  [FAIL]" % [s]
          list << s #:load
        end
      end

      puts "  #{list.size} Load Failures"

      if verbose?
        unless list.empty?
          puts "\n-- Load Failures --\n"
          list.each do |f|
            print "* "
            system "ruby -I#{libpath} #{f} 2>&1"
            #puts
          end
          puts
        end
      end
    end

=end

