require "rqrcode"

module UpiLink
  class QrGenerator
    def initialize(upi_uri)
      @upi_uri = upi_uri
      @qr = RQRCode::QRCode.new(upi_uri)
    end

    def to_svg(module_size: 6)
      @qr.as_svg(
        offset: 0,
        color: "000",
        shape_rendering: "crispEdges",
        module_size: module_size,
        standalone: true
      )
    end

    def to_png(size: 300)
      png = @qr.as_png(size: size)
      png.to_s
    end

    def to_terminal
      @qr.as_ansi(
        light: "\033[47m",
        dark: "\033[40m",
        fill_character: "  ",
        quiet_zone_size: 2
      )
    end
  end
end