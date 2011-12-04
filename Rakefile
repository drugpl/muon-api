#!/usr/bin/env rake
require "bundler/gem_tasks"

$: << './lib'
require 'muon-api/application'

desc 'Show API routes'
task :routes do
  puts Muon::API::Application.routes.join("\n")
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

task default: :test
