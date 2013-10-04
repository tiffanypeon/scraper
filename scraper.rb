require 'nokogiri'
require 'open-uri'
require 'pry'

doc = Nokogiri::HTML(open('http://students.flatironschool.com/'))

class Student

  attr_accessor :student, :student_names, :student_link, :student_img_link, 
  :student_tag_line, :student_excerpt, :twitter, :linkedin, :quote, :bio, :education,
  :work, :github, :treehouse, :codeschool, :coderwall, :cities, :favorites
  
#Index page
student = doc.css("li.home-blog-post")
student_names = doc.css("div.big-comment").collect do |name|
  name.text.strip
end

student_link = student.collect do |link|
  link.css("a").attr("href").to_s
end

student_img_link = student.collect do |image|
  image.css("img").attr("src").value
end

student_tag_line = student.collect do |tag_line|
  tag_line.css("p.home-blog-post-meta").children.to_s
end

student_excerpt = student.collect do |excerpt|
  excerpt.css("div.excerpt p").first.children.to_s.strip
end

# student_data_hash = { 
#   :name => student_names, 
#   :link => student_link, 
#   :image => student_img_link, 
#   :excerpt => student_excerpt
# }

#Student page
doc2 = Nokogiri::HTML(open('http://students.flatironschool.com/students/loganhasson.html'))

#need to set up twitter and linked in through loop 
social_links = doc2.css(".page-title .icon-twitter").first.parent.attr("href")
quote = doc2.css("div.textwidget h3").children.to_s.strip
bio = doc2.css("div#ok-text-column-2 p").first.children.to_s.strip
education = doc2.css("div#ok-text-column-3 ul li").collect do |x|
   x.text.to_s
end
work = doc2.css("div#ok-text-column-4 p").first.children.to_s.strip
# github = doc2.css("div.column.fourth").css("a").attr("href").value
# codeschool = doc2.css("div.column.fourth").css("a").attr("href").value

github = doc2.css('img').collect do |icon|
  if icon.attr('alt') == "GitHub"
    icon.parent.attr('href')
  end
end.compact.first

treehouse = doc2.css('img').collect do |icon|
  if icon.attr('alt') == "Treehouse"
    icon.parent.attr('href')
  end
end.compact.first

codeschool = doc2.css('img').collect do |icon|
  if icon.attr('alt') == "Code School"
    icon.parent.attr('href')
  end
end.compact.first

coderwall = doc2.css('img').collect do |icon|
  if icon.attr('alt') == "Coder Wall"
    icon.parent.attr('href')
  end
end.compact.first

cities =""
doc2.css('h3').each do |header|
  if header.text.downcase.strip == "favorite cities"
    cities = header.parent.parent.css("a").collect do |city|
      city.text
    end.join(", ")
  end
end

favorites =""
doc2.css('h3').each do |header|
  if header.text.downcase.strip == "favorites"
    favorites = header.parent.parent.css("a").collect do |header|
    end.join(", ")
  end
end


binding.pry

