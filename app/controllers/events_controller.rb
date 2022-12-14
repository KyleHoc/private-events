class EventsController < ApplicationController
  before_action :authenticate_user!, :require_login, only: [:new, :create, :show, :registration]
  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
    @event = Event.find(params[:id])
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = @current_user.created_events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def registration
    @event = Event.find(params[:id])

    registration = Registration.new(attendee_id: current_user.id, attended_event_id: @event.id)
    if registration.save
      if !@event.attendees.include?(current_user)
        redirect_to @event, notice: "You are now attending this event!"
      else
        redirect_to @event, notice: "You are now registered for this event"
      end
    end
  end

  def unregister
    @event = Event.find(params[:id])
    registration = Registration.find_by(attendee_id: current_user.id, attended_event_id: @event.id)
    registration.destroy

    redirect_to @event, notice: "You are no longer registered for this event"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :location, :date)
    end

    def require_login
      unless user_signed_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_login_url
      end
    end
end
