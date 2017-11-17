require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    learn_students = Nokogiri::HTML(File.read(index_url))

    students = []

    learn_students.css("div.student-card").each do |student|
      students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(File.read(profile_url))

    binding.pry

    profile = {
      twitter: profile_page.css("div.social-icon-container")[0]['href']
      # linkedin: profile_page.css("")
      # github: profile_page.css("")
      # blog: profile_page.css("")
      # profile_quote: profile_page.css("")
      # bio: profile_page.css("")
    }
    profile
  end

end

Scraper.new
Scraper.scrape_profile_page("fixtures/student-site/students/ryan-johnson.html")
