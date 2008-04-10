# Defines Trapeze::InflectionsExtension.

# Adds methods to String for converting among various inflected forms of
# lexical and physical names.
module Trapeze::InflectionsExtension
  
  # Returns a canonical file path, with <i>::</i> converted to <i>/</i>, other
  # nonalphanumerics converted to underscores, and everything in lowercase.
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
  # delimiters converted to <i>::</i> and nonalphanumerics deleted and rendered
  # as camel-case word breaks.
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
  
  # Returns a canonical variable or method name, with word breaks rendered as
  # underscores.
  def variablize
    pathify.gsub('/', '_').gsub /^(\d)/, '_\1'
  end
  
end

String.class_eval { include Trapeze::InflectionsExtension }
