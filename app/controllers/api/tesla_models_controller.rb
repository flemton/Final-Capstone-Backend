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
end
