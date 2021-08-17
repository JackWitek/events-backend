module Api
  module V1
    class EventsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_event, only: [:show, :update, :destroy]


      # GET /events
      def index
        @events = current_user.events.all.order(:startTime)
        render json: @events
      end

      # GET /date
      def date
        @events = current_user.events.where(:startTime=> params[:date].to_date+params[:offset].to_i.minute..params[:date].to_date+1+params[:offset].to_i.minute ).order(:startTime)
        render json: @events
      end

      # GET /events/1
      def show
        render json: @event
      end

      # POST /events
      def create
        @event = current_user.events.build(event_params)

        startTime = @event.get_startTime
        endTime = @event.get_endTime
        name = @event.get_name
        id = @event.id

        for i in current_user.events

          if i.get_id == id
            next
          end


          if (startTime == i.get_startTime ) and (endTime == i.get_endTime)
            overlap_error(i.get_name, "Can't create event. Time chosen is the same as an existing event: ") and return
          elsif (startTime > i.get_startTime and startTime < i.get_endTime) and (endTime > i.get_startTime and endTime < i.get_endTime)
              overlap_error(i.get_name, "Can't create event. Time chosen is inside of an existing event: ") and return
          elsif (startTime < i.get_startTime ) and (endTime > i.get_endTime)
              overlap_error(i.get_name, "Can't create event. Time chosen encompasses an existing event: ") and return
          elsif startTime >= i.get_startTime and startTime < i.get_endTime
            overlap_error(i.get_name,"Can't create event. Start time overlaps with an existing event: ") and return
          elsif endTime > i.get_startTime and endTime <= i.get_endTime
            overlap_error(i.get_name, "Can't create event. End time overlaps with an existing event: ") and return
          end
        end


        if @event.save
          render json: @event, status: :created
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      def overlap_error(name, message)
        render json: { error: message+name }, status: :not_acceptable
      end
 

      # PATCH/PUT /events/1
      def update
        if @event.update(event_params)
          render json: @event
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # DELETE /events/1
      def destroy
        @event.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_event
          @event = current_user.events.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def event_params

          params.require(:event).permit(:name, :description, :startTime,:endTime, :user_id)
        end
    end
  end
end