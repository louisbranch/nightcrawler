class IncrementalStoryCrawler
  
  def initialize(source_id)
    @source_id = source_id
    @source = Source.find(@source_id)
    @quantity = @source.crawl_rate
    @last_parsed_item = @source.last_parsed_item
  end
  
  def loop_through
    count = @last_parsed_item.to_i
    @quantity.times do
      count += 1
      create_story(count)
    end
    save_last_parsed_item_id(count)
    @source.save!
    puts 'end of the cycle'
  end
  
  protected
  
  def create_story(page_id)
    parser = StoryParser.new(@source_id,page_id)
    fetch_hash = parser.fetch
    if fetch_hash
      story = Story.new
      story.create_by_fetch(fetch_hash)
      save_last_created_item_id(page_id)
      puts "Page #{page_id} created"
    else
      puts "Page #{page_id} failed"
    end
  end
  
  def save_last_parsed_item_id(page_id)
    @source.last_parsed_item = page_id.to_s
  end
  
  def save_last_created_item_id(page_id)
    @source.last_created_item = page_id.to_s
  end
  
end
