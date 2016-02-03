class Post
  attr_reader :title, :date, :text, :sponsored
  def initialize(title, date, text, sponsored = false)
    @title = title
    @text = text
    @date = date
    @sponsored = sponsored
  end
end

class Blog
  def initialize
    @container = []
    @current_page = 0
  end

  def add_post(post)
    @container << post
  end

  def order_post_by_date
    @container.sort! {|x, y| y.date <=> x.date} 
    @arraystoshow = []
    @container.each_slice(3) do |post|
      @arraystoshow << post
    end
  end

  def publish_front_page
    order_post_by_date
     @container.each do |post|
      if post.sponsored == true
        puts title = '***' + post.title + '***'
      else
        puts title = post.title
      end
      puts '**********************'
      puts text = post.text
      puts '----------------------'
    end
  end

end



blog = Blog.new
blog.add_post(Post.new("First Post", 20160101, "Text 1"))
blog.add_post(Post.new("Sponsored Post", 20160102, "Text 2", true))
blog.add_post(Post.new("Third Post", 20160103, "Text 3"))
blog.add_post(Post.new("Forth Post", 20160104, "Text 4"))
blog.add_post(Post.new("Sponsored Post", 20160105, "Text 5", true))
blog.add_post(Post.new("Sixth Post", 20160106, "Text 6"))
blog.add_post(Post.new("Seventh Post", 20160107, "Text 7"))
blog.add_post(Post.new("Eigth Post", 20160108, "Text 8"))

blog.publish_front_page