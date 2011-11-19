module StoriesHelper
  def story_author(story)
    if story.author
      if story.author.name
        "Por: #{story.author.name} (#{story.author.email})"
      else
        "Por: #{story.author.email}"
      end
    end
  end
end
