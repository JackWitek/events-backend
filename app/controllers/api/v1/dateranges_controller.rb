module Api
  module V1
    class DaterangesController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_daterange, only: [:show, :update, :destroy]

      # GET /dateranges
      def index
        @dateranges = current_user.dateranges.all
        render json: @dateranges
      end

      # GET /dateranges/1
      def show
        render json: @daterange
      end

      # POST /dateranges
      def create
        @daterange = current_user.dateranges.build(daterange_params)

        if @daterange.save
          render json: @daterange, status: :created
        else
          render json: @daterange.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /dateranges/1
      def update
        if @daterange.update(daterange_params)
          render json: @daterange
        else
          render json: @daterange.errors, status: :unprocessable_entity
        end
      end

      # DELETE /dateranges/1
      def destroy
        @daterange.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_daterange
          @daterange = current_user.dateranges.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def daterange_params
          params.require(:daterange).permit(:name, :startDate, :endDate, :data, :user_id)
        end
    end
  end
end