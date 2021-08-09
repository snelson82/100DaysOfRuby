require 'fileutils'

# Set "days" that need directories & files created. Example creates the next "day" by checking existing directories directly nested under the "Daily Logs" diretory and the iterating to the next largest integer
## day_range needs to be an Array to allow for iteration and flexibility (in case you'd like to create 10, 20, etc, or all 100 days' folders and files at once)
last_day_updated = (Dir.children('Daily Logs') - ['.DS_Store']).sort!.map { |day| day.gsub!('Day ', '').to_i }.max

## Simple example to only create the next Day's files
day_range = [last_day_updated + 1]

# Set daily template string
SNIPPET = "# Summary\n\n## Topics Studied\n\n- topic\n\n## Resources Used\n\n[resource](resource_link)\n\n## Links to Projects & Notes\n\n[project_or_gist](project_or_gist_link)\n\n[Continue to Day #](./../Day%20#{day_range}/README.md)".freeze

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
