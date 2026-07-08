# frozen_string_literal: true

require_relative "upi_link/version"
require_relative "upi_link/vpa_validator"
require_relative "upi_link/uri_builder"
require_relative "upi_link/qr_generator"
require_relative "upi_link/intent_link"

module UpiLink
  class Error < StandardError; end

  # Convenience method for quick usage
  def self.generate(pa:, pn:, am: nil, tn: nil, tr: nil)
    UriBuilder.new(pa: pa, pn: pn, am: am, tn: tn, tr: tr).to_s
  end
end
