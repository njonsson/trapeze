# Defines Trapeze::TruncateExtension.

# Adds a _truncate_ method to Dir that removes all contents of the specified
# directory using a system call.
# 
# Note that the implementation of _truncate_ removes the directory and then
# creates it again rather than simply emptying it. This is done for performance
# reasons, but it should be noted that this approach has consequences for
# filesystem permissions.
module Trapeze::TruncateExtension
  
  # Defines class methods added to Dir.
  module ClassMethods
    
    # Removes all contents of _path_ using a system call.
    def truncate(path)
      if windows_os?
        unless system("rmdir /q /s \"#{path}\"")
          raise "could not remove directory '#{path}'"
        end
      else
        unless system("rm -fr \"#{path}\"")
          raise "could not remove directory '#{path}'"
        end
      end
      unless system("mkdir \"#{path}\"")
        raise "could not create directory '#{path}'"
      end
      self
    end
    
  private
    
    def windows_os?
      ! (RUBY_PLATFORM =~ /mswin/).nil?
    end
    
  end
  
  # Extends _other_module_ with the instance methods of ClassMethods.
  def self.included(other_module)
    other_module.extend ClassMethods
  end
  
end

Dir.class_eval { include Trapeze::TruncateExtension }
