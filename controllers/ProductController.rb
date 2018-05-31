class ProductController < ApplicationController
  # get route
  get '/' do
    products = Product.all
    {
      success: true,
      message: "Here are all #{products.length} products.",
      products: products
    }.to_json
  end

  # show route
  get '/:id' do
    show_product = Product.find params[:id]
    {
      success: true,
      message: "Here is more information about #{show_product.name}",
      show_product: show_product
    }.to_json
  end

  # create route
  post '/' do
    new_product       = Product.new
    new_product.name  = @payload[:name]
    new_product.price = @payload[:price]
    new_product.stock = @payload[:stock]
    new_product.total = @payload[:total]
    new_product.save
    {
      success: true,
      message: "You have successfully added #{new_product.name} to your inventory.",
      new_product: new_product
    }.to_json
  end

  # edit route
  put '/:id' do
    updated_product       = Product.find params[:id]
    updated_product.name  = @payload[:name]
    updated_product.price = @payload[:price]
    updated_product.stock = @payload[:total] > 0
    updated_product.total = @payload[:total]
    updated_product.save
    {
      success: true,
      message: "You have successfully edited #{updated_product.name}.",
      updated_product: updated_product
    }.to_json
  end

  # delete route
  delete '/:id' do
    deleted_product = Product.find params[:id]
    deleted_product.destroy
    {
      success: true,
      message: "You have deleted #{deleted_product.name} from your inventory.",
      deleted_product: deleted_product
    }.to_json
  end
end
