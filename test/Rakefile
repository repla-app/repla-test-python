require 'shellwords'

task default: %i[jupyter]

task jupyter: ['repla:tests']

namespace :repla do
  task tests: [:jupyter]

  task :test_jupter do
    jupyter_tests_file = File.join(__dir__, 'tc_jupyter.rb')
    ruby Shellwords.escape(jupyter_tests_file)
  end
end
