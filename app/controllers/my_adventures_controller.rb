class MyAdventuresController < ApplicationController
  def index
    @myadventures = MyAdventure.where(user_id: current_user)
    @done_adventures = @myadventures.select{ |myadv| myadv[:done] == true }
    @saved_adventures = @myadventures.select{ |myadv| myadv[:done] == false }
  end
end
