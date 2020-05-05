class MyAdventuresController < ApplicationController
  def index
  end

  def new
    @adventure = Adventure.find(params[:adventure_id])
    @my_adventure = MyAdventure.new
  end

  def create
    @my_adventure = My_Adventure.new
    @my_adventure.user_id = current_user.id
    @my_adventure.adventure_id = @adventure.id
    if @my_adventure.save
      redirect_to adventure_path(@adventure)
    else
      render :new
    end
  end

  def destroy
  end

end
