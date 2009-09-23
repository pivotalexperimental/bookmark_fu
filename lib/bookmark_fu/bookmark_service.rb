module BookmarkFu
  class BookmarkService
    BASE_URL = ""
    URL_KEY = "url"
    TITLE_KEY = "title"
    EXTRA_PARAMS = ""

    class << self
      def inherited(sub)
        Configuration.all_services << sub
      end
      
      def url(subject_url='', title='')
        "#{self::BASE_URL}?#{query_params(subject_url, title)}"
      end

      def query_params(subject_url,  title)
        params = "#{self::URL_KEY}=#{subject_url}&#{self::TITLE_KEY}=#{title}"
        params << "&#{self::EXTRA_PARAMS}" unless self::EXTRA_PARAMS.blank?
        params
      end

      def image
        "/images/social_bookmarking/#{self.name.split("::").last.underscore}.png"
      end

      def human_name
        return self::HUMAN_NAME if const_defined?(:HUMAN_NAME)
        self.name.split("::").last
      end
    end
  end

  class Delicious < BookmarkService
    BASE_URL = "http://del.icio.us/post"
    HUMAN_NAME = "del.icio.us"
  end

  class Reddit < BookmarkService
    BASE_URL = "http://reddit.com/submit"
  end

  class Digg < BookmarkService
    BASE_URL = "http://digg.com/submit"
    EXTRA_PARAMS = "phase=2"
    HUMAN_NAME = "digg"
  end

  class NewsVine < BookmarkService
    BASE_URL = "http://www.newsvine.com/_tools/seed&save"
    URL_KEY = "u"
    TITLE_KEY = "h"
  end

  class Delirious < BookmarkService
    BASE_URL = "http://de.lirio.us/bookmarks"
    URL_KEY = "address"
    EXTRA_PARAMS = "action=add&when_done=go_back"
    HUMAN_NAME = "de.lirio.us"
  end

  class Blinkbits < BookmarkService
    BASE_URL = "http://www.blinkbits.com/bookmarklets/save.php"
    URL_KEY = "source_url"
    EXTRA_PARAMS = "v=1"
    HUMAN_NAME = "blinkbits"
  end

  class BlinkList < BookmarkService
    BASE_URL = "http://www.blinklist.com/index.php"
    URL_KEY = "Url"
    TITLE_KEY = "Title"
    EXTRA_PARAMS = "Action=Blink/addblink.php"
  end

  class Blogmarks < BookmarkService
    BASE_URL = "http://blogmarks.net/my/new.php"
    EXTRA_PARAMS = "mini=1&simple=1"
    HUMAN_NAME = "blogmarks"
  end

  class Comments < BookmarkService
    BASE_URL = "http://co.mments.com/track"
    HUMAN_NAME = "co.mments"
  end

  class Fark < BookmarkService
    BASE_URL = "http://cgi.fark.com/cgi/fark/edit.pl"
    URL_KEY = "new_url"
    TITLE_KEY = "new_comment"
    EXTRA_PARAMS = "linktype=Misc"
  end

  class Furl < BookmarkService
    BASE_URL = "http://www.furl.net/storeIt.jsp"
    URL_KEY = "u"
    TITLE_KEY = "t"
  end

  class Magnolia < BookmarkService
    BASE_URL = "http://ma.gnolia.com/beta/bookmarklet/add"
    URL_KEY = "url"
    TITLE_KEY = "title"
    HUMAN_NAME = "Ma.gnolia"
  end

  class Netvouz < BookmarkService
    BASE_URL = "http://www.netvouz.com/action/submitBookmark"
  end

  class Scuttle < BookmarkService
    BASE_URL = "http://www.scuttle.org/bookmarks.php/maxpower"
    URL_KEY = "address"
    EXTRA_PARAMS = "action=add"
    HUMAN_NAME = "scuttle"
  end

  class Shadows < BookmarkService
    BASE_URL = "http://www.shadows.com/features/tcr.htm"
  end

  class Simpy < BookmarkService
    BASE_URL = "http://www.simpy.com/simpy/LinkAdd.do"
    URL_KEY = "href"
  end

  class TailRank < BookmarkService
    BASE_URL = "http://tailrank.com/share/"
    URL_KEY = "link_href"
  end

  class YahooMyWeb < BookmarkService
    BASE_URL = "http://myweb2.search.yahoo.com/myresults/bookmarklet"
    URL_KEY = "u"
    TITLE_KEY = ""
  end

  class StumbleUpon < BookmarkService
    BASE_URL = "http://www.stumbleupon.com/submit"
    URL_KEY = "url"
    TITLE_KEY = "title"
  end
  
  class Facebook < BookmarkService
    BASE_URL = "http://www.facebook.com/share.php"
    URL_KEY = "u"
  end
end