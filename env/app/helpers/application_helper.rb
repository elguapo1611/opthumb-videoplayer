# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def s_video(asset, options={})
    options.merge!( :id => "video-player",
                    :width => 450, 
                    :height => 361, 
                    :bgcolor => '#000000', 
                    :previewImage => "/images/video.png", 
                    :autoStart =>  false,
                    :bufferTime => 20,
                    :startAt => 0 )

    player_location = "/flash/videoPlayer.swf"
    flash_vars = %{file=#{asset.public_filename}&previewImage=#{options[:previewImage]}&autoStart=#{options[:autoStart]}&bufferTime=#{options[:bufferTime]}&startAt=#{options[:startAt]}}
 
    %{<object id="#{options[:id]}"
              width="#{options[:width]}"
              height="#{options[:height]}"
              classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
              codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0">
       <param name="movie" value="#{player_location}"/>
       <param name="bgcolor" value="#{options[:bgcolor]}"/>
       <param name="allowScriptAccess" value="always"/>
       <param name="allowFullScreen" value="true"/>
       <param name="flashVars" value="#{flash_vars}"/>
       <embed src="#{player_location}"
              bgcolor="#{options[:bgcolor]}"
              width="#{options[:width]}"
              height="#{options[:height]}"
              name="FLVScrubber"
              allowScriptAccess="sameDomain"
              allowFullScreen="true"
              flashVars="#{flash_vars}"
              pluginspage="http://www.adobe.com/go/getflashplayer"/>
     </object>}
  end
end
