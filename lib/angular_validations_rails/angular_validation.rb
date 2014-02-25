module AngularValidation
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :ng_application_name, :ng_controller_name, :models

    def initialize
      @models               = []
      @ng_application_name  = 'angularFormValidator'
      @ng_controller_name   = 'angularFormValidatorCntl'
    end
  end
end