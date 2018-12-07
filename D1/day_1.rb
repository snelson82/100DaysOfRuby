require 'fileutils'

SNIPPET = "# Summary\n\n## Topics Studied\n\n- topic\n\n## Resources Used\n\n[resource](resource_link)\n\n## Links to Projects & Notes\n\n[project_or_gist](project_or_gist_link)".freeze

def create_structure(arr)
  arr.each do |day|
    FileUtils.mkdir_p("../D#{day}") unless File.exist?("../D#{day}")
    File.open("../D#{day}/day_#{day}.rb", 'w')
    File.open("../D#{day}/day_#{day}.md", 'w') { |file| file << SNIPPET }
  end
end

create_structure((1..100).to_a)
