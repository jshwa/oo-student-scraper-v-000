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

    profile_page.css("div.social-icon-container a").each do |social|
      case social
      when /twitter.com/
        profile[:twitter] = social['href']
      when /linkedin.com/
        profile[:linkedin] = social['href']
      when /github.com/
        profile[:github] = social['href']
      else
        profile[:blog] = social['href']
      end
    end

    profile << {
      profile_quote: profile_page.css("div.vitals-text-container div.profile-quote").text,
      bio: profile_page.css("div.bio-content content-holder div.description-holder").text
    }
    binding.pry
    profile
  end
end

Scraper.new
Scraper.scrape_profile_page("fixtures/student-site/students/ryan-johnson.html")
