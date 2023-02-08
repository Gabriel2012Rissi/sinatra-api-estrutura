class CarQuery
  module Scopes
    def by_brand(brand)
      return self if brand.blank?
      where(brand: brand)
    end

    def by_name(name)
      return self if name.blank?
      where(name: name)
    end

    def by_year(year)
      return self if year.blank?
      where(year: year)
    end
  end

  def self.call(filters)
    Car.extending(Scopes)
        .by_brand(filters[:brand])
        .by_name(filters[:name])
        .by_year(filters[:year])
  end
end