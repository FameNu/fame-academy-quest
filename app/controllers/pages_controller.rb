class PagesController < ApplicationController
  def index
    @new_quest = Quest.new
    @quests = Quest.all.sort_by { |q| q.created_at }.reverse
  end

  def brag
  end
end
