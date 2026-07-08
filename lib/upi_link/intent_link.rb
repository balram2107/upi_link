module UpiLink
  class IntentLink
    def self.for(upi_uri)
      # Thin wrapper - the upi:// URI works directly as an href on mobile
      # Browser/OS handles the app picker natively
      upi_uri
    end

    def self.html_link(upi_uri, label: "Pay Now")
      %(<a href="#{upi_uri}">#{label}</a>)
    end
  end
end