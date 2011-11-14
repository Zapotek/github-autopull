require 'rubygems'
require 'sinatra'
require 'yaml'
require 'json'
require File.dirname( File.expand_path( __FILE__ ) ) + '/app'

run Sinatra::Application
