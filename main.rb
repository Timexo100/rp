require_relative 'docx_to_json'
require_relative 'db'

include Mod

fields = [
    :company_name, # Наименование организации:
    :company_inn, # ИНН организации:
    :company_ati, # Код АТИ:
    :head_name, # ФИО руководителя организации:
    :head_birthday, # Дата рождения руководителя организации:
    :operator_name, # ФИО диспетчера:
    :operator_bithday, # Дата рождения диспетчера:
    :operator_phones, # Телефон диспетчера:
    :car_number, # Гос.номер АВТО:
    :car_sts, # СТС АВТО:
    :car_owner_name, # ФИО собственника АВТО:
    :car_owner_birthday, # Дата рождения собственника АВТО:
    :car_owner_phones, # Телефоны собственника АВТО:
    :trailer_number, # Гос.номер ПРИЦЕПА:
    :trailer_sts, # СТС ПРИЦЕПА:
    :trailer_owner_name, # ФИО собственника ПРИЦЕПА:
    :trailer_owner_birthday, # Дата рождения собственника ПРИЦЕПА:
    :trailer_owner_phones, # Телефоны собственника ПРИЦЕПА:
    :driver_name, # ФИО водителя:
    :driver_birthday, # Дата рождения водителя:
    :driver_address,# Место проживания водителя:
    :driver_registration_address, # Адрес регистрации по ПАСПОРТУ:
    :driver_passport, # Серия и номер ПАСПОРТА:
    :driver_passport_date, # Дата выдачи ПАСПОРТА:
    :driver_phones, # Телефоны водителя:
    :driver_license, # Номер водительского удостоверения:
    :driver_license_data, # Дата выдачи ВУ:
    :logist_name # ФИО специалист-логист по транспорту:
  ]

Mod.docx_to_json(fields)
db = DB.new()
db.push_one_to_db()
db.fresh_notes_from_db()