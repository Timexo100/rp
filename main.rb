require 'docx'
require 'json'

fields = [
  :company_name, # Наименование организации: 0
  :company_inn, # ИНН организации:1
  :company_ati, # Код АТИ:2
  :head_name, # ФИО руководителя организации:3
  :head_birthday, # Дата рождения руководителя организации:4
  :head_phones, # Телефоны руководителя организации:5
  :operator_name, # ФИО диспетчера:6
  :operator_birthday, # Дата рождения диспетчера:7
  :operator_phones, # Телефон диспетчера:8
  :car_number, # Гос.номер АВТО:9
  :car_sts, # СТС АВТО:10
  :car_owner_name, # ФИО собственника АВТО:11
  :car_owner_birthday, # Дата рождения собственника АВТО:12
  :car_owner_phones, # Телефоны собственника АВТО:13
  :trailer_number, # Гос.номер ПРИЦЕПА:14
  :trailer_sts, # СТС ПРИЦЕПА:15
  :trailer_owner_name, # ФИО собственника ПРИЦЕПА:16
  :trailer_owner_birthday, # Дата рождения собственника ПРИЦЕПА:17
  :trailer_owner_phones, # Телефоны собственника ПРИЦЕПА:18
  :driver_name, # ФИО водителя:19
  :driver_birthday, # Дата рождения водителя:20
  :driver_address, # Место проживания водителя:21
  :driver_registration_address, # Адрес регистрации по ПАСПОРТУ:22
  :driver_passport, # Серия и номер ПАСПОРТА:23
  :driver_passport_place_and_date, # Кем и когда выдан ПАСПОРТ водителя:24
  :driver_phones, # Телефоны водителя:25
  :driver_license, # Номер водительского удостоверения:26
  :driver_license_data, # Дата выдачи ВУ:27
  :logistician_name, # ФИО специалист-логист по транспорту:28
  :security_answer # Ответ СБ:29
]

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

