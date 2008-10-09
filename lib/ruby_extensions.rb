require 'unidecode'

# Object extensions
Object.class_eval do
  def try(meth, *args, &block)
    __send__(meth, *args, &block) if respond_to? meth
  end
end

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
    self.transliterate.downcase.gsub(/[^a-z0-9 ]/, ' ').strip.gsub(/[ ]+/, '-')
  end

  # differs from the 'to_slug' method in that it leaves in the dot '.' character and removes Windows' crust from paths (removes "C:\Temp\" from "C:\Temp\mieczyslaw.jpg")
  def sanitize_as_filename
    self.gsub(/^.*(\\|\/)/, '').transliterate.downcase.gsub(/[^a-z0-9\. ]/, ' ').strip.gsub(/[ ]+/, '-')
  end

  def transliterate
    # Unidecode gem is missing some hyphen transliterations
    self.gsub(/[-‐‒–—―⁃−­]/, '-').to_ascii
  end

end
