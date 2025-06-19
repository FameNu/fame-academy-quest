module ApplicationHelper
  def sorted_quests(quests)
    quests.sort_by { |q| q.created_at }.reverse
  end
end
