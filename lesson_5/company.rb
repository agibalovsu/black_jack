module Company

  attr_accessor :name_company

  def create_company_name(name)
    self.name_company = name
    puts "Создана компания #{self.name_company}"
  end

  def get_name_company
    puts "Собственность компании #{self.name_company}"
  end
end