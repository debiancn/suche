#!/usr/bin/env ruby

$LOAD_PATH.push(File.expand_path(File.dirname(__FILE__)))

require 'erb'
require 'webrick'
require 'jsonparser'

class Suche < WEBrick::HTTPServer
  def initialize(config = {})
    super(config)
    @html = ERB.new(open('html.erb').read)
    @ajax = ERB.new(open('ajax.erb').read, nil, '-')
    mount('/', WEBrick::HTTPServlet::FileHandler, '../public')
    mount_proc('/search') { |req, resp| search(req, resp, true) }
    mount_proc('/package') { |req, resp| search(req, resp, false) }
    @searchengine = JSONParser.new(%w(jessie stretch))
  end

  def search(request, response, is_html)
    word = request.query['search'] || ''
    word.strip!
    packages = @searchengine.search(word)
    response['Content-Type'] = 'text/html'
    links = @ajax.result(binding)
    if is_html
      response.body = @html.result(binding)
      logger.info "HTML: #{response.body.inspect}"
    else
      response.body = links
      logger.info "AJAX: #{response.body.inspect}"
    end
  end
end

server = Suche.new(Port: 9000)

%w(INT TERM).each do |signal|
  trap(signal) { server.shutdown }
end

server.start
