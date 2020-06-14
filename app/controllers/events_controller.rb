class EventsController < ApplicationController
  def index
    @upcoming_events = Event.upcoming
    @prev_events = Event.past
  end

  def show
    @event = Event.where(creator_id: current_user.id)
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      create_invitation(params[:user_ids], @event.id) if params[:user_ids]
      flash[:notice] = 'Event was successfully created.'
      redirect_to @event
    else
      flash[:notice] = 'There was an error while creating the event.'
      redirect_to new_event_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:description, :location, :date)
  end
end
