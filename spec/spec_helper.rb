require 'serverspec'
require 'serverspec_extra'
require 'net/ssh'
require 'yaml'

include Specinfra::Helper::ExtraProperties

set :backend, :ssh

# load vars from yaml file
host_vars = YAML.load_file('inventories/hosts')
group_vars = YAML.load_file('inventories/group_vars')
global_vars = YAML.load_file('inventories/global_vars')

# set vars
set_group_property group_vars
set_global_property global_vars

RSpec.configure do |c|
  c.host = ENV['TARGET_HOST']
  set_property host_vars[c.host][:vars]
end

# SUDO PASSWORD setting
if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail "highline is not available. Try installing it."
  end
  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end

host = ENV['TARGET_HOST']

options = Net::SSH::Config.for(host)

options[:user] ||= Etc.getlogin

set :host,        options[:host_name] || host

# SSH PASSWORD setting
if ENV['ASK_LOGIN_PASSWORD']
  options[:password] = ask("\nEnter login password: ") { |q| q.echo = false }
else
  options[:password] = ENV['LOGIN_PASSWORD']
end

set :ssh_options, options

# Disable sudo
# set :disable_sudo, true


# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'

set :request_pty, true
