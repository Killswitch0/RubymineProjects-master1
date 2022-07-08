require_relative 'product'
require_relative 'film'
require_relative 'book'

products = Product.read_from_db


puts "Добро пожаловать в наш магазин\n\n"
Product.showcase(products)





