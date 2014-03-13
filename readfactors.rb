require 'csv'
require 'yaml'
#require 'debugger'
class String
  def unquote
  self.gsub(/^"|"$/, '')
  end
end

src = File.read("factors.csv", :encoding => Encoding::UTF_8)
first_line = src.split(/(\r?\n)+/)[0]
p first_line
#first_line = src.split(/(\r?\n)+/)[0]
fields = first_line.split(' ').collect {|f| f.unquote.chomp}
fields = ["name", "description"]

p fields

File.open("import_factors.yml", "a") do |f|
f.write("factors_records = [\n")
  CSV.foreach("factors.csv", :headers => true) do |row|  
    f.write("{")  
     fields.each_with_index do |field, i|
      if i == 0
        f.write(" #{field}: " + %Q{"#{row[i]}"} + ", \n")   
      else
        f.write(" #{field}: " + %Q{"#{row[i]}"} + " \n")
      end
        
     end
  f.write("},\n")
  end
f.write("]")  
end