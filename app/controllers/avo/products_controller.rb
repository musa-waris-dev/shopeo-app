# This controller has been generated to enable Rails' resource routes.
# More information on https://docs.avohq.io/3.0/controllers.html
class Avo::ProductsController < Avo::ResourcesController

  def new
    super
    @record = Product.new
    # instance variables needs to be discussed what to be set here.
    @variants = Variant.new
  end

  def show
    @variants = @record.variants
    super
  end

  def create
    if params[:product][:title].present?
      product = Product.create(title: params[:product][:title])
      redirect_to edit_resources_product_path(product) and return
    end

    product_published

    super
  end

  def edit
    super
    @variant = Variant.new
    product = Product.find(params[:id])
    @variants = render_updated_variants(product)
  end

  def update

    if params[:product][:variants_attributes].present?
      if duplicate_options?(product_params)
        flash[:error] = I18n.t('avo.variant.option_not_unique')
        redirect_to edit_resources_product_path(params[:id])
        return
      end

      products_response(@record, @resource)
      product_published
      return
    end

    product_published

    super
  end

  private

      def product_params
        params[:product][:variants_attributes].delete('0') if params[:product][:variants_attributes].present?
        params.require(:product).permit(
          variants_attributes: [
            :id,
            :title,
            :price,
            :available,
            :on_hand,
            :sku,
            :barcode,
            :position,
            :options,
            :cost_currency,
            :avatar,
            :_destroy,
            :archived
          ],
          catalogue_organization_attributes: [
            :id,
            :vendor,
            :_destroy,
            {product_tags: []}
          ]
        )
      end

      def products_response(record, _resource)
        record.update(product_params)

        if record.errors.any?
          record.errors.each do |error|
            flash[:error] = error.full_message
          end
          respond_to do |format|
            format.html do
              redirect_to(
                (params[:action] == 'update') ? edit_resources_product_path(record.id) : new_resources_product_path
              )
            end
          end
        else
          respond_to do |format|
            format.html{
              redirect_to edit_resources_product_path(record.id),
                          notice: "#{record.title} #{t('avo.was_successfully_updated')}."
            }
          end
        end
      end

      def duplicate_options?(params)
        variants_attributes = params[:variants_attributes]
        first_variant_params = variants_attributes.values.first

        return false unless first_variant_params.is_a?(ActionController::Parameters)

        options = first_variant_params[:options]

        options = JSON.parse(options) if options.is_a?(String) && options.present?

        options_values = if options.is_a?(Hash)
                           options.values.flat_map{|option| option.map{|o| o['value'] } }
                         else
                           []
                         end

        options_values.uniq.length != options_values.length
      end

      def product_published
        if params[:product][:published] == '1'
          @record.update(status: 'active')
        else
          @record.update(status: 'offline')
        end
      end

      def render_updated_variants(product)
        @variants = product.variants.unscope(where: :archived).order_by_created_at.map do |variant|
          {
            id: variant.id,
            title: variant.title,
            price: variant.price,
            available: variant.available,
            sku: variant.sku,
            barcode: variant.barcode,
            options: variant.options,
            archived: variant.archived,
            avatar_url: variant.avatar.attached? ? main_app.url_for(variant.avatar) : nil
          }
        end

        return @variants
      end
end
