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
    # @my_adventure.user_id = current_user.id
    # @my_adventure.adventure_id = @adventure.id
    if @my_adventure.save
      notice: 'Your adventure was added to your list!'
    else
      notice: 'Your adventure was NOT added. Something went wrong.'
    end
  end

  def destroy
  end

end
