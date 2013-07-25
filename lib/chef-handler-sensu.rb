# chef-handler-sensu.rb
# 
# Author: Simple Finance <ops@simple.com>
# Copyright 2013 Simple Finance Technology Corporation.
# Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Configures a chef handler to automatically cleanup stale sensu checks

require 'rubygems'
require 'chef'
require 'chef/handler'

class SensuCleaner < Chef::Handler
  attr_reader :config

  def initialize(config = {})
    @config = config
  end

  def all_checks
    run_context.resource_collection.all_resources.select do |res|
      res.resource_name == :sensu_check
    end.collect do |check|
      check = check.name
    end
  end

  def report
    if run_status.failed? then return end
    checks = all_checks
    Dir[::File.join(node[:sensu][:directory], 'conf.d', 'checks', '*')].reject do |file|
      checks.include?(::File.basename(file, '.json'))
    end.each do |file|
      Chef::Log.warn "No sensu_check resources found for '#{::File.basename(file, '.json')}', deleting!"
      FileUtils.rm(file)
    end
  end
end

