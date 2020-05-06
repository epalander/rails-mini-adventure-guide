class MyAdventuresController < ApplicationController
  def index
    @myadventures = MyAdventure.where(user_id: current_user)
    @saved_adventures = MyAdventure.all
    @done_adventures = MyAdventure.where(:done == true)
  end

  def new
    @adventure = Adventure.find(params[:adventure_id])
    @my_adventure = MyAdventure.new
    puts 'I am in the new method for my adventure!'
  end

  def create
    puts 'I am in the CREATE method of my adventure!'
    @my_adventure = My_Adventure.new
    @adventure = Adventure.find(params[:adventure_id])
    @my_adventure.user_id = current_user.id
    @my_adventure.adventure_id = @adventure.id
    render 'adventures/show'
    if @my_adventure.save
      redirect_to adventure_path(@adventure)
    else
      render :new
    end
  end

  def destroy
  end

end
