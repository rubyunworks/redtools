module RedTools

  #
  def Yard(options={})
    Yard.new(options)
  end

  # Yard documentation plugin generates docs for your project.
  #
  # By default it generates the yard documentaiton at site/yard,
  # unless an 'yard' directory exists in the project's root
  # directory, in which case the documentation will be stored there.
  #
  # NOTE: This tool currently shells out to the command line.
  class Yard < Tool

    # Default location to store yard documentation files.
    DEFAULT_OUTPUT       = "doc"

    # Locations to check for existance in deciding where to store yard documentation.
    DEFAULT_OUTPUT_MATCH = "{yard,site/yard,doc/yard,doc}"

    # Default main file.
    DEFAULT_README       = "README"

    # Default template to use.
    DEFAULT_TEMPLATE     = "default"

    # Deafult extra options to add to yardoc call.
    DEFAULT_EXTRA        = ''

    #
    #DEFAULT_FILES        = 'lib/**/*;bin/*'

    #
    #DEFAULT_TOPFILES     = '[A-Z]*'

    #
    def initialize_defaults
      @title    = metadata.title
      @files    = metadata.loadpath + ['bin'] # DEFAULT_FILES
      @topfiles = ['[A-Z]*']

      @output   = Dir[DEFAULT_OUTPUT_MATCH].first || DEFAULT_OUTPUT
      @readme   = DEFAULT_README
      @extra    = DEFAULT_EXTRA
      @template = ENV['YARD_TEMPLATE'] || DEFAULT_TEMPLATE
    end

    #def main_document ; document ; end
    #def site_document ; document ; end
    #def main_clean    ; clean    ; end
    #def site_clean    ; clean    ; end

  public

    # Title of documents. Defaults to general metadata title field.
    attr_accessor :title

    # Where to save yard files (doc/yard).
    attr_accessor :output

    # Template to use (defaults to ENV['RDOC_TEMPLATE'] or 'html')
    attr_accessor :template

    # Main file.  This can be file pattern. (README{,.txt})
    attr_accessor :readme

    # Which library files to document.
    attr_accessor :files

    # Alias for +files+.
    alias_accessor :include, :files

    # Which project top-files to document.
    attr_accessor :topfiles

    # Paths to specifically exclude.
    attr_accessor :exclude

    # Additional options passed to the yardoc command.
    attr_accessor :extra

    # Generate Rdoc documentation. Settings are the
    # same as the yardoc command's option, with two
    # exceptions: +inline+ for +inline-source+ and
    # +output+ for +op+.
    #
    def document(options=nil)
      options ||= {}

      title    = options['title']    || self.title
      output   = options['output']   || self.output
      readme   = options['readme']   || self.readme
      template = options['template'] || self.template
      files    = options['files']    || self.files
      exclude  = options['exclude']  || self.exclude
      extra    = options['extra']    || self.extra

      readme = Dir.glob(readme, File::FNM_CASEFOLD).first

      # TODO: Is this true?
      # YARD SUCKS --THIS DOESN'T WORK ON YARD LINE, WE MUST DO IT OURSELVES!!!
      exclude = exclude.to_list
      exclude = exclude.collect{ |g| Dir.glob(File.join(g, '**/*')) }.flatten

      topfiles = topfiles.to_list
      topfiles = topfiles.map{ |g| Dir.glob(g) }.flatten
      topfiles = topfiles.map{ |f| File.directory?(f) ? File.join(f,'**','*') : f }
      topfiles = topfiles.map{ |g| Dir.glob(g) }.flatten  # need this to remove unwanted toplevel files
      topfiles = topfiles.reject{ |f| File.directory?(f) }
      topfiles = topfiles - Dir.glob('rakefile{,.rb}', File::FNM_CASEFOLD)

      files = files.to_list
      files = files.map{ |g| Dir.glob(g) }.flatten
      files = files.map{ |f| File.directory?(f) ? File.join(f,'**','*') : f }
      files = files.map{ |g| Dir.glob(g) }.flatten  # need this to remove unwanted toplevel files
      files = files.reject{ |f| File.directory?(f) }

      mfile = project.manifest.file
      mfile = project.manifest.file.basename if mfile

      exclude = (exclude + [mfile].compact).uniq

      files = files - [mfile].compact
      files = files - exclude

      input = files.uniq

      if outofdate?(output, *input) or force?
        status "Generating #{output}"

        #target_main = Dir.glob(target['main'].to_s, File::FNM_CASEFOLD).first
        #target_main   = File.expand_path(target_main) if target_main
        #target_output = File.expand_path(File.join(output, subdir))
        #target_output = File.join(output, subdir)
        
        argv = []
        argv.concat(String === extra ? extra.split(/\s+/) : extra)
        argv.concat ['--output-dir', output] if output
        argv.concat ['--readme', readme] if readme
        argv.concat ['--template', template] if template
        argv.concat ['--title', title] if title
        #argv.concat ['exclude', exclude]
        argv.concat input
        argv.concat ['--', *topfiles]

        yard_target(output, argv)
        #rdoc_insert_ads(output, adfile)

        touch(output)
      else
        status "YARD docs are current (#{output})."
      end
    end

    # Remove yardoc products.

    def clean(options=nil)
      output = options['output'] || self.output #|| 'doc/yard'

      if File.directory?(output)
        rm_r(output)
        status "Removed #{output}" unless trial?
      end
    end

  private

    # Generate yardocs for input targets.
    def yard_target(output, argv=[])
      # remove old yardocs
      #rm_r(output) if exist?(output) and safe?(output)
      #options['output-dir'] = output
      #args = "#{extra} " + [input, options].to_console
      #argv = args.split(/\s+/)

      args = argv.join(' ')
      cmd  = "yardoc " + args

      if trial?
        puts cmd
      else
        if verbose?
          puts cmd
        end
        YARD::CLI::Yardoc.run(*argv)
      end
    end

    # Require yard library.
    def initialize_requires
      require 'yard'
    end

  end

end

