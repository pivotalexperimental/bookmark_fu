require "fileutils"

image_dir = "#{RAILS_ROOT}/public/images/social_bookmarking"
FileUtils.mkdir_p(image_dir)

dir = File.dirname(__FILE__)
system("cp #{dir}/public/images/social_bookmarking/* #{image_dir}")

require "bookmark_fu"
File.open("#{RAILS_ROOT}/config/bookmark_fu.yml", "w") do |f|
  f.write BookmarkFu::Configuration.to_yaml
end
