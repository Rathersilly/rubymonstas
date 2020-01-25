# frozen_string_literal: true

class Application
  def call(env)
    handle_request(env['REQUEST_METHOD'], env['PATH_INFO'])
  end

  private

  def handle_request(method, path)
    if method == 'GET'
      get(path)
    else
      method_not_allowed(method)
    end
  end

  def get(path)
    [200, { 'Content-Type' => 'text/html' }, ["You have found the path #{path}, using GET"]]
  end

  def method_not_allowed(method)
    [405, {}, ["Method not allowed: #{method}"]]
  end
end

run Application.new
