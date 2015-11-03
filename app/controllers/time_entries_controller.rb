class TimeTimeEntriesController < ApplicationController
  before_action :require_login
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy]

    # GET /time_entries
    def index
      @time_entries = TimeEntry.all
      @time_entries_day = @time_entries.where('date > ?', Time.current - 29.hours)
      @time_entries_week = @time_entries.where('date > ?', 1.week.ago)
      @time_entries_month = @time_entries.where('date > ?', 1.month.ago)
    end

    # GET /time_entries/1
    def show
    end

    # GET /time_entries/new
    def new

    end

    # GET /time_entries/1/edit
    def edit
    end

    # POST /time_entries
    def create
      @time_entry = TimeEntry.create(time_entry_params)

      redirect_to time_entries_path, notice: 'TimeEntry was successfully created.'
    end

    # PATCH/PUT /time_entries/1
    def update
      if @time_entry.update(time_entry_params)
        redirect_to @time_entry, notice: 'TimeEntry was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /time_entries/1
    def destroy
      @time_entry.destroy
      redirect_to time_entries_url, notice: 'TimeEntry was successfully destroyed.'
    end

    def clock_in
      @time_entry = TimeEntry.new(start_time: Time.current)
      @time_entry.save
      flash[:notice] = "Time time_entry started"
      redirect_to time_entries_path
    end

    def clock_out
      @time_entry = TimeEntry.last
      start = @time_entry.start_time
      @time_entry.update(stop_time: Time.zone.now,
      date: Time.zone.now.to_date,
      total_time: (Time.zone.now - start).round)
      redirect_to time_entries_path, notice: 'TimeEntry was successfully saved.'
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
end
