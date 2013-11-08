class YouTubeAddy
  URL_Formats = {
      regular: /^(https?:\/\/)?(www\.)?youtube.com\/watch\?(.*\&)?v=([^&]+)/,
      shortened: /^(https?:\/\/)?(www\.)?youtu.be\/([^&]+)/,
      embed: /^(https?:\/\/)?(www\.)?youtube.com\/embed\/([^&]+)/,
      invalid_chars: /[^a-zA-Z0-9\:\/\?\=\&\$\-\_\.\+\!\*\'\(\)\,]/
  }

  def self.has_invalid_chars?(youtube_url)
    !URL_Formats[:invalid_chars].match(youtube_url).nil?
  end

  def self.extract_video_id(youtube_url)
    return nil if has_invalid_chars?(youtube_url)

    if match = URL_Formats[:regular].match(youtube_url)
      return match[4]
    elsif match = URL_Formats[:shortened].match(youtube_url)
      return match[3]
    elsif match = URL_Formats[:embed].match(youtube_url)
      return match[3]
    end

    nil
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
