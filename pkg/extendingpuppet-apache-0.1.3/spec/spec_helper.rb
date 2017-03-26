require 'puppetlabs_spec_helper/module_spec_helper'
require 'hiera'

base_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))

RSpec.configure do |c|
   c.module_path = base_path
   c.manifest_dir = File.join(base_path, 'manifests')
   c.hiera_config = File.join(base_path, 'spec', 'fixtures', 'hiera.yaml')
end
