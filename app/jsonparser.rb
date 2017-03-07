require 'json'
require 'ostruct'

class JSONParser
  def initialize(codenames)
    @packages = []
    @names = []
    codenames.each do |codename|
      json = {}
      open(codename + '.json') {|f| json = JSON.parse(f.read) }
      @packages.concat packages(json,codename)
      @names.concat names
    end
  end

  def search(word)
    return if word.nil?
    results = []
    temp = @names.select { |name| name =~ /#{word}/ }
    @packages.each {|i| results << i if temp.include?(i.name)}
    results
  end

  private

  def names
    names = []
    @packages.each do |s|
      names << s.name
    end
    names.uniq!
  end

  def packages(json,codename)
    packages = []
    json.each do |k, v|
      v.each do |k1,v1|
        v1.each do |i|
          pkg = OpenStruct.new
          pkg.name = i['Package']
          pkg.codename = codename
          pkg.version = i['Version']
          pkg.arch = k1
          pkg.section = i['Section']
          pkg.description = i['Description']
          pkg.depends = i['Depends']
          packages << pkg
        end
      end
    end
    packages
  end
end
