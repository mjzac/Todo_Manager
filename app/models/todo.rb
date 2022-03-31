class Todo < ActiveRecord::Base
  def to_pleasant_string
    is_completed = completed ? "[x]": "[]"
    "#{id}. #{due_date.to_fs} #{todo_text} #{is_completed}"
  end
end
