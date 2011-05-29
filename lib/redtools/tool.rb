require 'redtools/core_ext'

module RedTools
  extend self

  # Tool is the base class for all RedTools.
  class Tool
    require 'redtools/utils/shell_utils'
    require 'redtools/utils/project_utils'
    require 'redtools/utils/email_utils'

    include ShellUtils
    include ProjectUtils
    include EmailUtils

    private

    # Create a new tool object.
    #
    # This sets up utility extensions and assigns options to setter attributes
    # if they exist and values are not nil. That last point is important.
    # You must use 'false' to purposely negate an option, as +nil+ will instead
    # allow any default setting to be used.
    #
    def initialize(options)
      initialize_extension_defaults

      initialize_requires
      initialize_defaults

      initialize_options(options)

      initialize_extensions
    end

    # TODO: It would be best if an error were raised if an option is not
    # supported, however for now only a warning will be issued, b/c of 
    # subclassing makes things more complicated.
    def initialize_options(options)
      @options = options

      options.each do |k, v|
        #send("#{k}=", v) unless v.nil? #if respond_to?("#{k}=") && !v.nil?
        if respond_to?("#{k}=")
          send("#{k}=", v) unless v.nil? #if respond_to?("#{k}=") && !v.nil?
        else
          warn "#{self.class.name} does not respond to `#{k}`."
        end
      end
    end

    #
    def initialize_extension_defaults
      super if defined?(super) 
    end

    # Require support libraries needed by this service.
    #
    #   def initialize_requires
    #     require 'ostruct'
    #   end
    #
    def initialize_requires
    end

    # When subclassing, put default instance variable settngs here.
    #
    # Examples
    #
    #   def initialize_defaults
    #     @gravy = true
    #   end
    #
    def initialize_defaults
    end

    # --- Odd Utilities -------------------------------------------------------

    require 'facets/platform'

    # Current platform.
    def current_platform
      Platform.local.to_s
    end

    # TODO: Is naming_policy really useful?
    # TODO: How to set this in a more universal manner?
    #
    def naming_policy(*policies)
      if policies.empty?
        @naming_policy ||= ['down', 'ext']
      else
        @naming_policy = policies
      end
    end

    #
    #
    def apply_naming_policy(name, ext)
      naming_policy.each do |policy|
        case policy.to_s
        when /^low/, /^down/
          name = name.downcase
        when /^up/
          name = name.upcase
        when /^cap/
          name = name.capitalize
        when /^ext/
          name = name + ".#{ext}"
        end
      end
      name
    end

  end
end
