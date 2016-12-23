class Product < ApplicationRecord
	include PgSearch
	include Filterable
	belongs_to :user
	has_many :orders
	has_many :customers, through: :orders, source: :users
	mount_uploaders :product_images, ProductImagesUploader

	enum category: [:biology, :chemistry, :physics, :economics, :finance, :history, :literary_fiction, :fantasy, :scifi, :horror]
	enum sale_or_rent: [:for_sale, :for_rent]
	enum format: [:paperback, :hardback, :other]
	enum language: [:English, :Malay, :Chinese]

	# Scopes for Searching
	pg_search_scope :search_string, :against => [:title, :description], using: {tsearch: {dictionary: "english"}}
	pg_search_scope :search_isbn, :against => [:isbn]
	scope :category, 		-> (category) { where(category: category) }
	scope :sale_or_rent, 	-> (sale_or_rent) { where(sale_or_rent: sale_or_rent) }
	scope :ages, 			-> (ages) { where("ages >= ?", ages.to_i) }
	scope :price_above, 	-> (price) { where("price >= ?", price) }
	scope :price_below, 	-> (price) { where("price <= ?", price) }
	scope :format, 			-> (format) { where(format: format)}
	scope :language, 		-> (language) { where(language: language)}
end
