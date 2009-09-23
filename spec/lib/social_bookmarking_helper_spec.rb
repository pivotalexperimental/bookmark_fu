require File.dirname(__FILE__) + '/../bookmark_fu_spec_helper'

module BookmarkFu
  describe SocialBookmarkingHelper, "#bookmarks", :shared => true do
    before do
      BookmarkFu::Configuration.instance = BookmarkFu::Configuration.new
    end

    after do
      BookmarkFu::Configuration.instance = BookmarkFu::Configuration.new
    end
  end

  describe SocialBookmarkingHelper, "#bookmarks when services not set" do
    it_should_behave_like "BookmarkFu::SocialBookmarkingHelper#bookmarks"

    before do
      @fixture = Object.new
      @fixture.extend SocialBookmarkingHelper
    end

    it "renders images" do
      url = "http://mywebsite.com"
      title = "Come See My Website"
      html = @fixture.bookmarks(url, title)
      doc = Hpricot(html)
      images = doc.search("img").collect {|img| CGI.unescapeHTML(img[:src])}

      images.should == [
        "/images/social_bookmarking/delicious.png",
        "/images/social_bookmarking/reddit.png",
        "/images/social_bookmarking/digg.png",
        "/images/social_bookmarking/news_vine.png",
        "/images/social_bookmarking/delirious.png",
        "/images/social_bookmarking/blinkbits.png",
        "/images/social_bookmarking/blink_list.png",
        "/images/social_bookmarking/blogmarks.png",
        "/images/social_bookmarking/comments.png",
        "/images/social_bookmarking/fark.png",
        "/images/social_bookmarking/furl.png",
        "/images/social_bookmarking/magnolia.png",
        "/images/social_bookmarking/netvouz.png",
        "/images/social_bookmarking/scuttle.png",
        "/images/social_bookmarking/shadows.png",
        "/images/social_bookmarking/simpy.png",
        "/images/social_bookmarking/tail_rank.png",
        "/images/social_bookmarking/yahoo_my_web.png",
        "/images/social_bookmarking/stumble_upon.png",
        "/images/social_bookmarking/facebook.png"
      ]
    end

    it "renders research list with type link with type parameter" do
      url = "http://mywebsite.com"
      title = "Come See My Website"
      html = @fixture.bookmarks(url, title)
      doc = Hpricot(html)
      hrefs = doc.search("a").collect {|link| CGI.unescapeHTML(link[:href])}

      hrefs.should == [
        "http://del.icio.us/post?url=#{url}&title=#{title}",
        "http://reddit.com/submit?url=#{url}&title=#{title}",
        "http://digg.com/submit?url=#{url}&title=#{title}&phase=2",
        "http://www.newsvine.com/_tools/seed&save?u=#{url}&h=#{title}",
        "http://de.lirio.us/bookmarks?address=#{url}&title=#{title}&action=add&when_done=go_back",
        "http://www.blinkbits.com/bookmarklets/save.php?source_url=#{url}&title=#{title}&v=1",
        "http://www.blinklist.com/index.php?Url=#{url}&Title=#{title}&Action=Blink/addblink.php",
        "http://blogmarks.net/my/new.php?url=#{url}&title=#{title}&mini=1&simple=1",
        "http://co.mments.com/track?url=#{url}&title=#{title}",
        "http://cgi.fark.com/cgi/fark/edit.pl?new_url=#{url}&new_comment=#{title}&linktype=Misc",
        "http://www.furl.net/storeIt.jsp?u=#{url}&t=#{title}",
        "http://ma.gnolia.com/beta/bookmarklet/add?url=#{url}&title=#{title}",
        "http://www.netvouz.com/action/submitBookmark?url=#{url}&title=#{title}",
        "http://www.scuttle.org/bookmarks.php/maxpower?address=#{url}&title=#{title}&action=add",
        "http://www.shadows.com/features/tcr.htm?url=#{url}&title=#{title}",
        "http://www.simpy.com/simpy/LinkAdd.do?href=#{url}&title=#{title}",
        "http://tailrank.com/share/?link_href=#{url}&title=#{title}",
        "http://myweb2.search.yahoo.com/myresults/bookmarklet?u=#{url}&=#{title}",
        "http://www.stumbleupon.com/submit?url=#{url}&title=#{title}",
        "http://www.facebook.com/share.php?u=#{url}&title=#{title}",
      ]
    end
  end

  describe SocialBookmarkingHelper, "#bookmarks when pointing to default configuration file" do
    it_should_behave_like "BookmarkFu::SocialBookmarkingHelper#bookmarks"

    before do
      @fixture = Object.new
      @fixture.extend SocialBookmarkingHelper

      @config_dir = "#{RAILS_ROOT}/config"
      FileUtils.mkdir_p(@config_dir)
      File.exists?("#{@config_dir}/bookmark_fu.yml").should == false

      dir = File.dirname(__FILE__)
      system("cp #{dir}/../fixtures/bookmark_fu.yml #{@config_dir}") || raise("Copy failed")
      BookmarkFu::Configuration.refresh!
    end

    after do
      system("rm #{@config_dir}/bookmark_fu.yml") || raise("Delete failed")
    end

    it "renders research list with type link with type parameter" do
      url = "http://mywebsite.com"
      title = "Come See My Website"
      html = @fixture.bookmarks(url, title)
      doc = Hpricot(html)
      hrefs = doc.search("a").collect {|link| CGI.unescapeHTML(link[:href])}

      hrefs.should == [
        "http://digg.com/submit?url=#{url}&title=#{title}&phase=2",
        "http://del.icio.us/post?url=#{url}&title=#{title}",
        "http://reddit.com/submit?url=#{url}&title=#{title}",
      ]
    end
  end

  describe SocialBookmarkingHelper, "#bookmarks when pointed to configuration yml file" do
    it_should_behave_like "BookmarkFu::SocialBookmarkingHelper#bookmarks"

    before do
      @fixture = Object.new
      @fixture.extend SocialBookmarkingHelper

      dir = File.dirname(__FILE__)
      yml_file = "#{dir}/../fixtures/bookmark_fu.yml"
      File.exists?(yml_file).should == true
      BookmarkFu::Configuration.configuration_file = yml_file
      BookmarkFu::Configuration.refresh!
    end

    it "renders research list with type link with type parameter" do
      url = "http://mywebsite.com"
      title = "Come See My Website"
      html = @fixture.bookmarks(url, title)
      doc = Hpricot(html)
      hrefs = doc.search("a").collect {|link| CGI.unescapeHTML(link[:href])}

      hrefs.should == [
        "http://digg.com/submit?url=#{url}&title=#{title}&phase=2",
        "http://del.icio.us/post?url=#{url}&title=#{title}",
        "http://reddit.com/submit?url=#{url}&title=#{title}",
      ]
    end
  end

  describe SocialBookmarkingHelper, "#bookmarks when specific services are set" do
    it_should_behave_like "BookmarkFu::SocialBookmarkingHelper#bookmarks"

    before do
      @fixture = Object.new
      @fixture.extend SocialBookmarkingHelper
      BookmarkFu::Configuration.services = [BookmarkFu::Digg, BookmarkFu::Delicious, BookmarkFu::Reddit]
    end

    it "renders research list with type link with type parameter" do
      url = "http://mywebsite.com"
      title = "Come See My Website"
      html = @fixture.bookmarks(url, title)
      doc = Hpricot(html)
      hrefs = doc.search("a").collect {|link| CGI.unescapeHTML(link[:href])}

      hrefs.should == [
        "http://digg.com/submit?url=#{url}&title=#{title}&phase=2",
        "http://del.icio.us/post?url=#{url}&title=#{title}",
        "http://reddit.com/submit?url=#{url}&title=#{title}",
      ]
    end
  end
end
