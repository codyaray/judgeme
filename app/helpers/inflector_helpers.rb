# Adapted from Rails: http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html

module InflectorHelpers

  # By default, camelize converts strings to UpperCamelCase. If the argument to camelize is set to :lower then camelize produces lowerCamelCase.
  # camelize will also convert '/' to '::' which is useful for converting paths to namespaces.
  # camelize "tag_helpers"
  def camelize(underscored_word)
    underscored_word.split('_').map! { |w| w.capitalize! }
  end

  # Tries to find a constant with the name specified in the argument string
  # The name is assumed to be the one of a top-level constant, no matter whether it starts with “::” or not.
  # constantize "Rails::InflectorHelpers"
  def constantize(camel_case_word)
    names = camel_cased_word.split('::')
    names.shift if names.empty? || names.first.empty?

    constant = Object
    names.each do |name|
      constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
    end
    constant
  end

end