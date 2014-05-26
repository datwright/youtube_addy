class YouTubeAddy
  URL_FORMATS = {
      regular: /^(https?:\/\/)?(www\.)?youtube.com\/watch\?(.*\&)?v=(?<id>[^&]+)/,
      shortened: /^(https?:\/\/)?(www\.)?youtu.be\/(?<id>[^&]+)/,
      embed: /^(https?:\/\/)?(www\.)?youtube.com\/embed\/(?<id>[^&]+)/,
      embed_as3: /^(https?:\/\/)?(www\.)?youtube.com\/v\/(?<id>[^?]+)/,
      chromeless_as3: /^(https?:\/\/)?(www\.)?youtube.com\/apiplayer\?video_id=(?<id>[^&]+)/
  }

  INVALID_CHARS = /[^a-zA-Z0-9\:\/\?\=\&\$\-\_\.\+\!\*\'\(\)\,]/

  def self.has_invalid_chars?(youtube_url)
    !INVALID_CHARS.match(youtube_url).nil?
  end

  def self.extract_video_id(youtube_url)
    return nil if has_invalid_chars?(youtube_url)

    URL_FORMATS.values.each do |format_regex|
      match = format_regex.match(youtube_url)
      return match[:id] if match
    end
  end

  def self.youtube_embed_url(youtube_url, width = 420, height = 315)
    vid_id = extract_video_id(youtube_url)
    %(<iframe width="#{width}" height="#{height}" src="http://www.youtube.com/embed/#{vid_id}" frameborder="0" allowfullscreen></iframe>)
  end

  def self.youtube_regular_url(youtube_url)
    vid_id = extract_video_id(youtube_url)
    "http://www.youtube.com/watch?v=#{ vid_id }"
  end

  def self.youtube_shortened_url(youtube_url)
    vid_id = extract_video_id(youtube_url)
    "http://youtu.be/#{ vid_id }"
  end
end
