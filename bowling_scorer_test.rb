require 'test/unit'
require_relative './bowling_scorer.rb'

class BowlingScorerTest < Test::Unit::TestCase
  def setup
    @scorer = BowlingScorer.new
  end

  def assert_error(game, message)
    assert_raise(RuntimeError.new(message)) { @scorer.score(game) }
  end

  def assert_score(game, score)
    assert_equal(score, @scorer.score(game))
  end

  def test_raises_error_when_game_is_not_string
    assert_error(0, 'Invalid type')
    assert_error(:a, 'Invalid type')
    @scorer.score('X|X|X|X|X|X|X|X|X|X||XX')
  end

  def test_raises_error_when_game_is_invalid
    assert_error('', 'Invalid game')
    assert_error('--|--|--|--|--|--|--|--|--|--|', 'Invalid game')
    assert_error('--|--|--|--|--|--|--|--|--|--|-|', 'Invalid game')
    @scorer.score('--|--|--|--|--|--|--|--|--|--||')
  end

  def test_raises_error_when_frame_size_is_invalid
    assert_error('|--|--|--|--|--|--|--|--|--||', 'Invalid frame: ')
    assert_error('--||--|--|--|--|--|--|--|--||', 'Invalid frame: ')
    assert_error('--|--|---|--|--|--|--|--|--|--||', 'Invalid frame: ---')
    assert_error("/|--|--|--|--|--|--|--|--|--||", 'Invalid frame: /')
    assert_error("--|1|--|--|--|--|--|--|--|--||", 'Invalid frame: 1')
  end

  def test_raises_error_when_frame_hits_are_invalid
    assert_error('-a|--|--|--|--|--|--|--|--|--||', 'Invalid hit: a')
    assert_error('--|-b|--|--|--|--|--|--|--|--||', 'Invalid hit: b')
    assert_error('--|--|c-|--|--|--|--|--|--|--||', 'Invalid hit: c')
    assert_error('a/|--|c-|--|--|--|--|--|--|--||', 'Invalid hit: a')
  end

  def test_calculates_sum_when_all_frames_are_the_same
    assert_score('--|--|--|--|--|--|--|--|--|--||', 0)
    assert_score('-1|-1|-1|-1|-1|-1|-1|-1|-1|-1||', 10)
    assert_score('-2|-2|-2|-2|-2|-2|-2|-2|-2|-2||', 20)
    assert_score('3-|3-|3-|3-|3-|3-|3-|3-|3-|3-||', 30)
  end

  def test_scores_frame_as_ten_when_it_is_strike
    assert_score("X|--|--|--|--|--|--|--|--|--||", 10)
    assert_score("X|--|--|--|--|X|--|--|--|--||", 20)
  end

  def test_scores_frame_as_ten_when_it_is_spare
    assert_score("-/|--|--|--|--|--|--|--|--|--||", 10)
    assert_score("1/|--|--|--|--|--|--|--|--|--||", 10)
  end

  def test_raises_error_when_frame_starts_with_spare
    assert_error("/-|--|--|--|--|--|--|--|--|--||", 'Invalid hit: /')
    assert_error("-/|/-|--|--|--|--|--|--|--|--||", 'Invalid hit: /')
  end

  def test_adds_next_hit_to_frame_score_when_it_is_spare
    assert_score("-/|1-|--|--|--|--|--|--|--|--||", 12)
    assert_score("-/|11|--|--|--|--|--|--|--|--||", 13)
    assert_score("-/|-/|--|--|--|--|--|--|--|--||", 20)
    assert_score("-/|X|--|--|--|--|--|--|--|--||", 30)
  end
end
