module RedTools
  extend self

  # Tool is the base class for all RedTools.
  class Tool
    require 'redtools/tool/shell_access'
    require 'redtools/tool/project_access'

    include ShellAccess
    include ProjectAccess

    private

    #
    def initialize(options)
      initialize_requires
      initialize_defaults

      options.each do |k, v|
        send("#{k}=", v) unless v.nil? #if respond_to?("#{k}=") && !v.nil?
      end
    end

    #
    def initialize_requires
    end

    #
    def initialize_defaults
    end
  end
end
