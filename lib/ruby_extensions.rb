require 'unidecoder'

# Array extensions
Array.class_eval do
  def arithmetic_mean
    inject(0) {|sum, n| sum + n} / length.to_f
  end

  def geometric_mean
    inject(1) {|product, n| product * n} ** (1.0 / length)
  end
end

# String extensions
String.class_eval do

  def to_slug
    # TODO force_encoding could/should be removed when upgraded to Rails 3+
    self.force_encoding('UTF-8').transliterate.downcase.gsub(/[^a-z0-9 ]/, ' ').strip.gsub(/[ ]+/, '-')
  end

  # differs from the 'to_slug' method in that it leaves in the dot '.' character and removes Windows' crust from paths (removes "C:\Temp\" from "C:\Temp\mieczyslaw.jpg")
  def sanitize_as_filename
    # TODO force_encoding could/should be removed when upgraded to Rails 3+
    self.force_encoding('UTF-8').gsub(/^.*(\\|\/)/, '').transliterate.downcase.gsub(/[^a-z0-9\. ]/, ' ').strip.gsub(/[ ]+/, '-')
  end

  def transliterate
    # Unidecoder gem is missing some hyphen transliterations
    # TODO force_encoding could/should be removed when upgraded to Rails 3+
    self.force_encoding('UTF-8').gsub(/[-‐‒–—―⁃−­]/, '-').to_ascii
  end

end

# Time formatters
Time::DATE_FORMATS[:detailed] = '%Y-%m-%d %H:%M'
Time::DATE_FORMATS[:brief] = '%Y-%m-%d'
