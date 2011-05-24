require 'pom'

module RedTools

  #
  module Tool::ProjectAccess

    # Common access to project.
    def self.project(path=Dir.pwd)
      if root = ::POM::Project.root(path)
        @@projects ||= {}
        @@projects[root] ||= ::POM::Project.new(root)
      else
        nil # ?
      end
    end

    #
    def project(path=Dir.pwd)
      @project ||= Tool::ProjectAccess.project(path)
    end

    #
    def metadata
      project.metadata
    end

    #
    def root
      project.root
    end

  end

end
