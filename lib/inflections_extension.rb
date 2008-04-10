# Defines Trapeze::InflectionsExtension.

# Adds methods to String for converting among various inflected forms of
# lexical and physical identifiers.
module Trapeze::InflectionsExtension
  
  # Returns a canonical file path, with <i>:</i> converted to <i>/</i>, other
  # nonalphanumeric characters converted to underscores and everything in
  # lowercase.
  # 
  # Examples:
  # 
  #   'FooBar'.pathify          # => 'foo_bar'
  #   'FooBar::BazBat'.pathify  # => 'foo_bar/baz_bat'
  def pathify
    self.gsub(/:+/,                  '/').
         gsub(/([a-z\d])([A-Z])/,    '\1_\2').
         gsub(/([A-Z])([A-Z][a-z])/, '\1_\2').
         gsub(/([a-z])(\d)/,         '\1_\2').
         gsub(/[^A-Za-z\d_\/]/,      '_').
         gsub(/\//,                  '/').
         gsub(/_+/,                  '_').
         downcase
  end
  
  # Returns a canonical, namespaced type name, with filesystem directory
  # delimiters converted to <i>::</i> and nonalphanumeric characters deleted and
  # rendered as camel-case word breaks.
  # 
  # Examples:
  # 
  #   'foo_bar'.typify          # => 'FooBar'
  #   'foo_bar/baz_bat'.typify  # => 'FooBar::BazBat'
  def typify
    self.gsub(/[^A-Za-z\d][a-z]/) { |text| text.upcase }.
         gsub(/[\\\/:]+/,                     '::').
         gsub(/([a-z\d])[^a-z\d:]([a-z\d])/i, '\1\2').
         gsub(/[^a-z\d:]+/i,                  '_').
         gsub(/^_+/,                          '').
         gsub(/_+$/,                          '').
         gsub(/^(\d)/,                        '_\1').
         gsub(/^[a-z]/) { |char| char.upcase }
  end
  
  # Returns a canonical variable or method name, with nonalphanumeric characters
  # converted as underscores and everything in lowercase.
  # 
  # Examples:
  # 
  #   'FooBar'.pathify          # => 'foo_bar'
  #   'FooBar::BazBat'.pathify  # => 'foo_bar_baz_bat'
  def variablize
    pathify.gsub('/', '_').gsub /^(\d)/, '_\1'
  end
  
end

String.class_eval { include Trapeze::InflectionsExtension }
