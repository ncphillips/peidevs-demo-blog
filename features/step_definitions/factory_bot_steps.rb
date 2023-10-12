Given("a(?:n) {word} exists") do |factory|
  FactoryBot.create(factory)
end

Given("the following {word} exists") do |factory, table|
  table.hashes.each do |row|
    lookups = row.select { |k| k.split(" ").length > 1 }
    lookups.keys.each do |k|
      class_attribute = k.split(" ")
      class_name = class_attribute.first
      attribute = class_attribute.last
      klass = class_name.constantize
      value = row[k]
      entity = if attribute == "id"
        value
      else
        klass.find_by({attribute => value})
      end

      raise "Couldn't find #{class_name} with #{attribute} #{value}" if entity.blank?
      row.delete(k)
      row[class_name.downcase] = entity
    end
    FactoryBot.create(factory, row)
  end
end
