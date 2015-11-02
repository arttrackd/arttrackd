class TimeEntriesController < ApplicationController
  before_action :require_login
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy]

  # GET /time_entries
  def index
    @time_entries = TimeEntry.all
  end

  # GET /time_entries/1
  def show
  end

  # GET /time_entries/new
  def new
    @time_entry = TimeEntry.new
  end

  # GET /time_entries/1/edit
  def edit
  end

  # POST /time_entries
  def create
    @time_entry = TimeEntry.new(time_entry_params)

    if @time_entry.save
      redirect_to @time_entry, notice: 'Time entry was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /time_entries/1
  def update
    if @time_entry.update(time_entry_params)
      redirect_to @time_entry, notice: 'Time entry was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /time_entries/1
  def destroy
    @time_entry.destroy
    redirect_to time_entries_url, notice: 'Time entry was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_entry
      @time_entry = TimeEntry.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def time_entry_params
      params.require(:time_entry).permit(:project_id, :start_time, :date)
    end
end
