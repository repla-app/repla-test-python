#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative 'lib/test_setup'

JUPYTER_HTML_TITLE = 'Home'.freeze

# Test server
class TestJupyter < Minitest::Test
  JUPYTER_COMMAND = 'jupyter notebook --no-browser'.freeze
  def setup
    `#{SERVER_BUNDLE_COMMAND} "#{JUPYTER_COMMAND}"`
    window_id = nil
    Repla::Test.block_until do
      window_id = Repla::Test::Helper.window_id
      !window_id.nil?
    end
    refute_nil(window_id)
    @window = Repla::Window.new(window_id)
  end

  def teardown
    @window.close
  end

  def test_jupyter
    javascript = File.read(Repla::Test::TITLE_JAVASCRIPT_FILE)
    result = nil
    Repla::Test.block_until do
      result = @window.do_javascript(javascript)
      result == JUPYTER_HTML_TITLE
    end
    assert_equal(JUPYTER_HTML_TITLE, result)
  end
end

class TestJupyterDefault < Minitest::Test
  JUPYTER_COMMAND_DEFAULT = 'jupyter notebook'.freeze
  def setup
    `#{SERVER_BUNDLE_COMMAND} "#{JUPYTER_COMMAND_DEFAULT}"`
    window_id = nil
    Repla::Test.block_until do
      window_id = Repla::Test::Helper.window_id
      !window_id.nil?
    end
    refute_nil(window_id)
    @window = Repla::Window.new(window_id)
  end

  def teardown
    @window.close
  end

  def test_jupyter
    javascript = File.read(Repla::Test::TITLE_JAVASCRIPT_FILE)
    result = nil
    Repla::Test.block_until do
      result = @window.do_javascript(javascript)
      result == JUPYTER_HTML_TITLE
    end
    assert_equal(JUPYTER_HTML_TITLE, result)
  end
end
