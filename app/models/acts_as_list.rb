class TodoList < ActiveRecord::Base
    has_many :tasks, -> { order(position: :asc) }
  end
  
  class TodoItem < ActiveRecord::Base
    belongs_to :projects
    acts_as_list scope: :projects
  end
  
  project = TodoList.find(...)
  projects.tasks.first.move_to_bottom
  projects.tasks.last.move_higher

  class AddPositionToTodoItem < ActiveRecord::Migration
    def change
      add_column :tasks, :position, :integer
      TodoItem.order(:updated_at).each.with_index(1) do |task, index|
        task.update_column :position, index
      end
    end
  end