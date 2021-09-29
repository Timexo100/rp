class DB
    require 'mongo'
    require 'json'

def push_one_to_db
    client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'myNewDB')
    file = File.read('./application.json')
    client[:blacklistdrivers].insert_one(JSON.parse(file))
end

def push_many_to_db
    client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'myNewDB')
    file = File.read('./MOCK_DATA.json')
    client[:blacklistdrivers].insert_many(JSON.parse(file))
end

def get_from_db
    client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'myNewDB')
    result = client[:blacklistdrivers].find()
    json = result.to_a.to_json
    File.open("./search/data.json","w") do |f|
        f.write(json)
    end
 end

def remove_from_db
   #to-do
end
end
