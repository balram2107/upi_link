require "uri"

module UpiLink
  class UriBuilder
    attr_reader :pa, :pn, :am, :tn, :tr, :cu, :mc

    def initialize(pa:, pn:, am: nil, tn: nil, tr: nil, cu: "INR", mc: nil)
      VpaValidator.validate!(pa)
      raise ArgumentError, "pn (payee name) is required" if pn.nil? || pn.strip.empty?

      @pa = pa
      @pn = pn
      @am = format_amount(am)
      @tn = tn
      @tr = tr
      @cu = cu
      @mc = mc
    end

    def to_s
      params = { pa: pa, pn: pn, cu: cu }
      params[:am] = am if am
      params[:tn] = tn if tn && !tn.strip.empty?
      params[:tr] = tr if tr && !tr.strip.empty?
      params[:mc] = mc if mc && !mc.strip.empty?

      query = params.map { |k, v| "#{k}=#{URI.encode_www_form_component(v)}" }.join("&")
      "upi://pay?#{query}"
    end

    private

    def format_amount(amount)
      return nil if amount.nil?
      format("%.2f", amount.to_f)
    end
  end
end