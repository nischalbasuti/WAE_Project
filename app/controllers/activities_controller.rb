class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  skip_before_action :verify_authenticity_token, :only => [ :update_activities ]
  skip_authorize_resource :only => [ :update_activities ]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @requirements = Requirement.order(created_at: :desc).where(activity: @activity)
  end

  # GET /activities/new
  def new
    @activity = Activity.new

    if not params.has_key? :event_id
      flash[:error] = "No Event id given."
      redirect_back fallback_location: root_path
      return
    end
    begin
      @activity.event = Event.find(params[:event_id])
      @activity.start_time = @activity.event.start_time
      @activity.end_time = @activity.event.start_time
    rescue
      flash[:error] = "Couldn't find event with id #{params[:event_id]}"
      redirect_back fallback_location: root_path
      return
    end

  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        if @activity.validates_date :start_time, :after => :now
           format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
           format.json { render :show, status: :ok, location: @activity }
        else 
            flash.alert = "The date is wrong!"
        end
        
        
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_activities
    logger = Logger.new STDOUT
    # event = Event.find(params[:event_id])

    params[:activities].each do |a| 
      activity            = Activity.find(a[:id].to_i)
      activity.start_time = DateTime.parse(a[:startTime])
      activity.end_time   = DateTime.parse(a[:endTime])
      if activity.save
        flash[:alert] = "Updated Activities"
      else 
        flash[:error] = "Failed to update activities"
        render :json => { message: flash[:error] }
        return
      end
    end
    render :json => { message: flash[:alert] }
    return
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:name, :description, :start_time, :end_time, :event_id)
    end
end
