module ApplicationHelper
  def title(page_title, sup_title = "")
	    content_for(:title, page_title.to_s )
	end
  
  # refactor out to Jquery Plug-in
  def heatmap(histogram={})
      content = content_tag(:br)
      # Histogram is a hash in the form of "<tag token>" => <count>
      _max = histogram.map{|k,v| histogram[k]}.max * 2
      histogram.keys.sort{|a,b| histogram[a] <=> histogram[b]}.reverse.each do |k|
        next if histogram[k] < 1
        _size = (((histogram[k] / histogram.map{|key,val| histogram[key]}.sum.to_f) * 100) + 5).to_i
        _heat = sprintf("%02x" % (255 - (_size * 25)))
        sty = "color: ##{_heat}#{_heat}#{_heat}; font-size: #{_size}px; height: #{_max}px;"
        content << content_tag(:div, k, :class => "heatmap_element", :style => sty)
      end
      content << content_tag(:br, "", :style => "clear: both;")
  end

  def google_analytics_js
    content_tag(:script, :type => 'text/javascript') do
      "var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-36627670-1']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();"
    end 
  end
  
  def google_event_track_js
    content_tag(:script, :type => 'text/javascript') do
      "var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-36627670-1']);
      _gaq.push(['_trackPageview']);
      _gap.push(['_trackEvent', 'Cards', 'Search', 'Test_Search'])"
    end 
    
  end

end
