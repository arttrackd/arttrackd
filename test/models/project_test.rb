require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "can get total time worked on a project" do
    project = Project.create!(user_id: users(:one), name: "Cellar Door",
      description: "The most beautiful phrase in the English language")

    start = DateTime.now - 13.hours
    stop = DateTime.now - 9.hours

    entry1 = TimeEntry.create!(project_id: project.id, start_time: start,
        stop_time: stop, total_time: stop.to_i - start.to_i, date: Date.today)

    # entry1 = TimeEntry.create!(project_id: project.id, date: Date.today)

    start = DateTime.now - 8.hours
    stop = DateTime.now

    entry2 = TimeEntry.create!(project_id: project.id, start_time: start,
        stop_time: stop, total_time: stop.to_i - start.to_i, date: Date.today)

    expected_time = entry1.total_time + entry2.total_time
    assert_equal expected_time, project.get_time
  end
end
