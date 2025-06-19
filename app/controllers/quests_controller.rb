class QuestsController < ApplicationController
  before_action :set_quest, only: [ :update, :destroy ]

  def create
    quest = Quest.new(quest_params)
    if quest.save
      redirect_to root_path, notice: "Quest was successfully created."
    else
      redirect_to root_path, alert: "Failed to create quest."
    end
  end

  def update
    @quest.update!(completed: !@quest.completed)
    redirect_to root_path
  end

  def destroy
    @quest.destroy
    redirect_to root_path
  end

  private
    def quest_params
      params.require(:quest).permit(:title)
    end

    def set_quest
      @quest = Quest.find(params[:id])
    end
end
