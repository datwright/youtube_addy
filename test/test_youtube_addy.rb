require "test/unit"
require 'youtube_addy'

class TestYouTubeAddy < Test::Unit::TestCase

  def test_invalid_youtube_url
    assert_equal nil, YouTubeAddy.extract_video_id("not a valid url")
    assert YouTubeAddy.has_invalid_chars?("http://www.youtube.com/watch?v=something<script>badthings</script>")
    assert_equal nil, YouTubeAddy.extract_video_id("http://www.youtube.com/watch?v=something<script>badthings</script>")
  end

  def test_old_style_youtube_url_returns_code
    assert_equal "something", YouTubeAddy.extract_video_id("http://www.youtube.com/watch?v=something")
    assert_equal "XwmtNk_Yb2Q", YouTubeAddy.extract_video_id("http://www.youtube.com/watch?v=XwmtNk_Yb2Q")
    assert_equal "XwmtNk_Yb2Q", YouTubeAddy.extract_video_id("https://www.youtube.com/watch?v=XwmtNk_Yb2Q")
    assert_equal "XwmtNk_Yb2Q", YouTubeAddy.extract_video_id("www.youtube.com/watch?v=XwmtNk_Yb2Q")
    assert_equal "XwmtNk_Yb2Q", YouTubeAddy.extract_video_id("http://www.youtube.com/watch?v=XwmtNk_Yb2Q&feature=autoplay&list=AVGxdCwVVULXfH-k_IVzQbQcibTdWOSgKg&lf=artist&playnext=8")
  end

  def test_new_style_youtube_url_returns_code
    assert_equal "cD4TAgdS_Xw", YouTubeAddy.extract_video_id("http://youtu.be/cD4TAgdS_Xw")
    assert_equal "cD4TAgdS_Xw", YouTubeAddy.extract_video_id("https://youtu.be/cD4TAgdS_Xw")
    assert_equal "cD4TAgdS_Xw", YouTubeAddy.extract_video_id("youtu.be/cD4TAgdS_Xw")
  end
end