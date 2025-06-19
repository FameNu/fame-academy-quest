class PagesController < ApplicationController
  def index
    @quests = Quest.all.sort_by { |q| q.created_at }.reverse
  end

  def brag
  end
end
