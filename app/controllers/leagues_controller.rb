class LeaguesController < ApplicationController
  before_action :set_league, only: [:show, :edit, :update, :destroy]

  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = League.all
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
    @captains = {}
    @vice_captains = {}
    @total = {}
    @top11 = {}
    @users = {}
    @players = TeamPlayer.where(league_id: @league.id).group_by(&:user_id)

      @players.each do |user_id, players|
        @users[user_id] = players.first.user
        sum = 0
        scores = []
        players.each do |playert|
          total = playert.player.player_scores.sum(:total)
          score = 0
          if(playert.is_captain)
            score = (total * 2)
            sum = sum + score
            @captains[user_id]= playert
          elsif(playert.is_vice_captain)
            score = (total * 1.5)
            sum = sum + score
            @vice_captains[user_id]= playert
          else
            score = total
            sum = sum + total
          end
          scores << score
        end
        scores = scores.sort.reverse
        index = if(scores.length >= 10)then 10 else scores.length end
        top11Sum = 0
        for i in 0..index
          if(scores[i]!=nil)
            top11Sum = top11Sum + scores[i]
          end
        end
        @top11[user_id] = top11Sum
        @total[user_id] = sum
      end

      # @total = @total.sort_by {|k, v| v}.reverse
      @top11 = @top11.sort_by {|k, v| v}.reverse
      p(@users);

  end


  # GET /leagues/new
  def new
    @league = League.new
  end

  # GET /leagues/1/edit
  def edit
  end

  # POST /leagues
  # POST /leagues.json
  def create
    @league = League.new(league_params)

    respond_to do |format|
      if @league.save
        format.html { redirect_to @league, notice: 'League was successfully created.' }
        format.json { render :show, status: :created, location: @league }
      else
        format.html { render :new }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leagues/1
  # PATCH/PUT /leagues/1.json
  def update
    respond_to do |format|
      if @league.update(league_params)
        format.html { redirect_to @league, notice: 'League was successfully updated.' }
        format.json { render :show, status: :ok, location: @league }
      else
        format.html { render :edit }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league.destroy
    respond_to do |format|
      format.html { redirect_to leagues_url, notice: 'League was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league
      @league = League.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def league_params
      params.require(:league).permit(:name)
    end
end
