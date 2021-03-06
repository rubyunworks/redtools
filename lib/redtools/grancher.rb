module RedTools

  #
  def Grancher(options={})
    Grancher.new(options)
  end

  # This tool copies designated files to a git branch.
  # This is useful for dealing with situations like GitHub's
  # gh-pages branch for hosting project websites.[1]
  #
  # [1] A poor design copied from the Git project itself.
  class Grancher < Tool

    ## Gancher will be available automatically if the POM repository
    ## entry indicates the use of GitHub.
    #autorun do |project|
    #  /github.com/ =~ project.metadata.repository
    #end

    # The brach into which to save the files.
    attr_accessor :branch

    # The remote to use (defaults to 'origin').
    attr_accessor :remote

    # The repository loaiton (defaults to current project directory).
    #attr_accessor :repo

    # Message to output.
    #attr_accessor :message

    # List of any files/directory to not overwrite in branch.
    attr_accessor :keep

    # Do not overwrite anything. Defaults to +trial+ setting.
    attr_accessor :keep_all

    # List of directories and files to transfer.
    # If a single directory entry is given then the contents
    # of that directory will be transfered.
    attr_reader :sitemap

    #
    def sitemap=(entries)
      case entries
      when String, Symbol
        @sitemap = [entries]
      else
        @sitemap = entries
      end
    end

    def grancher
      @grancher ||= ::Grancher.new do |g|
        g.branch  = branch
        g.push_to = remote

        #g.repo   = repo if repo  # defaults to '.'

        g.keep(*keep) if keep
        g.keep_all    if keep_all

        #g.message = (quiet? ? '' : 'Tranferred site files to #{branch}.')

        sitemap.each do |(src, dest)|
          trace "transfer: #{src} => #{dest}"
          dest = nil if dest == '.'
          if directory?(src)
            dest ? g.directory(src, dest) : g.directory(src)
          else
            dest ? g.file(src, dest)      : g.file(src)
          end
        end
      end
    end

    #
    def transfer
      sleep 1  # FIXME: had to pause so grancher will not bomb!
      require 'grancher'
      grancher.commit
      report "Tranferred site files to #{branch}."
    end

    #
    def publish
      require 'grancher'
      grancher.push
      report "Pushed site files to #{remote}."
    end

  private

    # TODO: Does the POM Project provide the site directory?
    def initialize_defaults
      @branch   ||= 'gh-pages'
      @remote   ||= 'origin'
      @sitemap  ||= default_sitemap
      #@keep_all ||= trial?
    end

    # Default sitemap includes the website directoy, if it exists
    # and doc if it exists. Eg.
    #
    #    - site
    #    - doc
    #
    # Otherwise it includes just the doc/rdoc or doc directory.
    #
    #--
    # We have loop over the contents of the site directory in order
    # to pick up symlinks b/c Grancher doesn't support them.
    #++
    def default_sitemap
      sm = []
      site = Dir['{site,web,website,www}'].first
      if site
        #sm << site
        paths = Dir.entries(site)
        paths.each do |path|
          next if path == '.' or path == '..'
          sm << [File.join(site, path), path]
        end
      else
        if path = Dir["#{name}/doc/rdoc"].first
          sm << path
        elsif path = Dir['doc/rdoc'].first
          sm << path
        elsif path = Dir['doc'].first
          sm << path 
        end
      end
      sm
    end

  end

end

