class Api::TeslaModelsController < ApplicationController
  skip_before_action :set_current_user, only: [:create]
  def index
    @tesla_models = TeslaModel.all
    tesla_models_json = @tesla_models.map do |tesla_model|
      tesla_model_attributes = tesla_model.attributes
      tesla_model_attributes['image_url'] = url_for(tesla_model.image) if tesla_model.image.attached?
      tesla_model_attributes
    end
    render json: tesla_models_json
  end
  def show
    @tesla_model = TeslaModel.find(params[:id])
    image_url = url_for(@tesla_model.image) if @tesla_model.image.attached?
    render json: { tesla_model: @tesla_model.attributes, image_url: }
  end
\ def create
    # Creating a new tesla instance from the provided parameters.
    @tesla_model = TeslaModel.new(tesla_model_params)

    # Wrapping the save method in a transaction. This ensures that if anything goes wrong,
    # all changes to the database will be rolled back.
    ActiveRecord::Base.transaction do
      if @tesla_model.save
        # Handle the image attachment if provided.
        @tesla_model.image.attach(params[:image]) if params[:image].present?

        # If everything goes well, send a success response.
        render json: { message: 'Tesla model created successfully' }, status: :created
      else
        # If the Tesla isn't saved due to validation errors or other issues, send an error response.
        render json: { errors: @tesla_model.errors.full_messages }, status: :unprocessable_entity
      end
    end
  en
end
