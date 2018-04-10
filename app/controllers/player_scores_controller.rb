class PlayerScoresController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]

  # GET /player_scores
  # GET /player_scores.json
  def index
    @player_scores = PlayerScore.all
  end

  # GET /player_scores/1
  # GET /player_scores/1.json
  def show
      @player_scores = PlayerScore.where(player_id: params[:id])
  end

  # GET /player_scores/new
  def new
    @player_score = PlayerScore.new
  end

  # GET /player_scores/1/edit
  def edit
  end

  # POST /player_scores
  # POST /player_scores.json
  def create
    @player_score = PlayerScore.new(player_score_params)

    respond_to do |format|
      if @player_score.save
        format.html { redirect_to @player_score, notice: 'Player score was successfully created.' }
        format.json { render :show, status: :created, location: @player_score }
      else
        format.html { render :new }
        format.json { render json: @player_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_scores/1
  # PATCH/PUT /player_scores/1.json
  def update
    respond_to do |format|
      if @player_score.update(player_score_params)
        format.html { redirect_to @player_score, notice: 'Player score was successfully updated.' }
        format.json { render :show, status: :ok, location: @player_score }
      else
        format.html { render :edit }
        format.json { render json: @player_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_scores/1
  # DELETE /player_scores/1.json
  def destroy
    @player_score.destroy
    respond_to do |format|
      format.html { redirect_to player_scores_url, notice: 'Player score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_score
      @player_score = PlayerScore.where(player_id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_score_params
      params.require(:player_score).permit(:player, :Starting_11)
    end
end
