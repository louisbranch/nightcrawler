module StoriesHelper
  def story_author(story)
    if story.author
      if story.author.name
        "por #{story.author.name} (#{story.author.email})"
      else
        "por #{story.author.email}"
      end
    end
  end
end
