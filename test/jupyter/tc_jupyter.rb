#!/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/test_setup'

JUPYTER_COMMAND = 'jupyter notebook --no-browser'.freeze
JUPYTER_HTML_TITLE = 'Home'.freeze

# Test server
class TestServer < Minitest::Test
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
