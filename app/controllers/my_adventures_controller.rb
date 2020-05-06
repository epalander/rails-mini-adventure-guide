class MyAdventuresController < ApplicationController
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
    puts "printing params"
    p my_adventure_params
    p params[:user_id]
    p params[:adventure_id]
    p current_user
    @my_adventure.user_id = current_user.id
    @my_adventure.adventure_id = params[:adventure_id]
    p @my_adventure
    if @my_adventure.save
      redirect_to my_adventures_path, notice: 'Your adventure was added to your list!'
      puts "we saved my adventure!"
    else
      # render :new, notice: 'Your adventure was NOT added. Something went wrong.'
      redirect_to my_adventures_path, notice: "something went wrong"
    end
  end

  def destroy
  end

  private
  def my_adventure_params
    params.permit(:user_id, :adventure_id, :authenticity_token, :commit)
  end

end
