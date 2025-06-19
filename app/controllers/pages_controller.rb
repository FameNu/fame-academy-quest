class PagesController < ApplicationController
  def index
    @new_quest = Quest.new
    @quests = Quest.all
  end

  def brag
  end
end
