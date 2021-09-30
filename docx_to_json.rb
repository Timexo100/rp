require 'docx'
require 'json'

 module Mod
  
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
      hash[fields[index]] = lines[index]
    end
    return hash
  end

  def docx_to_json(fields)
    resultHash = generate_hash_from(fields, get_lines_from_docx('application.docx'))
    json = resultHash.to_json
    File.open("application.json","w") do |f|
      f.write(json)
    end
  end
 end