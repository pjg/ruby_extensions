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
    # Unidecode is missing some hyphen conversions
    self.gsub(/[-‐‒–—―⁃−­]/, '-').to_ascii.downcase.gsub(/[^a-z0-9 ]/, ' ').strip.gsub(/[ ]+/, '-')
  end
end
