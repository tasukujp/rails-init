
require 'rails_init'
require 'pathname'
require 'thor'

module RailsInit
  class CLI < Thor

    desc 'create [OPTIONS]', 'Create a rails application'
    option :path,        type: :string,  default: './vendor/bundle'
    option :jobs,        type: :numeric, default: 4
    option :force,       type: :boolean, default: true
    option :bundle_opts, type: :array,   default: []
    option :rails_opts,  type: :array,   default: []
    def create
      working_dir
      gemfile_init
      exec_cmd bundle_cmd
      exec_cmd rails_cmd
    end
    default_task :create

    desc 'version', 'Prints the rails-init version information'
    def version
      puts RailsInit::VERSION
    end
    map %w(-v --version) => :version

    private

    def working_dir
      print "Project directory (#{Dir.pwd}): "
      project_dir = STDIN.gets
      unless project_dir.strip!.empty?
        project_dir = Pathname.new(project_dir).expand_path
        Dir.mkdir project_dir unless Dir.exist? project_dir
        Dir.chdir project_dir
      end
    end

    def gemfile_init
      latest = /rails\s\(([0-9.]+)\)/.match(`gem search --remote "^rails$"`)[1]
      print "Rails version (latest #{latest}): "
      version = STDIN.gets
      File.open 'Gemfile', 'w' do |f|
        f.puts "source 'https://rubygems.org'"
        f.print "gem 'rails'"
        f.print ", '#{version}'" unless version.strip!.empty?
      end
    end

    def bundle_cmd
      opts = []
      opts << "--path=#{options[:path]}"
      opts << "--jobs=#{options[:jobs]}"
      "bundle install #{opts.join("\s")} #{options[:bundle_opts].join("\s")}"
    end

    def rails_cmd
      opts = []
      opts << '--force' if options[:force]
      "bundle exec rails new . #{opts.join("\s")} #{options[:rails_opts].join("\s")}"
    end

    def exec_cmd(command)
      pid = spawn(command)
      Process::wait(pid)
    end

  end
end
