require "bookmark_fu"

module BookmarkFu::SocialBookmarkingHelper
  def bookmarks(url, title)
    builder = Markaby::Builder.new({}, self)
    me = self
    builder.span do
      BookmarkFu.services.each do |service|
        text me.bookmark(service, url, title)
      end
    end
    builder.to_s
  end

  def bookmark(service, url, title)
    builder = Markaby::Builder.new({}, self)
    builder.span(:class => "social_bookmark_item") do
      a(:href => service.url(url, title)) do
        img(:src => service.image, :alt => service.human_name, :title => service.human_name)
      end
    end
    builder.to_s
  end
end
