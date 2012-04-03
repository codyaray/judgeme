# Adapted from SinatraMore: https://github.com/nesquena/sinatra_more/

module TagHelpers
  # Creates an html input field with given type and options
  # input_tag :text, :class => "test"
  def input_tag(type, options = {})
    options = { :type => type }.merge(options)
    tag(:input, options)
  end

  # Creates an html tag with given name, content and options
  # content_tag(:p, "hello", :class => 'light')
  def content_tag(name, content = nil, options = {})
    tag(name, options.merge(:content => content))
  end

  # Creates an html tag with the given name and options
  # tag(:br, :style => 'clear:both')
  # tag(:p, :content => "hello", :class => 'large')
  def tag(name, options={})
    content = options.delete(:content)
    identity_tag_attributes.each { |attr| options[attr] = attr.to_s if options[attr]  }
    html_attrs = options.collect { |a, v| v.empty? ? nil : "#{a}=\"#{v}\"" }.compact.join(" ")
    base_tag = (!html_attrs.empty? ? "<#{name} #{html_attrs}" : "<#{name}")
    base_tag << (content ? ">#{content}</#{name}>" : " />")
  end

  protected

  # Returns a list of attributes which can only contain an identity value (i.e selected)
  def identity_tag_attributes
    [:checked, :disabled, :selected, :multiple]
  end
end