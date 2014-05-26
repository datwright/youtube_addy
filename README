Gem: youtube_addy
Author: David Wright

Contributors: Rafael da Silva Almeida (@stupied4ever)

Helper to read in YouTube urls and parse the video id and generate the youtube embed HTML code


gem 'youtube_addy'

YouTubeAddy.extract_video_id("http://www.youtube.com/watch?v=XwmtNk_Yb2Q")
=> "XwmtNk_Yb2Q"

YouTubeAddy.extract_video_id("https://youtu.be/cD4TAgdS_Xw")
=> "cD4TAgdS_Xw"

YouTubeAddy.extract_video_id("http://youtube.com/watch?v=Cd4g33ijd<script>this_should_not_be_here</scipt>")
=> nil

YouTubeAddy.youtube_embed_url("http://youtu.be/cD4TAgdS_Xw",420,315)
=> '<iframe width="420" height="315" src="http://www.youtube.com/embed/cD4TAgdS_Xw" frameborder="0" allowfullscreen></iframe>'
