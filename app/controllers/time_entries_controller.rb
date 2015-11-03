class TimeEntriesController < ApplicationController
  before_action :require_login
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy]

  # GET /time_entries
  def index
    @project = Project.find(params[:id])
    @time_entries = TimeEntry.where('project_id = ?', @project.id)
    @time_entries_day = @time_entries.where('date > ?', Time.current - 29.hours)
    @time_entries_week = @time_entries.where('date > ?', 1.week.ago)
    @time_entries_month = @time_entries.where('date > ?', 1.month.ago)
  end

  # GET /time_entries/1
  def show
  end

  # GET /time_entries/1/edit
  def edit
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

  def clock_in
    @time_entry = TimeEntry.new(time_entry_params)
    @time_entry.start_time = Time.zone.now
    @time_entry.save
    redirect_to project_path(@time_entry.project_id), notice: "Time entry started"
  end

  def clock_out
    @time_entry = TimeEntry.where('project_id = ?', params[:time_entry][:project_id]).last
    if @time_entry.stop_time
      redirect_to project_path(@time_entry.project_id),
        alert: 'You must clock in first!'
    else
      start = @time_entry.start_time
      @time_entry.update(stop_time: Time.zone.now,
      date: Time.zone.now.to_date,
      total_time: (Time.zone.now - start).round)
      redirect_to project_path(@time_entry.project_id), notice: 'Time entry was successfully saved.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_entry
      @time_entry = TimeEntry.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def time_entry_params
      params.require(:time_entry).permit(:start_time, :stop_time, :total_time, :date, :project_id)
    end
end
