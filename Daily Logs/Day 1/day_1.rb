require 'fileutils'

SNIPPET = "# Summary\n\n## Topics Studied\n\n- topic\n\n## Resources Used\n\n[resource](resource_link)\n\n## Links to Projects & Notes\n\n[project_or_gist](project_or_gist_link)\n\n[Continue to Day #](/Daily%20Logs/Day #/day_#.md)".freeze

def create_structure(arr)
  arr.each do |day|
    FileUtils.mkdir_p("../Day #{day}") unless File.exist?("../Day #{day}")
    File.open("../Day #{day}/day_#{day}.rb", 'w')
    File.open("../Day #{day}/day_#{day}.md", 'w') { |file| file << SNIPPET }
  end
end

create_structure((1..100).to_a)
