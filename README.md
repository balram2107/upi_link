# UpiLink

Generate UPI payment deep links and QR codes in Ruby/Rails — no payment gateway, no merchant account, no transaction cut. Just link generation for direct P2P-style UPI collection.

## Installation

Add to your Gemfile:

```ruby
gem 'upi_link'
```

Then run:

```bash
bundle install
```

Or install directly:

```bash
gem install upi_link
```

## Usage

### Quick link generation

```ruby
require 'upi_link'

link = UpiLink.generate(
  pa: "yourvpa@okhdfcbank",
  pn: "Reel Store",
  am: 499,
  tn: "Order #1234"
)
# => "upi://pay?pa=yourvpa%40okhdfcbank&pn=Reel+Store&cu=INR&am=499.00&tn=Order+%231234"
```

### VPA validation

```ruby
UpiLink::VpaValidator.valid?("name@okhdfcbank")  # => true
UpiLink::VpaValidator.valid?("invalid vpa")      # => false

UpiLink::VpaValidator.validate!("bad-vpa")       # raises ArgumentError
```

### Full builder with all options

```ruby
uri = UpiLink::UriBuilder.new(
  pa: "yourvpa@okhdfcbank",
  pn: "Reel Store",
  am: 499,
  tn: "Order #1234",
  tr: "TXN20260708001",
  mc: "5411"
).to_s
```

### QR code generation

```ruby
qr = UpiLink::QrGenerator.new(link)

File.write("payment_qr.svg", qr.to_svg)
File.write("payment_qr.png", qr.to_png)
puts qr.to_terminal  # preview in terminal
```

### Mobile intent link (for HTML views)

```ruby
UpiLink::IntentLink.html_link(link, label: "Pay via UPI")
# => "<a href=\"upi://pay?...\">Pay via UPI</a>"
```

In a Rails view:

```erb
<%= raw UpiLink::IntentLink.html_link(@payment_link, label: "Pay Now") %>
```

## What this gem does NOT do

This gem generates payment **request** links only. UPI does not provide a callback or webhook for raw deep links, so this gem **cannot confirm whether a payment succeeded**. For that:

- Manually mark orders as paid (suitable for small sellers, low volume)
- Or integrate a PSP like Razorpay/Cashfree if you need automated payment confirmation

This tradeoff is intentional — it's what makes the gem free and gateway-independent.

## Supported UPI parameters

| Param | Required | Description |
|-------|----------|--------------|
| `pa`  | Yes | Payee VPA (e.g. `name@bank`) |
| `pn`  | Yes | Payee name |
| `am`  | No  | Amount (formatted to 2 decimals) |
| `tn`  | No  | Transaction note |
| `tr`  | No  | Transaction reference ID |
| `cu`  | No  | Currency (defaults to `INR`) |
| `mc`  | No  | Merchant category code |

## Development

```bash
bundle install
bundle exec rspec
```

## Contributing

Bug reports and pull requests welcome at https://github.com/YOUR_USERNAME/upi_link.

## License

MIT