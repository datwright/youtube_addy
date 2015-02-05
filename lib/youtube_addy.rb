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

    URL_FORMATS.values.each_with_index do |format_regex, index|
      match = format_regex.match(youtube_url)
      return match[:id] if match
      return nil if (index + 1)  == URL_FORMATS.count
    end
  end

  def self.youtube_embed_url(youtube_url)
    vid_id = extract_video_id(youtube_url)
    "https://www.youtube.com/embed/#{vid_id}"
  end

  def self.youtube_embed_iframe(youtube_url, width = 420, height = 315)
    vid_id = extract_video_id(youtube_url)
    %(<iframe id="#{vid_id}" width="#{width}" height="#{height}" src="https://www.youtube.com/embed/#{vid_id}" frameborder="0" allowfullscreen></iframe>)
  end

  def self.youtube_regular_url(youtube_url)
    vid_id = extract_video_id(youtube_url)
    "https://www.youtube.com/watch?v=#{ vid_id }"
  end

  def self.youtube_shortened_url(youtube_url)
    vid_id = extract_video_id(youtube_url)
    "https://youtu.be/#{ vid_id }"
  end
end
