require "rubygems"
require "spec"
require "hpricot"
require "cgi"
require "yaml"
require "fileutils"

dir = File.dirname(__FILE__)
RAILS_ROOT = "#{dir}/rails_root" unless Object.const_defined?(:RAILS_ROOT)

$LOAD_PATH << "#{dir}/../lib"
require "bookmark_fu"
