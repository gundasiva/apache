require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'metadata-json-lint/rake_task'
require 'puppet_blacksmith/rake_tasks'

if RUBY_VERSION >= '1.9'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
end

if not ENV['SPEC_OPTS']
  ENV['SPEC_OPTS'] = '--format documentation'
end

PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.relative = true
PuppetLint.configuration.ignore_paths = ['spec/**/*.pp', 'pkg/**/*.pp']
PuppetLint.configuration.send('disable_hard_tabs')
PuppetLint.configuration.send('disable_2sp_soft_tabs')
PuppetLint.configuration.send('disable_double_quoted_strings')

desc 'Validate manifests, templates, and ruby files'
task :validate do
  Dir['manifests/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
  Dir['spec/**/*.rb', 'lib/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file =~ %r{spec/fixtures}
  end
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end
end

desc 'Run metadata_lint, lint, validate, and spec tests.'
task :test do
  [:metadata_lint, :lint, :validate, :spec].each do |test|
    Rake::Task[test].invoke
  end
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
end
