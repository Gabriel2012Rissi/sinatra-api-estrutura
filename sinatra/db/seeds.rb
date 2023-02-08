cars = [
  {
    brand: 'Ford',
    name: 'Mustang',
    year: 2019,
    price: 200000.987656
  },
  {
    brand: 'Chevrolet',
    name: 'Camaro',
    year: 2017,
    price: 197778.8766574
  },
  {
    brand: 'Dodge',
    name: 'Challenger',
    year: 2016,
    price: 187654.876540
  },
]

cars.each { |car| Car.create(car) }