class Task < ApplicationRecord
  belongs_to :todo

  before_create :set_sequence
  before_validation :set_initial_sequence, on: :create
  before_validation :check_description

  default_scope { order(sequence: :asc) }

  def set_sequence
    return unless self.sequence.blank?
    self.sequence = self.todo.tasks.size
  end

  def check_description
    self.description = self.description if description.blank?
  end

  def adjust_sequence(new_sequence)
    todo = self.todo

    if self.sequence < new_sequence
      todo.tasks.where('sequence > ? AND sequence <= ?', self.sequence, new_sequence).each do |t|
        t.update(sequence: t.sequence - 1)
      end
    else
      todo.tasks.where('sequence >= ? AND sequence < ?', new_sequence, self.sequence).each do |t|
        t.update(sequence: t.sequence + 1)
      end
    end
  end

  def reorder_sequences_after_delete
    self.todo.tasks.where('sequence > ?', sequence).update_all('sequence = sequence - 1')
  end

  def set_initial_sequence
    self.sequence = Task.maximum(:sequence).to_i + 1
  end
end
