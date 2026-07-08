module UpiLink
  class VpaValidator
    VPA_REGEX = /\A[\w.\-]{2,256}@[a-zA-Z][a-zA-Z0-9]{1,64}\z/

    def self.valid?(vpa)
      return false if vpa.nil? || vpa.strip.empty?
      !!(vpa.match?(VPA_REGEX))
    end

    def self.validate!(vpa)
      raise ArgumentError, "Invalid VPA format: #{vpa.inspect}" unless valid?(vpa)
      true
    end
  end
end