desc "This task is called by the Heroku scheduler add-on"
task :update_stories => :environment do
    IncrementalStoryCrawler.new(1).loop_through
end
