require 'docx'
require 'json'

fields = []

def get_lines_from_docx(file_name)
  doc = Docx::Document.open(file_name)
  lines = []
  doc.tables[0].rows.each do |row|
    lines << row.cells[1]
  end
  return lines
end

def generate_hash_from(fields, lines)
  hash = Hash.new
  (0..29).each do |index|
    case index
    when 0, 3, 6, 11, 16, 19, 21, 22, 24, 28, 29
      hash[fields[index]] = lines[index].to_s.strip.gsub(/\s+/, " ")
    when 9, 14
      hash[fields[index]] = lines[index].to_s.strip.gsub(/\s+/, "") # МАНМ850МУ21???
    when 1, 2, 4, 5, 7, 8, 10, 12, 13, 15, 17, 18, 20, 23, 25, 26, 27
      hash[fields[index]] = lines[index].to_s.strip.gsub(/\s+/, " ").gsub(/\D+/, "") # Телефоны слепляются
    end
  end
  return hash
end

drivers_array = []
Dir.glob("applications/*.docx") { |item|
  drivers_array.push(generate_hash_from(fields, get_lines_from_docx("#{item}")))
}

drivers_json = drivers_array.to_json

File.open("application.json", "w") do |f|
  f.write(drivers_json)
end

