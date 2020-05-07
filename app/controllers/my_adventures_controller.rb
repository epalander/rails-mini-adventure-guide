class MyAdventuresController < ApplicationController
  before_action :authenticate_user!

  def index
    @myadventures = MyAdventure.where(user_id: current_user)
    authorize @myadventures
    @saved_adventures = @myadventures.select{ |myadv| myadv[:done] == false }
    @done_adventures = @myadventures.select{ |myadv| myadv[:done] == true }
    @writtenadventures = Adventure.where(user_id: current_user.id)
    @myreviews = Review.where(user_id: current_user)
  end

  def new
    @adventure = Adventure.find(params[:adventure_id])
    @my_adventure = MyAdventure.new
    authorize @my_adventure
    puts 'I am in the new method for my adventure!'
  end

  def create
    puts 'I am in the CREATE method of my adventure!'
    @my_adventure = MyAdventure.new
    authorize @my_adventure
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

  def edit
    @my_adventure = MyAdventure.find(my_adventure_params[:id])
  end

  def update
    @my_adventure = MyAdventure.find(my_adventure_params[:id])
    if @my_adventure.update(my_adventure_params)
        redirect_to my_adventures_path, notice: 'Been there. Done that!'
    else
      redirect_to my_adventures_path, notice: 'Something went wrong...!'
    end
  end

  def destroy
  end

  private
  def my_adventure_params
    params.require(:my_adventure).permit(:my_adventure_id, :user_id, :adventure_id, :authenticity_token, :commit)
  end

end
