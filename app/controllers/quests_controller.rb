class QuestsController < ApplicationController
  before_action :set_quest, only: [ :update, :destroy ]

  def create
    @new_quest = Quest.new(quest_params)
    if @new_quest.save
      @quests = Quest.all
      render turbo_stream: [
        turbo_stream.update("display", partial: "pages/display", locals: { quests: @quests }),
        clean_form
      ]
    else
      render turbo_stream: clean_form
    end
  end

  def update
    @quest.update!(completed: !@quest.completed)
    redirect_to root_path
  end

  def destroy
    @quest.destroy
    # redirect_to root_path
    render turbo_stream: turbo_stream.remove("quest_#{@quest.id}")
  end

  private
    def quest_params
      params.require(:quest).permit(:title)
    end

    def set_quest
      @quest = Quest.find(params[:id])
    end

    def clean_form
      turbo_stream.update(
        "new_quest_form",
        partial: "pages/form",
        locals: { new_quest: Quest.new })
    end
end
