# require 'byebug'
require 'fileutils'

# Set daily template string
SNIPPET = "# Summary\n\n## Topics Studied\n\n- topic\n\n## Resources Used\n\n[resource](resource_link)\n\n## Links to Projects & Notes\n\n[project_or_gist](project_or_gist_link)\n\n[Continue to Day #](/Daily%20Logs/Day #/day_#.md)".freeze

# Set "days" that need directories & files created. Example creates the next "day" by checking existing directories directly nested under the "Daily Logs" diretory and the iterating to the next largest integer
## day_range needs to be an Array to allow for iteration and flexibility (in case you'd like to create 10, 20, etc, or all 100 days' folders and files at once)
last_day_updated = (Dir.children('Daily Logs') - ['.DS_Store']).sort!.map { |day| day.gsub!('Day ', '').to_i }.max

## day_range = (1..10).to_a is a good example of quickly creating an array from a given range <first_number_to_include..last_number_to_include>
### day_range = (1..10).to_a (creates Day 1 - Day 10)
### day_range = (1..25).to_a (creates Day 1 - Day 25)
### day_range = (last_day_updated..10).to_a (creates up to Day 10, minus the already existing days)

## This day_range statement creates up to Day 10 if the last logged day was less than 10, and then up to 20 if the last day was from 10-19. Using 'raise' can help log specific errors and stop the exit completely
### day_range = if last_day_updated < 10
###               (last_day_updated..10).to_a
###             elsif last_day_updated < 20 && last_day_updated >= 10
###               (last_day_updated..20).to_a
###             else
###               raise "\nError: The last 'Day' logged was Day #{last_day_updated}.\n- Update the day_range IF statement for the desired ranges\n-- The example range only works for up to Day 19"
###             end

## Simple example to only create the next Day's files
day_range = [last_day_updated + 1]

# take in an array
def create_daily_files(arr)
  arr.each do |day| # iterate over each number in the array
    # Set string variables for clean and accurate file path references
    daily_dir    = File.expand_path("Day #{day}", 'Daily Logs')
    daily_rb     = File.expand_path("day_#{day}.rb", "Daily Logs/Day #{day}")
    daily_readme = File.expand_path('README.md', "Daily Logs/Day #{day}")

    # Make the Daily directory unless it already exists
    FileUtils.mkdir_p(daily_dir) unless File.exist?(daily_dir)

    # If the Day's ruby file doesn't exist yet, create it and then close it so that the file writes and closes correctly
    ## Tip: Always "close" your files" after creating and/or writing to them. Failing to close files can cause data to save in unexpected ways such as CSV rows being out of the expected order and other oddities.
    unless File.exist?(daily_rb)
      f1 = File.open(daily_rb, 'w')
      f1.close
    end

    # If the Day's README file doesn't exist yet, create it and then close it so that the file writes and closes correctly
    ## Always include a README in directories that need some visual help to understand what's in the directory. Sometimes it's not needed but it's good practice to create the README files
    ## Use a Gist instead of a repository for those ad-hoc scripts and snippets that aren't part of a larger project
    unless File.exist?(daily_readme)
      f2 = File.open(daily_readme, 'w') { |file| file << SNIPPET }
      f2.close
    end
  end
end

create_daily_files(day_range)
