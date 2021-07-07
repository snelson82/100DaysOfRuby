require 'byebug'
require 'fileutils'

SNIPPET = "# Summary\n\n## Topics Studied\n\n- topic\n\n## Resources Used\n\n[resource](resource_link)\n\n## Links to Projects & Notes\n\n[project_or_gist](project_or_gist_link)\n\n[Continue to Day #](/Daily%20Logs/Day #/day_#.md)".freeze

def create_structure(arr)
  arr.each do |day|
    daily_dir    = File.expand_path("Day #{day}", 'Daily Logs')
    daily_rb     = File.expand_path("day_#{day}.rb", "Daily Logs/Day #{day}")
    daily_readme = File.expand_path('README.md', "Daily Logs/Day #{day}")

    FileUtils.mkdir_p(daily_dir) unless File.exist?(daily_dir)
    unless File.exist?(daily_rb)
      f1 = File.open(daily_rb, 'w')
      f1.close
    end

    unless File.exist?(daily_readme)
      f2 = File.open(daily_readme, 'w') { |file| file << SNIPPET }
      f2.close
    end
  end
end

create_structure((4..100).to_a)
