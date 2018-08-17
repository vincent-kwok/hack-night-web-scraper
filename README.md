Attended a hack night at Avant on Wednesday, June 13, 2018.
https://www.meetup.com/ChicagoRuby/events/gwrhpmyxjbrb/

# Ruby Web Scraper

Web scraping is a common method used to pull specific useful information from existing sites on the web. We are going to use it today to try to find out which Chicago Meetups serve food.

## Basic Tutorial Using IRB

We are going to start by digging through a single page via irb. We'll be looking at Reddit since it is follows a pretty common HTML layout. To start, in Chrome, navigate to the `aww` subreddit with a query for `cats`. Inspect the document in Chrome Developer Tools. This will show you the structure that we will be digging down into.

Now go ahead and pull this page into irb to work with.

```bash
irb
require 'open-uri'
require 'nokogiri'
document = open('https://www.reddit.com/r/aww/search?q=cats&restrict_sr=on&sort=relevance&t=all')
content = document.read
```

Back in irb, parse the content into a Nokogiri object that can be parsed as ruby code.
```ruby
parsed_content = Nokogiri::HTML(content) 
```

We can use CSS selectors to dig deeper into the HTML tree. Nokogiri finds the CSS class within the HTML structure, and it will return the HTML subset if it finds the CSS selector.
```ruby
parsed_content.css('.content')
```

You can nest the query to go even deeper.
```ruby
parsed_content.css('.content').css('.search-result-listing')

parsed_content.css('.content').css('.search-result-listing').css('.search-result-group').css('.contents').css('.search-result').css('.search-result-header').first

parsed_content.css('.search-result-header').first
```

We can find out a bit more about this object
```ruby
post_title = _

post_title.class

post_title.class.instance_methods.sort
```

Now let's dig into the single element that we found
```ruby
post_title.inner_text

post_title.inner_html
```

Let's back up a levels and try to find all of the post titles
```ruby
post_titles = parsed_content.css('.content').css('.search-result-listing').css('.search-result-group').css('.contents').css('.search-result').css('.search-result-header')

post_titles.class

post_titles.each do |title|
  puts "#{title.inner_text}"
end
```

So now you have a list of titles on the first page of these search results.


## Building a Basic Scraper

Now that you know about how to use Open URI and Nokogiri to parse a webpage, we are going to build a ruby program to do the scraping. 

Feel free to start with the page that was used in the tutorial to confirm that your ruby code is correct. You want to verify that your output, when you run your ruby file (ie: `ruby-web-scraper.rb`) returns what you expect it to return. If you are using the page from the tutorial above, you would expect to see a list of post titles.

Once you have that working and displaying in a reasonable way, start on a new page, or get multiple pieces of data from one page.

## The Challenge

We are going to use our scraper to find out whether or not a particular meetup serves food. You need to decide what text the meetup event page would have to include in order for that condition to be met. For [the event page for tonight's ChicagoRuby Hack Night](https://www.meetup.com/ChicagoRuby/events/249198492/), the event description mentions
> Our host, Avant, will provide food and drink.

When you have determined that a meetup provides food, you want to display the relevant details, which probably includes the meetup day and time, the name of the event, the url, et al, whatever you feel is valuable. 

## Stretch

Once you are able to compile all of the relevant data for a single meetup event page, try to figure out how to get the data for multiple events. Your starting point, instead of being a specific event page, will be a list of event pages. Play with different options of sorting (title, date, etc).

## Resources
- _[Scraping the web with Ruby tutorial - Part 1](https://www.youtube.com/watch?v=4TpBH5z8EXA)_
- _[Scraping the web with Ruby tutorial - Part 2](https://www.youtube.com/watch?v=j9MmyJrmLhI)_
