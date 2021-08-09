# Summary

I've been using CSV files a ton lately, so I'm diving into all the methods/params for the **CSV module** as well as general IRB tools.

- [Summary](#summary)
  - [Topics Studied](#topics-studied)
  - [Resources Used](#resources-used)
  - [Snippets](#snippets)
    - [List available parameters for a method](#list-available-parameters-for-a-method)
    - [CSV module method examples](#csv-module-method-examples)
      - [`CSV.open`](#csvopen)
      - [`CSV.parse`](#csvparse)
      - [`CSV.generate`](#csvgenerate)
      - [`CSV.filter`](#csvfilter)
      - [`CSV.foreach`](#csvforeach)
      - [`CSV.readlines`](#csvreadlines)
      - [`CSV.generate_line`](#csvgenerate_line)
      - [`CSV.parse_line`](#csvparse_line)
      - [`CSV.table`](#csvtable)
      - [`CSV.read`](#csvread)
  - [Links to Projects & Notes](#links-to-projects--notes)

## Topics Studied

- [**Ruby's CSV module**](https://ruby-doc.org/stdlib/libdoc/csv/rdoc/CSV.html)

## Resources Used

- List methods available for a module (CSV module in example)

```ruby
require 'csv'

pp CSV.public_methods - Object.public_methods
# =>
# [
#   :open,
#   :parse,
#   :generate,
#   :filter,
#   :foreach,
#   :readlines,
#   :generate_line,
#   :parse_line,
#   :table,
#   :instance,
#   :read,
#   :delegate,
#   :instance_delegate,
#   :def_delegators,
#   :def_instance_delegator,
#   :def_instance_delegators,
#   :def_delegator
# ]
```

## Snippets

### List available parameters for a method

```ruby
require 'csv'

CSV.method(:foreach).parameters
# =>
# [
#   [:req, :path],        - :req     = required
#   [:opt, :mode],        - :opt     = optional
#   [:keyrest, :options], - :keyrest = options in hash => { headers: true }
#   [:block, :block]      - :block   = block => { key: value }
# ]
```

### CSV module method examples

#### `CSV.open`

[CSV - Default Options](https://ruby-doc.org/stdlib-3.0.2/libdoc/csv/rdoc/CSV.html#class-CSV-label-Options+for+Parsing)

```ruby
DEFAULT_OPTIONS = {
  # For both parsing and generating
  col_sep:            ",",
  quote_char:         '"',
  row_sep:            :auto,
  # For parsing
  converters:         nil,
  empty_value:        "",
  field_size_limit:   nil,
  header_converters:  nil,
  headers:            false,
  liberal_parsing:    false,
  nil_value:          nil,
  return_headers:     false,
  skip_blanks:        false,
  skip_lines:         nil,
  unconverted_fields: nil,
  # For generating
  force_quotes:       false,
  quote_empty:        true,
  strip:              false,
  write_converters:   nil,
  write_empty_value:  "",
  write_headers:      nil,
  write_nil_value:    nil,
}
```

```ruby
require 'csv'

CSV.method(:open).parameters
# [[:req, :filename], [:opt, :mode], [:keyrest, :options]]

## Open a CSV in write mode and append data to the end of the file
# NOTE
# File.open with 'a+' mode adds data to exactly the end of the file
# CSV.open with 'a+' mode adds data to the end of the file using a new line
CSV.open('./Daily Logs/Day 5/example.csv', 'a+') do |csv|
  csv << ['John McTesterson',37,'green','3/13/1984']
end
# => #<CSV io_type:File io_path:"./Daily Logs/Day 5/example.csv" encoding:UTF-8 lineno:1 col_sep:"," row_sep:"\n" quote_char:"\"">
```

`:mode` types [**explained**](https://ruby-doc.org/core/IO.html#method-c-new-label-IO+Open+Mode)

#### `CSV.parse`

```ruby
require 'csv'

CSV.method(:parse).parameters
# [[:req, :str], [:keyrest, :options], [:block, :block]]

data = CSV.parse(File.read('./Daily Logs/Day 5/example.csv', headers: true))
# => [["name", "age", "fav_color", "birthday"], ["Tester McTesterson", "32", "purple", "1/11/1989"], ["Flo McTesterson", "35", "green", "2/22/1986"], ["John McTesterson", "37", "green", "3/13/1984"]]
pp data
# [["name", "age", "fav_color", "birthday"],
#  ["Tester McTesterson", "32", "purple", "1/11/1989"],
#  ["Flo McTesterson", "35", "green", "2/22/1986"],
#  ["John McTesterson", "37", "green", "3/13/1984"]]
```

#### `CSV.generate`

```ruby
require 'csv'

CSV.method(:generate).parameters
# [[:opt, :str], [:keyrest, :options]]

csv_sample = CSV.generate do |csv|
  csv << ['some', 'sample', 'data']
  csv << ['here\'s', 'some', 'more']
  csv << ['another', 'one', 'for fun']
end
# => "some,sample,data\nhere's,some,more\nanother,one,for fun\n"

puts csv_sample
# some,sample,data
# here's,some,more
# another,one,for fun
```

#### `CSV.filter`

```ruby
require 'csv'

CSV.method(:filter).parameters
# [[:opt, :input], [:opt, :output], [:keyrest, :options]]

in_string = File.read('./Daily Logs/Day 5/example.csv', headers: true)
out_string = ''
CSV.filter(in_string, out_string, headers: true) do |row|
  # formats names to be first_last
  row[0] = row[0].downcase.gsub(' ', '_')
  # Uses birthday to calculate accurate age
  row[1] = Date.today.year - Date.strptime(row[3].to_s(&:strip), '%m/%d/%Y').year
  # Favorite color to uppercase
  row[2] = row[2].upcase
  # Parse string to be a date
  row[3] = Date.strptime(row[3].to_s(&:strip), '%m/%d/%Y')
end

puts out_string
# tester_mctesterson,32,PURPLE,1989-01-11
# flo_mctesterson,35,GREEN,1986-02-22
# john_mctesterson,37,GREEN,1984-03-13
```

#### `CSV.foreach`

```ruby
require 'csv'

CSV.method(:foreach).parameters
# [[:req, :path], [:opt, :mode], [:keyrest, :options], [:block, :block]]

CSV.foreach('./Daily Logs/Day 5/example.csv', headers: true, header_converters: :symbol) do |row|
  # quick output of each row as a hash with headers converted to symbols
  pp row.to_h
end
# {:name=>"Tester McTesterson",
#  :age=>"32",
#  :fav_color=>"purple",
#  :birthday=>"1/11/1989"}
# {:name=>"Flo McTesterson",
#  :age=>"35",
#  :fav_color=>"green",
#  :birthday=>"2/22/1986"}
# {:name=>"John McTesterson",
#  :age=>"37",
#  :fav_color=>"green",
#  :birthday=>"3/13/1984"}
```

#### `CSV.readlines`

- Alias for [`CSV.read`](#csvread)

```ruby
require 'csv'

CSV.method(:readlines).parameters
# [[:req, :path], [:keyrest, :options]]

read_file = CSV.readlines('./Daily Logs/Day 5/example.csv', headers: true)
# => #<CSV::Table mode:col_or_row row_count:4>

puts read_file
# name,age,fav_color,birthday
# Tester McTesterson,32,purple,1/11/1989
# Flo McTesterson,35,green,2/22/1986
# John McTesterson,37,green,3/13/1984
```

#### `CSV.generate_line`

```ruby
require 'csv'

CSV.method(:generate_line).parameters
# [[:req, :row], [:keyrest, :options]]

arr = [
  ['Yelnats McTesterson', 42, 'Teal', '4/14/1979'],
  ['Yelnats McTesterson2', 43, 'Aquamarine', '4/14/1978']
]
arr.each do |data|
  new_row = CSV.generate_line(data)
  puts new_row
end
# Yelnats McTesterson,42,Teal,4/14/1979
# Yelnats McTesterson2,43,Aquamarine,4/14/1978
```

#### `CSV.parse_line`

```ruby
require 'csv'

CSV.method(:parse_line).parameters
# [[:req, :line], [:keyrest, :options]]

CSV.parse_line(File.read('./Daily Logs/Day 5/example.csv', headers: true), headers: true)
# => #<CSV::Row "name":"Tester McTesterson" "age":"32" "fav_color":"purple" "birthday":"1/11/1989">
```

#### `CSV.table`

```ruby
require 'csv'

CSV.method(:table).parameters
# [[:req, :path], [:keyrest, :options]]

my_table = CSV.table('./Daily Logs/Day 5/example.csv', headers: true, header_converters: :symbol)

puts my_table
# name,age,fav_color,birthday
# Tester McTesterson,32,purple,1/11/1989
# Flo McTesterson,35,green,2/22/1986
# John McTesterson,37,green,3/13/1984
```

#### `CSV.read`

```ruby
require 'csv'

CSV.method(:read).parameters
# [[:req, :path], [:keyrest, :options]]

puts CSV.read('./Daily Logs/Day 5/example.csv', headers: true)
# name,age,fav_color,birthday
# Tester McTesterson,32,purple,1/11/1989
# Flo McTesterson,35,green,2/22/1986
# John McTesterson,37,green,3/13/1984
```

## Links to Projects & Notes

- [DateTime.strptime](https://ruby-doc.org/stdlib/libdoc/date/rdoc/DateTime.html#method-c-strptime)

[Continue to Day 6](./../Day%206/README.md)
