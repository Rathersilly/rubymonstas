# frozen_string_literal: true

# ruby monstas beginner webapp tutorial

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'yaml/store'
require './name_validator.rb'

enable :sessions

get '/' do
  @name = params['name'] if params['name']
  # @names = read_names
  @names = read_yaml
  p @names
  @message = session.delete(:message)

  erb :form
end
post '/' do
  @name = params['name'] if params['name']
  @names = read_yaml
  @message = session.delete(:message)
  # store_name('names.txt', @name)
  validator = NameValidator.new(@name, read_yaml)
  if validator.valid?
    store_yaml(@name)
    session[:message] = "Successfully stored the name #{@name}."
    redirect "/?name=#{@name}"
  else
    session[:message] = validator.message
    erb :form
  end
  
  # "OK!"
end

get '/monstas' do
  @name = params['name']
  File.open('log', 'a') { |f| f.write(params.inspect + "\n") }
  erb :form
end

# passing instance variable (the rails way)
get 'hello/:name' do
  @name = params[name]
  erb :rails_var_way.erb
end
# the other way
get 'hello/:name' do
  erb :monstas, locals: params, layout: :layout
  # can have this instead - default layout page:
  # erb :monstas, { :locals => params, :layout => true }
end

get '/hello/:name' do
  # params.inspect
  ERB.new('<h1>Hello <%= params[:name] %></h1>').result(binding)
end

# alternatively:
get '/hi/:name' do
  erb '<h1>Hello <%= name %></h1>', locals: { name: params[:name] }
end

# or even:
get '/hi2/:name' do
  erb '<h1>Hello <%= name %></h1>', locals: params
end

get '/hello/:dude' do
  template = '<h1>Hello <%= dude%></h1>'
  layout = '<html><body><%= yield %></body></html>'
  erb template, locals: params, layout: layout
end

def store_name(filename, string)
  File.open(filename, 'a+') do |f|
    f.puts string
  end
end

def read_names
  return [] unless File.exist?('names.txt')

  File.read('names.txt').split("\n")
end

def store_yaml(string)
  @store = YAML::Store.new('names.yml')
  @store.transaction do
    @store['names'] ||= []
    @store['names'] << string
  end
end

def read_yaml
  return [] unless File.exist?('names.yml')

  @store = YAML::Store.new('names.yml')
  names = @store.transaction { @store['names'] }
end
