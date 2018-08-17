require 'open-uri'
require 'nokogiri'
# event_url = "https://www.meetup.com/ChicagoRuby/events/249198492/"

def food_scraper(event_url)
  document = open(event_url)
  content = document.read

  parsed_content = Nokogiri::HTML(content) 

  parsed_content.css('.content')

  desc = parsed_content.css('.event-description').inner_text

  event_date = parsed_content.css('.eventTimeDisplay-startDate').inner_text

  event_title = parsed_content.css('.text--pageTitle').inner_text

  if desc.include?('food')
    "#{event_title} has food. Please show up at #{event_date}. For more info, please visit #{event_url}."
  else
    "#{event_title} has no food."
  end  
end

def event_urls(main_page_url)
  # array of urls
  ['1', '2', '3']
end

puts "Enter main page url: "
main_page_url = gets.chomp

event_urls(main_page_url).each do |event_url|
  puts '------------'
  puts food_scraper(event_url)
end
