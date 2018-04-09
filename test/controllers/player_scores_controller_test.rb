require 'test_helper'

class PlayerScoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_score = player_scores(:one)
  end

  test "should get index" do
    get player_scores_url
    assert_response :success
  end

  test "should get new" do
    get new_player_score_url
    assert_response :success
  end

  test "should create player_score" do
    assert_difference('PlayerScore.count') do
      post player_scores_url, params: { player_score: { bonus: @player_score.bonus, catches: @player_score.catches, centuries: @player_score.centuries, duck: @player_score.duck, er: @player_score.er, fours: @player_score.fours, maiden: @player_score.maiden, match: @player_score.match, match_id: @player_score.match_id, player_id: @player_score.player_id, runout: @player_score.runout, runs: @player_score.runs, sixes: @player_score.sixes, starting_11: @player_score.starting_11, str: @player_score.str, total: @player_score.total, wkts: @player_score.wkts } }
    end

    assert_redirected_to player_score_url(PlayerScore.last)
  end

  test "should show player_score" do
    get player_score_url(@player_score)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_score_url(@player_score)
    assert_response :success
  end

  test "should update player_score" do
    patch player_score_url(@player_score), params: { player_score: { bonus: @player_score.bonus, catches: @player_score.catches, centuries: @player_score.centuries, duck: @player_score.duck, er: @player_score.er, fours: @player_score.fours, maiden: @player_score.maiden, match: @player_score.match, match_id: @player_score.match_id, player_id: @player_score.player_id, runout: @player_score.runout, runs: @player_score.runs, sixes: @player_score.sixes, starting_11: @player_score.starting_11, str: @player_score.str, total: @player_score.total, wkts: @player_score.wkts } }
    assert_redirected_to player_score_url(@player_score)
  end

  test "should destroy player_score" do
    assert_difference('PlayerScore.count', -1) do
      delete player_score_url(@player_score)
    end

    assert_redirected_to player_scores_url
  end
end
