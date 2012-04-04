# Adapted from SinatraMore: https://github.com/nesquena/sinatra_more/

module AssetTagHelpers
  # Creates a link element with given name, url and options
  # link_to 'click me', '/dashboard', :class => 'linky'
  def link_to(name, url = 'javascript:void(0);', options = {})
    options = { :href => url }.merge(options)
    content_tag(:a, name, options)
  end

  # Creates an image element with given url and options
  # image_tag('icons/avatar.png')
  def image_tag(url, options={})
    options = { :src => image_path(url) }.merge(options)
    tag(:img, options)
  end

  # Returns a stylesheet link tag for the sources specified as arguments
  # stylesheet_link_tag 'style', 'application', 'layout'
  def stylesheet_link_tag(*sources)
    opts = sources.last.is_a?(Hash) ? sources.pop : {}
    sources.collect { |sheet| stylesheet_tag(sheet, opts) }.join("\n")
  end

  # javascript_include_tag 'application', 'special'
  def javascript_include_tag(*sources)
    options = sources.last.is_a?(Hash) ? sources.pop : {}
    sources.collect { |script| javascript_tag(script, options) }.join("\n")
  end

  # Returns the path to the image, either relative or absolute
  def image_path(src)
    src.gsub!(/\s/, '')
    src =~ %r{^\s*(/|http)} ? src : File.join('/images', src)
  end

  protected

  # stylesheet_tag('style', :media => 'screen')
  def stylesheet_tag(source, options={})
    options = {:href => stylesheet_path(source), :media => 'screen', :rel => 'stylesheet', :type => 'text/css'}.merge(options.dup)
    tag(:link, options)
  end

  # javascript_tag 'application', :src => '/javascripts/base/application.js'
  def javascript_tag(source, options={})
    options = { :src => javascript_path(source), :type => 'text/javascript', :content => "" }.merge(options.dup)
    tag(:script, options)
  end

  def javascript_path(source)
    return source if source =~ /^http/
    result_path = "/javascripts/#{source.gsub(/.js$/, '')}"
    result_path << ".js" unless source =~ /\.js\w{2,4}$/
    stamp = File.exist?(result_path) ? File.mtime(result_path) : Time.now.to_i
    "#{result_path}?#{stamp}"
  end

  def stylesheet_path(source)
    return source if source =~ /^http/
    result_path = "/stylesheets/#{source.gsub(/.css$/, '')}"
    result_path << ".css" unless source =~ /\.css\w{2,4}$/
    stamp = File.exist?(result_path) ? File.mtime(result_path) : Time.now.to_i
    "#{result_path}?#{stamp}"
  end
end