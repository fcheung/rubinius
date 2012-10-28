# -*- encoding: us-ascii -*-

module FFI
  module Library
    # Once the kernel is loaded, we want to raise an error if attempting to
    # attach to a non-existent function.
    def ffi_function_missing(name, *args)
      raise FFI::NotFoundError, "Unable to find foreign function '#{name}'"
    end
  end
  class << self
    def find_type(name)
      code = FFI::TypeDefs[name]
      if !code
        if (name.is_a?(Class) &&  name < FFI::Struct) || name.is_a?(FFI::StructByValue)
          code = name
        end
      end
      raise TypeError, "Unable to resolve type '#{name}'" unless code
      return code
    end
  end
end
