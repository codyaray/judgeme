# Adapted from SinatraMore: https://github.com/nesquena/sinatra_more/

module FormatHelpers

  # Returns escaped text to protect against malicious content
  def escape_html(text)
    Rack::Utils.escape_html(text)
  end
  alias h escape_html
  alias sanitize_html escape_html

end