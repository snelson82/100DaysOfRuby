# Day 4

## Summary

- Restarting the 100 days of code on Day 4
- Began using Ruby version 3.0.0
- Brushed up on the Day 1 [script I created back in 2018](../Day%201/day_1.rb)
- Created a version 2.0 of the Day 1 script (creates daily "log" files and folders based on the last day logged)
  - [Version 2.0](./day_4.rb) includes more automation and smart "checks" along the way
    - Checks for existing "Day #" directories and finds the most recent
    - Default is to only create the next day's files
      - Added examples for other possible day ranges to create files for (next X number days, all remaining days up to a point, etc)
    - Updated each day's notes to be a README file for a better visual inside of Github (one less click 👏 )

## Topics Studied

|                                                       File Management & Automation                                                       |
| :--------------------------------------------------------------------------------------------------------------------------------------: |
| ![Folder](https://img.icons8.com/dusk/64/000000/folder-invoices.png) ![Add Folder](https://img.icons8.com/dusk/64/000000/add-folder.png) |

## Resources Used (Ruby Version 3.0.0)

- [RubyGuides: 3 Awesome ways to use gsub](https://www.rubyguides.com/2019/07/ruby-gsub-method/)
- [Ruby-Doc: Dir.children](https://ruby-doc.org/core-3.0.0/Dir.html#method-c-children)
- [Ruby-Doc: Dir.exist?](https://ruby-doc.org/core-3.0.0/Dir.html#method-c-exist-3F)
- [Ruby-Doc: File.expand_path](https://ruby-doc.org/core-3.0.0/File.html#method-c-expand_path)
- [Ruby-Doc: File.open](https://ruby-doc.org/core-3.0.0/File.html#method-c-open)
- [Ruby-Doc: Range](https://ruby-doc.org/core-3.0.0/Range.html)

## Links to Projects & Notes

[**Directory setup script 2.0**](./day_4.rb)

### Credits

| <img src="https://upload.wikimedia.org/wikipedia/commons/7/78/Icons8_logo.jpg" width="64px"> | <p>Images were pulled from [Icons8](https://icons8.com/icons)</p> |
| -------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |

[Continue to Day 5](./../Day%205/README.md)
