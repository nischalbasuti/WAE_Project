class RequirementsController < ApplicationController
  before_action :set_requirement, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /requirements
  # GET /requirements.json 

  def approve
    @requirement.satisfied = true
    @requirement.save
    redirect_back(fallback_location: activity_path(@requirement.activity_id))
    flash.alert = "The requirement has been approved!"
  end

  def unapproved
    # @requirement = Requirement.find_by_id(params[:id])
    @requirement.satisfied = false
    @requirement.save
    redirect_back(fallback_location: activity_path(@requirement.activity_id))
    flash.alert = "The requirement has been unapproved!"    
  end

  def index
    @requirements = Requirement.all
  end

  # GET /requirements/1
  # GET /requirements/1.json
  def show
  end

  # GET /requirements/new
  def new
    @requirement = Requirement.new

    if not params.has_key? :activity_id
      flash[:error] = "No activity id given."
      redirect_back fallback_location: root_path
      return
    end

    begin
      @requirement.activity = Activity.find(params[:activity_id])

      if(not (current_user.coordinator? @requirement.activity.event or current_user.representitive? @requirement.activity.event or current_user.admin? or current_user.chair?))
        redirect_to @requirement.activity
        flash[:error] = "Access denied"
        return
      end
    rescue
      flash[:error] = "Couldn't find activity with id #{params[:event_id]}"
      redirect_back fallback_location: root_path
      return
    end

  end

  # GET /requirements/1/edit
  def edit
  end

  # POST /requirements
  # POST /requirements.json
  def create
    @requirement = Requirement.new(requirement_params)
    
    if(not (current_user.coordinator? @requirement.activity.event or current_user.representitive? @requirement.activity.event or current_user.admin? or current_user.chair?))
      redirect_to @requirement.activity
      flash[:error] = "Access denied"
      return
    end

    respond_to do |format|
      if @requirement.save
        
        format.html { redirect_to @requirement, notice: 'Requirement was successfully created.' }
        format.json { render :show, status: :created, location: @requirement }
      else
        format.html { render :new }
        format.json { render json: @requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requirements/1
  # PATCH/PUT /requirements/1.json
  def update
    respond_to do |format|
      if @requirement.update(requirement_params)
        format.html { redirect_to @requirement, notice: 'Requirement was successfully updated.' }
        format.json { render :show, status: :ok, location: @requirement }
      else
        format.html { render :edit }
        format.json { render json: @requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requirements/1
  # DELETE /requirements/1.json
  def destroy
    @requirement.destroy
    respond_to do |format|
      format.html { redirect_to requirements_url, notice: 'Requirement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requirement
      @requirement = Requirement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requirement_params
      params.require(:requirement).permit(:title, :description, :activity_id)
    end
end
