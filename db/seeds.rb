require 'csv'

fields = ["name", "description"]
CSV.foreach("factors.csv", :headers => true) do |row|  
  factor = { name: nil,
   description: nil   
  } 
   fields.each_with_index do |field, i|
      if i == 0

        factor[:name] = row[i].gsub(/\./, '').downcase 
      else
        factor[:description] =row[i]
      end      
   end
   Factor.create(factor)
end

Run.create(title: "first run")