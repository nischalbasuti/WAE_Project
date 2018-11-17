class EventsController < ApplicationController
  load_and_authorize_resource

  skip_before_action :verify_authenticity_token, :only => :update_user_event
  skip_before_action :verify_authenticity_token, :only => :delete_user_event
  skip_before_action :verify_authenticity_token, :only => :register

  skip_authorize_resource :only => [ :register, :unregister ]

  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @activities = Activity.where(event: @event).order("start_time")
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def manage
      @event = Event.find(params[:id])
      @role_options = UserEvent.ROLES.map do |role|
        [ role, role ]
      end
  end

  def update_user_event
    user = User.find(params[:user_id])
    event = Event.find(params[:event_id])
    role = params[:role]

    user.set_event_role(event, role)
    user.save

    redirect_back fallback_location: root_path
    # render json: {message: "user(#{params[:user_id]}) event(#{params[:event_id]}) role(#{role}) updated."}
  end

  def delete_user_event
    user = User.find(params[:user_id])
    event = Event.find(params[:event_id])
    role = params[:role]

    user.user_events.where(event: event, role: role).destroy_all

    redirect_back fallback_location: root_path
    # render json: {message: "user(#{params[:user_id]}) event(#{params[:event_id]}) role(#{role}) deleted."}
  end

  def register
    event = Event.find(params[:event_id])
    user = User.find(params[:user_id])
    event.user_events.new(user: user, role: "participant")
    event.save
    # render json: {message: "user(#{params[:user_id]}) event(#{params[:event_id]}) registered."}
    # redirect_to '/events/3'
    redirect_back fallback_location: root_path
  end

  def unregister
    event = Event.find(params[:event_id])
    user = User.find(params[:user_id])
    event.user_events.where(user: user).destroy_all
    # render json: {message: "user(#{params[:user_id]}) event(#{params[:event_id]}) registered."}
    # redirect_to '/events/3'
    redirect_back fallback_location: root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :start_time, :end_time)
    end
end
