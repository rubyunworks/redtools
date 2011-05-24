require 'redtools/core_ext'

module RedTools
  extend self

  # Tool is the base class for all RedTools.
  class Tool
    require 'redtools/tool/shell_utils'
    require 'redtools/tool/project_utils'
    require 'redtools/tool/email_utils'

    include ShellUtils
    include ProjectUtils
    include EmailUtils

    private

    #
    def initialize(options)
      initialize_requires
      initialize_defaults

      options.each do |k, v|
        send("#{k}=", v) unless v.nil? #if respond_to?("#{k}=") && !v.nil?
      end

      super() if defined?(super)
    end

    #
    def initialize_requires
    end

    #
    def initialize_defaults
    end
  end
end
