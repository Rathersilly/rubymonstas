# frozen_string_literal: true

class Application
  def call(env)
    puts inspect_env(env)
    status = 200
    headers = { 'Content-Type' => 'text/html' , 'mood' =>'perturbed'}
    body = ['<html><body><h1>Yay, your first web application! <3</h1></body></html>']

    [status, headers, body]
  end
  def inspect_env(env)
    puts format('Request headers', request_headers(env))
    puts format('Server info', server_info(env))
    puts format('Rack info', rack_info(env))
  end
  def request_headers(env)
    env.select {|k,v| k.include?('HTTP_') }
  end
  def server_info(env)
    env.reject{|k,v|k.include?('HTTP') or k.include?('rack.')}
  end
  def rack_info(env)
    env.select{|k,v| k.include?('rack.')}
  end
  def format(heading,pairs)
    [heading, '', format_pairs(pairs), "\n"].join("\n")
  end
  def format_pairs(pairs)
    pairs.map{|k,v|' ' +[k,v.inspect].join(': ')}
  end

    

end

run Application.new
