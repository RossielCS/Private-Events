class EventsController < ApplicationController
  def index
    @event = Event.all
  end

  def show
    @event = Event.where(creator_id: current_user.id)
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    @event.creator_id = current_user.id

    if @event.save
      create_invitation(params[:user_ids], @event.id)
      flash.now[:notice] = 'Event was successfully created.'
      redirect_to current_user
    else
      flash.now[:notice] = 'Error.'
      redirect_to new_event_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:description, :location, :date)
  end
end
