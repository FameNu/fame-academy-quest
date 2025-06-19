class QuestsController < ApplicationController
  def create
    quest = Quest.new(quest_params)
    if quest.save
      redirect_to root_path, notice: "Quest was successfully created."
    else
      redirect_to root_path, alert: "Failed to create quest."
    end
  end

  def update
  end

  def destroy
  end

  private
    def quest_params
      params.require(:quest).permit(:title)
    end
end
