require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    learn_students = Nokogiri::HTML(File.read(index_url))

    students = {}

    binding.pry

    learn_students.css(div.student-card).each do |student|
      students = {
        # name:,
        # location:,
        # profile_url:
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end

Scraper.new.scrape_index_page(./fixtures/student-site/students/index.html)
