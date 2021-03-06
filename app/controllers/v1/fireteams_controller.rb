module V1
  class FireteamsController < ApplicationController
    # before_action :set_lfg_post, only: [:show, :update, :destroy]
    # before_action :authenticate_user!, only: [ :validate_user, :destroy]
    def validate_player
      puts params
      render json: Fireteam.validate_player(params[:user], params[:platform])
    end

    def create
    end

    def show
    end

    def update
    end

    def destroy
    end

    def stats
      @character_stats = Fireteam.get_player_stats(params[:platform], params[:membership_id])
      render json: @character_stats
    end

    def team

      #find player account details
      # params[:player_name]
      begin
        response = Typhoeus.get(
            "https://www.bungie.net/Platform/Destiny2/SearchDestinyPlayer/#{params[:platform]}/#{params[:player_name]}/",            
            headers: {"x-api-key" => ENV['API_TOKEN']}
        )
                
        data = JSON.parse(response.body)
        render json: Fireteam.get_recent_activity(data)
        # params[:platform]
        # find pgcr of last trials match
      rescue StandardError => e
        render json: {error: e}
      end


    end

  end
end