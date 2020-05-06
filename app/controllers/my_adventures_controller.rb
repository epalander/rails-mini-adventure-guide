class MyAdventuresController < ApplicationController
  before_action :authenticate_user!

  def index
    @myadventures = MyAdventure.where(user_id: current_user)
    @done_adventures = @myadventures.select{ |myadv| myadv[:done] == true }
    @saved_adventures = @myadventures.select{ |myadv| myadv[:done] == false }
  end

  def new
    @adventure = Adventure.find(params[:adventure_id])
    @my_adventure = MyAdventure.new
    puts 'I am in the new method for my adventure!'
  end

  def create
    puts 'I am in the CREATE method of my adventure!'
    @my_adventure = MyAdventure.new
    @my_adventure.user_id = current_user.id
    @my_adventure.adventure_id = my_adventure_params[:adventure_id]
    @my_adventure.done = false
    if @my_adventure.save
      redirect_to my_adventures_path, notice: 'Your adventure was added to your list!'
      puts "we saved my adventure!"
    else
      redirect_to adventure_path(my_adventure_params[:adventure_id]), notice: "Something went wrong. Adventure NOT saved."
    end
  end

  def destroy
  end

  private
  def my_adventure_params
    params.require(:my_adventure).permit(:user_id, :adventure_id, :authenticity_token, :commit)
  end

end
