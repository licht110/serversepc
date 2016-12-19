require 'rake'
require 'rspec/core/rake_task'
require 'parallel'
require 'open3'
require 'yaml'

inventory_file = ARGV[1]

hosts = YAML.load_file(inventory_file)

hosts = hosts.map do |host|
  {
    :name       => host[0],
    :short_name => host[0].split('.')[0],
    :roles      => host[1][:roles],
  }
end

desc "Run serverspec to all hosts parallelly"
task :parallel=> 'serverspec:parallel'

desc "Run serverspec serially"
task :serial => 'serverspec:serial'

class ServerspecTask < RSpec::Core::RakeTask

  attr_accessor :target

  def spec_command
    cmd = super
    "env TARGET_HOST=#{target} #{cmd}"
  end

end

namespace :serverspec do
  hosts.each do |host|
    desc "Run serverspec to #{host[:name]}"
    ServerspecTask.new(host[:name].to_sym) do |t|
      t.target = host[:name]
      t.pattern = 'spec/{' + host[:roles].join(',') + '}/*_spec.rb'
      t.fail_on_error = false
    end
  end
  task :serial => hosts.map {|h| 'serverspec:' + h[:name] }
  task :parallel do
    Parallel.each(hosts, in_processes: 20) do |host|
      command = "rake serverspec:" + host[:name] + " " + inventory_file
      o, e, s = Open3.capture3(command)
      puts o
      puts e
    end
  end
end
