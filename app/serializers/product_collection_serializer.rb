class ProductCollectionSerializer < ActiveModel::Serializer
  attributes :title,
             :description,
             :price,
             :created_at,
             :updated_at,
             :sale_price,
             :hit_count
end
