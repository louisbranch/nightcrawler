require 'httparty'

class Migrate

  def self.do_it
    counter = 0
    Story.includes([:categories, :author]).each do |story|
      counter += 1
      puts "Sending: #{counter}"
      send_story(story)
    end
  end

  def self.send_story(story)
    begin
      body = {
        type: 'story',
        title: story.title,
        content: story.content,
        createdAt: story.created_at
      }
      if story.author
        body[:author] = story.author.name
      end
      if story.categories.any?
        body[:tags] = story.categories.map(&:name)
      end
        HTTParty.put("http://localhost:5984/stories/#{story.slug}", {body: body.to_json})
    rescue Exceptio => e
      puts e.message
    end
  end

end
